{ pkgs, ... }:
{
  home.packages = [
    pkgs.feh
    pkgs.wireplumber
    pkgs.pulseaudio
    pkgs.sound-theme-freedesktop
    pkgs.networkmanager
    pkgs.networkmanagerapplet
  ];
  xsession.enable = true;
  xsession.initExtra = ''
    st &
    librewolf &
    nm-applet &
    feh --bg-scale ~/Pictures/background.png &

    statedir="/tmp/dwmstatus-$USER"
    mkdir -p "$statedir"
    bat_state="$statedir/bat"
    vol_state="$statedir/vol"
    vol_last="$statedir/vol_last"
    net_state="$statedir/net"
    echo " 0%" > "$bat_state"
    echo " 0%" > "$vol_state"
    echo "" > "$vol_last"
    echo "" > "$net_state"

    sound_file="${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/audio-volume-change.oga"

    render() {
      xsetroot -name "  $(cat "$net_state")  |  $(cat "$vol_state")  |  $(cat "$bat_state")  |  $(date '+%H:%M:%S')  |  $(date '+%d/%m/%Y')  "
    }

    update_battery() {
      battery=$(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null)
      charging=$(cat /sys/class/power_supply/BAT1/status 2>/dev/null)

      icons=(
        $'\U000F007A' $'\U000F007A' $'\U000F007B' $'\U000F007C' $'\U000F007D'
        $'\U000F007E' $'\U000F007F' $'\U000F0080' $'\U000F0081' $'\U000F0079'
      )
      tier=$(( battery / 10 ))
      [ "$tier" -gt 9 ] && tier=9
      bat_icon="''${icons[$tier]}"
      [ "$charging" == "Charging" ] && bat_icon="󰂄"

      echo "''${bat_icon} ''${battery}%" > "$bat_state"
    }

    update_network() {
      eth=$(nmcli -t -f TYPE,STATE dev | grep '^ethernet:connected')

      if [ -n "$eth" ]; then
        echo $'\U000F0200' > "$net_state"
        return
      fi

      wifi_line=$(nmcli -t -f ACTIVE,SIGNAL dev wifi | grep '^yes')
      signal=$(echo "$wifi_line" | cut -d: -f2)

      if [ -z "$signal" ]; then
        echo $'\U000F08FC' > "$net_state"
        return
      fi

      wifi_icons=($'\U000F08F4' $'\U000F08F6' $'\U000F08F8' $'\U000F08FA')
      tier=$(( signal / 25 ))
      [ "$tier" -gt 3 ] && tier=3
      echo "''${wifi_icons[$tier]}" > "$net_state"
    }

    update_volume() {
      vol_raw=$(wpctl get-volume @DEFAULT_SINK@)
      vol_frac=$(echo "$vol_raw" | grep -oP '\d+\.\d+')
      vol=$(printf '%.0f' "$(echo "$vol_frac * 100" | bc)")

      if echo "$vol_raw" | grep -q 'MUTED'; then
        vol_icon=$'\ueee8'
        muted="yes"
      else
        vol_icon=$'\uf028'
        muted="no"
      fi

      new_state="''${vol}-''${muted}"
      old_state=$(cat "$vol_last")

      echo "''${vol_icon} ''${vol}%" > "$vol_state"

      if [ "$new_state" != "$old_state" ]; then
        echo "$new_state" > "$vol_last"
        paplay "$sound_file" &
        render
      fi
    }

    ( while true; do
        update_battery
        update_network
        render
        sleep 1
      done ) &

    ( update_volume
      pactl subscribe 2>/dev/null | while read -r line; do
        case "$line" in
          *sink*) update_volume ;;
        esac
      done ) &
  '';
}

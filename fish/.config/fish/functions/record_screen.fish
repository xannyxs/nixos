function record_screen
    set target_process wl-screenrec

    if pgrep $target_process >/dev/null
        killall $target_process
        if test $status -eq 0
            notify-send -i ~/.config/fish/icons/camera_mp4_icon.png "Recording Stopped 󰙧 " -t 2000
        else
            notify-send -i ~/.config/fish/icons/error_icon.png "Failed to Stop Recording" -t 2000
        end
    else
        set geometry (slurp)
        if not [ -z $geometry ]
            set record_name (echo "record-$(date +"%Y-%m-%d--%H:%M:%S")")
            set output_file "$HOME/Videos/Records/$record_name.mp4"
            
            notify-send -i ~/.config/fish/icons/camera_mp4_icon.png "Recording Started" -t 2000
            
            wl-screenrec -g "$geometry" -f "$output_file" &
            set pid $last_pid

            if ps -p $pid > /dev/null
                wl-copy -t text/uri-list file://$output_file
            else
                notify-send -i ~/.config/fish/icons/error_icon.png "Failed to Start Recording" -t 2000
            end
        else
            notify-send -i ~/.config/fish/icons/error_icon.png "No Area Selected" -t 2000
        end
    end
end

function record_fullscreen
    set target_process wl-screenrec

    if pgrep $target_process >/dev/null
        killall $target_process
        if test $status -eq 0
            notify-send -i ~/.config/fish/icons/camera_mp4_icon.png "Full Screen Recording Stopped 󰙧 " -t 2000
        else
            notify-send -i ~/.config/fish/icons/error_icon.png "Failed to Stop Full Screen Recording" -t 2000
        end
    else
        set record_name (echo "fullscreen-record-$(date +"%Y-%m-%d--%H:%M:%S")")
        set output_file "$HOME/Videos/Records/$record_name.mp4"
        
        notify-send -i ~/.config/fish/icons/camera_mp4_icon.png "Full Screen Recording Started" -t 2000
        
        # Get the dimensions of the primary display
        set geometry (swaymsg -t get_outputs | jq -r '.[] | select(.focused) | "\(.rect.width)x\(.rect.height)+0+0"')
        
        wl-screenrec -g "$geometry" -f "$output_file" &
        set pid $last_pid

        if ps -p $pid > /dev/null
            wl-copy -t text/uri-list file://$output_file
        else
            notify-send -i ~/.config/fish/icons/error_icon.png "Failed to Start Full Screen Recording" -t 2000
        end
    end
end

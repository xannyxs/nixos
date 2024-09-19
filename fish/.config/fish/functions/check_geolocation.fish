function check_geolocation 
    set target_process "geoclue"
    
    if pgrep $target_process > /dev/null
        echo "{\"text\":\"󰆤\", \"tooltip\":\"Geopositioning\", \"alt\":\"Geo\"}"
    end
end

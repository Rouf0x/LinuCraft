args = {...}

local sound = args[1]

if peripheral.find("speaker") then
    if sound then
        if sound == "stop" then
            peripheral.find("speaker").playSound(sound)
            print("Stopped.")
        else
            peripheral.find("speaker").playSound(sound)
            print("Played '"..sound.."'")
        end
    else
        print("Usage: beep [sound]/stop")
        print("Played 'entity.arrow.hit_player'")
        peripheral.find("speaker").playSound("entity.arrow.hit_player") 
    end
else
    term.setTextColor(colors.red)
    print("A speaker is required for this command!")
    term.setTextColor(colors.white)
end

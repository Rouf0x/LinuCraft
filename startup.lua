local settingsFile = "OS/settings.txt"

local settings = {
    { name = "Update on startup", key = "update_startup", checked = false },
    { name = "Dummy setting 2", key = "dummy_setting_2", checked = false }
}

local selectedSetting = 1

local function loadSettings()
    if fs.exists(settingsFile) then
        local file = fs.open(settingsFile, "r")
        local data = textutils.unserialize(file.readAll())
        file.close()

        for _, setting in ipairs(settings) do
            if data[setting.key] ~= nil then
                setting.checked = data[setting.key]
            end
        end
    end
end

local function saveSettings()
    local data = {}

    for _, setting in ipairs(settings) do
        data[setting.key] = setting.checked
    end

    local file = fs.open(settingsFile, "w")
    file.write(textutils.serialize(data))
    file.close()
end

local function drawMenu()
    term.clear()
    term.setCursorPos(1, 1)
    print(" - Settings - \n")
    print("Press up/down to navigate, space to toggle, enter to confirm.\n")
    print("Select a setting to toggle:")
    
    for i, setting in ipairs(settings) do
        local checkbox = setting.checked and "[X]" or "[ ]"
        if i == selectedSetting then
            term.setTextColor(colors.yellow)
            print(checkbox .. " // " .. setting.name)
            term.setTextColor(colors.white)
        else
            print(checkbox .. " // " .. setting.name)
        end
    end
end

local function toggleSetting()
    settings[selectedSetting].checked = not settings[selectedSetting].checked
end

-- Load settings on startup
loadSettings()

while true do
    drawMenu()
    local event, key = os.pullEvent("key")
    
    if key == keys.up then
        selectedSetting = selectedSetting > 1 and selectedSetting - 1 or #settings
    elseif key == keys.down then
        selectedSetting = selectedSetting < #settings and selectedSetting + 1 or 1
    elseif key == keys.space then
        toggleSetting()
    elseif key == keys.enter then
        saveSettings()
        break
    end
end

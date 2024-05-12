term.clear()
print("Updating LinuCraft...")

local function getFileContents(url)
    local request = http.get(url)
    if request then
        local contents = request.readAll()
        request.close()
        return contents
    else
        return nil
    end
end

local function updateFile(filePath, fileUrl)
    if filePath == "user.txt" then
        return
    end

    local currentContents = ""
    if fs.exists(filePath) then
        local file = fs.open(filePath, "r")
        currentContents = file.readAll()
        file.close()
    end

    local newContents = getFileContents(fileUrl)
    if newContents then
        if currentContents ~= newContents then
            local file = fs.open(filePath, "w")
            file.write(newContents)
            file.close()
            print("[Updated]", filePath)
            if peripheral.find("speaker") then
                peripheral.find("speaker").playSound("entity.arrow.hit_player") 
            end
        else
            print("[Unchanged]", filePath)
        end
    else
        print("Failed to download file: " .. fileUrl)
    end
end

print("")
term.setTextColor(colors.green)
shell.run("pastebin get 4nRg9CHU json")
print("")
os.loadAPI("/json")

local apiUrl = "https://api.github.com/repos/Rouf0x/LinuCraft/git/trees/main?recursive=1"
local request = http.get(apiUrl)

if request then
    local contents = json.decode(request.readAll())
    request.close()

    if contents and contents.tree then
        for _, file in ipairs(contents.tree) do
            if file.type == "blob" then
                local fileUrl = "https://raw.githubusercontent.com/Rouf0x/LinuCraft/main/" .. file.path
                updateFile(file.path, fileUrl)
            end
        end
    else
        print("Failed to parse API response.")
    end
else
    print("Failed to make API request: " .. apiUrl)
end

print("")
print("Update completed!")

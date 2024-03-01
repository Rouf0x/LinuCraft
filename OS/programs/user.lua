args = {...}

local action = args[1]
local name = args[2]
local filePath = "OS/user.txt"  -- Replace with the actual path to your file

if action == "set" and name ~= nil then
    -- Open the file in write mode to clear its contents
    local file = io.open(filePath, "w")
    file:close()

    -- Open the file again in append mode to write "hi"
    file = io.open(filePath, "a")
    file:write(name)
    file:close()

    print("Username changed! Please reboot for it to take effect.")

elseif action == "clear" then
    print("Username cleared.")
    -- Open the file in write mode to clear its contents
    local file = io.open(filePath, "w")
    file:close()
    file = io.open(filePath, "a")
    file:write("root")
    file:close()
else
    print("Usages: \n user set \n user clear")
end

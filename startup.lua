os.pullEvent = os.pullEventRaw

shell.setPath(shell.path() .. ":/OS/programs")
local label = os.getComputerLabel()

local userPath = "OS/user.txt"
local file = io.open(userPath, "r")

if file then
    username = file:read("*a")
    file:close()
else
    print("Error: Unable to retrieve Username")
end

term.clear()
term.setCursorPos(1,1)
print("LinuCraft ver0.0.1")

while true do

    term.setTextColor(colors.green)
    term.write(username.. "@" .. label)
    term.setTextColor(colors.white)
    term.write(":")
    term.setTextColor(colors.blue)

    local pathSeparator = (shell.dir() == "") and "" or "/"
    term.write("~" .. pathSeparator..shell.dir() .. " " .. "$ ")

    term.setTextColor(colors.white)
    local input = read()

    if input == "help" then
        shell.run("OS/programs/help")
    elseif input == "about" then
        shell.run("OS/programs/about")
    else
        shell.run(input)
    end
end
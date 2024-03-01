os.pullEvent = os.pullEventRaw

function kernelPanic(reason, log)

    if fs.exists("CrashLOG.txt") then
        local file = io.open("CrashLOG.txt", "r")
        print("The system has encountered another kernelPanic.")
        print("kernelPanic loop detected, booting into craftOS...")
        print("\nIf the problem persist you may have to reinstall LinuCraft")
        sleep(5)
        shell.run("rm CrashLOG.txt")
        shell.run("shell")
    else
        --local file = io.open("CrashLOG.txt", "r")
        local file = fs.open("CrashLOG.txt", "w")
        file.write("CRASH_DETECTED")
        file.close()
    end

    term.clear()
    term.setCursorPos(1,1)
    term.setBackgroundColour(colors.black)
    term.setTextColor(colors.white)
    print("A fatal error made LinuCraft crash!")
    term.setTextColor(colors.red)
    print(log, "<--")
    term.setTextColor(colors.white)
    print("Kernel panic - " .. reason)
    print("\nPlease reboot LinuCraft or press any key to continue.")
    os.pullEvent("key")
    print("\nShutting down...")
    sleep(3)
    os.shutdown()
end

shell.setPath(shell.path() .. ":/OS/programs")
local label = os.getComputerLabel()

local userPath = "OS/user.txt"
local file = io.open(userPath, "r")

if file then
    username = file.read(file)
    file.close(file)
else
    print("Error: Unable to retrieve Username")
end

term.clear()
term.setCursorPos(1,1)
print("LinuCraft 0.2")

while true do

    term.setTextColor(colors.green)

    if label ~= nil and username ~= nil then
        term.write(username.. "@" .. label) 
    else
        kernelPanic("001 | NO LABEL/USERNAME", "term.write(username.. \"@\" .. label)")
    end

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

::start::

term.clear()
term.setCursorPos(1,1)

term.clearLine()

print("Welcome to image viewer!")
print("")
print("Please type the image path to display. (X to exit.)")
print("Here is the list of images found: ")
print("")

local function checkForNfp(directory)
  local files = fs.list(directory)
  local found = false

  for i = 1, #files do
    local fullPath = fs.combine(directory, files[i])

    if fs.isDir(fullPath) then
      -- If the item is a directory, recursively check its contents
      found = checkForNfp(fullPath) or found
    elseif files[i]:match("%.nfp$") then
      found = true
      print(fullPath)
    end
  end

  return found
end

local foundInDirectory = checkForNfp("/")
if not foundInDirectory then
  print("No files with the .nfp extension found.")
end

::startB::
print("")
term.write("File path: ")
local input = read()

if input == "x" then
  os.reboot()
elseif input == "X" then
  os.reboot()
end

if fs.exists(input) and input:match("%.nfp$") then
  local image = paintutils.loadImage(input)
  term.clear()
  paintutils.drawImage(image, 1, 1)

  term.setCursorPos(1, 1)
  term.setBackgroundColour(colors.red)
  term.write("X")

  local evt, button, x, y = os.pullEvent("mouse_click")
  if x == 1 and y == 1 then
    term.setBackgroundColour(colors.black)
    goto start
  end
else
  print("File does not exist or does not have the .nfp extension.")
  goto startB
end

-- Function to swap capture groups in clipboard
local function insertReturnSequence()
  local clipboard = hs.pasteboard.getContents()
  if not clipboard then
    hs.alert.show("No clipboard content")
    return
  end

  local pattern = "([%w%.%/%s%_]+)%s*%-%-?>>%s*([%w%.%/%s%_]+)%s*:%s*.*"
  local capture_1, capture_2 = string.match(clipboard, pattern)

  if not capture_1 or not capture_2 then
    hs.alert.show("Did not match on clipboard content")
  end

  local function trim(s)
    return s:match "^%s*(.-)%s*$"
  end

  local result = ""
  if capture_1 and capture_2 then
    result = trim(capture_2) .. " -->> " .. trim(capture_1) .. ": ()"
  end

  if result ~= clipboard then
    hs.pasteboard.setContents(result)
    hs.timer.doAfter(0.1, function()
      hs.eventtap.keyStroke({ "cmd" }, "v")
    end)
    hs.alert.show("Inserted return statement for sequence diagram")
  else
    hs.alert.show("No matches found")
  end
end

-- Bind to a hotkey (Cmd+Shift+S)
hs.hotkey.bind({ "cmd", "option", "control" }, "r", insertReturnSequence)

-- Hammerflow
hs.loadSpoon 'Hammerflow'
spoon.Hammerflow.loadFirstValidTomlFile {
  'flow.toml',
  'Spoons/Hammerflow.spoon/sample.toml',
}

local windows = require 'windows'

spoon.Hammerflow.registerFunctions(windows.windowFunctions)

-- NOTE(ljj): I think this is another (prob widely used) spoon
-- https://github.com/Hammerspoon/Spoons/raw/master/Spoons/ReloadConfiguration.spoon.zip
-- optionally respect auto_reload setting in the toml config.
-- if spoon.Hammerflow.auto_reload then
--   hs.loadSpoon("ReloadConfiguration")
--   -- set any paths for auto reload
--   -- spoon.ReloadConfiguration.watch_paths = {hs.configDir, "~/path/to/my/configs/"}
--   spoon.ReloadConfiguration:start()
-- end

-- TODO(ljj): Move this to a mermaid.lua file and load.
local function insertReturnSequence()
  local clipboard = hs.pasteboard.getContents()
  if not clipboard then
    hs.alert.show 'No clipboard content'
    return
  end

  local pattern = '([%w%.%/%s%_]+)%s*%-%-?>>%s*([%w%.%/%s%_]+)%s*:%s*.*'
  local capture_1, capture_2 = string.match(clipboard, pattern)

  if not capture_1 or not capture_2 then
    hs.alert.show 'Did not match on clipboard content'
  end

  local function trim(s)
    return s:match '^%s*(.-)%s*$'
  end

  local result = ''
  if capture_1 and capture_2 then
    result = trim(capture_2) .. ' -->> ' .. trim(capture_1) .. ': ()'
  end

  if result ~= clipboard then
    hs.pasteboard.setContents(result)
    hs.timer.doAfter(0.1, function()
      hs.eventtap.keyStroke({ 'cmd' }, 'v')
    end)
    hs.alert.show 'Inserted return statement for sequence diagram'
  else
    hs.alert.show 'No matches found'
  end
end

-- Bind to a hotkey (Cmd+Shift+S)
hs.hotkey.bind({ 'cmd', 'option', 'control' }, 'r', insertReturnSequence)

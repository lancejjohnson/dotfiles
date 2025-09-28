local M = {}

local movewindow = function(target)
  if not target then
    hs.notify.show('Hammerflow', 'not found', 'unknown target')
  end
  local w = hs.window.focusedWindow()
  w:move(target)
end

M.windowFunctions = {
  ['left25'] = function()
    movewindow(hs.layout.left25)
  end,
  ['left30'] = function()
    movewindow(hs.layout.left30)
  end,
  ['left50'] = function()
    movewindow(hs.layout.left50)
  end,
  ['left70'] = function()
    movewindow(hs.layout.left70)
  end,
  ['left75'] = function()
    movewindow(hs.layout.left75)
  end,
  ['maximized'] = function()
    movewindow(hs.layout.maximized)
  end,
  ['right25'] = function()
    movewindow(hs.layout.right25)
  end,
  ['right30'] = function()
    movewindow(hs.layout.right30)
  end,
  ['right50'] = function()
    movewindow(hs.layout.right50)
  end,
  ['right70'] = function()
    movewindow(hs.layout.right70)
  end,
  ['right75'] = function()
    movewindow(hs.layout.right75)
  end,
}

return M

local M = {}

-- Functions for making some mermaid js stuff easier

function M.insertReturnSequence()
  local clipboard = hs.pasteboard.getContents()
  if not clipboard then
    hs.alert.show 'Copy the call sequence to clipboard'
    return
  end

  local functionCallPattern = '([%w%.%/%s%_]+)%s*%-%-?>>%s*([%w%.%/%s%_]+)%s*:%s*.*'
  local caller, called = string.match(clipboard, functionCallPattern)

  local function trim(s)
    return (s:gsub('^%s+', ''):gsub('%s+$', ''))
  end

  if caller and called then
    local returnSequence = trim(called) .. ' -->> ' .. trim(caller) .. ': ()'

    print(returnSequence)

    if returnSequence ~= clipboard then
      hs.pasteboard.setContents(returnSequence)
      hs.timer.doAfter(0.1, function()
        hs.eventtap.keyStroke({ 'cmd' }, 'v')
      end)
      hs.alert.show 'Inserted return statement for sequence diagram'
    else
      hs.alert.show 'Cannot insert. Return statement matches copied statement'
    end
  else
    hs.alert.show 'Could not find caller or called function to swap'
  end
end

return M

-- Hammerflow
hs.loadSpoon 'Hammerflow'
spoon.Hammerflow.loadFirstValidTomlFile {
  'flow.toml',
  'Spoons/Hammerflow.spoon/sample.toml',
}

local windows = require 'windows'
local mermaid = require 'mermaid'

local mermaidFunctions = {
  ['insertReturnSequence'] = function()
    mermaid.insertReturnSequence()
  end,
}

spoon.Hammerflow.registerFunctions(windows.windowFunctions, mermaidFunctions)

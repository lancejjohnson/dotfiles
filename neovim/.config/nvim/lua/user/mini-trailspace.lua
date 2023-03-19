local status_ok, trailspace = pcall(require, "mini.trailspace")
if not status_ok then
  vim.notify("could not load mini.trailspace")
  return
end

trailspace.setup({only_in_normal_buffers = true})


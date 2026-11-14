return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  event = "VeryLazy",
  opts = {
    editor = {
      tooltip = "LazyVim",
    },
    display = {
      theme = "default",
    },
    idle = {
      enabled = true,
      timeout = 300000, -- ms
    },
  },
}

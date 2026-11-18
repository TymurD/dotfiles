return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  event = "VeryLazy",
  opts = {
    editor = {
      tooltip = "LazyVim",
    },
    display = {
      theme = "default", -- or "atom", "catppuccin", "minecraft", etc.
    },
    idle = {
      enabled = true,
      timeout = 300000, -- ms
    },
  },
}

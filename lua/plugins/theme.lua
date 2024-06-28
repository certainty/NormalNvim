return {
{
    "catppuccin/nvim",
    event = "User LoadColorSchemes",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
        -- mantle = "#11111b",
				--	crust = "#000000",
        },
      },
      default_integrations = true,
      integrations = {
        aerial = true,
        diffview = true,
        hop = true,
        mason = true,
        neotree = true,
        neotest = true,
        notifier = true,
        notify = true,
        overseer = true,
        lsp_trouble = true,
        which_key = true
      }
    },
  },
}

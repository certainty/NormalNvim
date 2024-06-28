return {
  -- Specific language support
  -- https://github.com/scalameta/nvim-metals
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    ft = { "scala", "sbt" },
    config = function()
      local metals_config = require("metals").bare_config()
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
      metals_config.on_attach = function(client, bufnr)
        local utils = require("base.utils.lsp")
        utils.apply_user_lsp_mappings(client, bufnr)
        require("metals").setup_dap()
      end

      metals_config.settings = {
        superMethodLensesEnabled = true,
        showImplicitArguments = true,
        showInferredType = true,
        showImplicitConversionsAndClasses = true,
        excludedPackages = {},
      }

      metals_config.init_options.statusBarProvider = false
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt" },
        callback = function()
          require("metals").initialize_or_attach(metals_config)
          -- set some keybindings that are buffer local
          vim.keymap.set('n', '<localleader>m',  "<Nop>", { buffer = 0, desc = "Metals" })
          vim.keymap.set("n", "<localleader>mi", "<cmd>MetalsInfo<CR>", { buffer = 0, desc = "Metals Info"} )
          vim.keymap.set("n", "<localleader>mu", "<cmd>MetalsUpdate<CR>", { buffer = 0, desc = "Metals Update"} )
          vim.keymap.set("n", "<localleader>mI", "<cmd>MetalsInstall<CR>", { buffer = 0, desc = "Metals Install"} )
          vim.keymap.set("n", "<localleader>mr", "<cmd>MetalsRestartMetals<CR>", { buffer = 0, desc = "Metals Restart"} )
          vim.keymap.set("n", "<localleader>md", "<cmd>MetalsRunDoctor<CR>", { buffer = 0, desc = "Metals Doctor"} )
          vim.keymap.set("n", "<localleader>ml", "<cmd>MetalsToggleLogs<CR>", { buffer = 0, desc = "Metals Logs"} )
          vim.keymap.set("n", "<localleader>ms", "<cmd>MetalsStartServer<CR>", { buffer = 0, desc = "Start Server"} )

          vim.keymap.set('n', '<localleader>b',  "<Nop>", { buffer = 0, desc = "Build" })
          vim.keymap.set("n", "<localleader>bi", "<cmd>MetalsImportBuild<CR>", { buffer = 0, desc = "Import Build"} )
          vim.keymap.set("n", "<localleader>bc", "<cmd>MetalsConnectBuild<CR>", { buffer = 0, desc = "Connect Build"} )
          vim.keymap.set("n", "<localleader>bd", "<cmd>MetalsDisconnectBuild<CR>", { buffer = 0, desc = "Disconnect Build"} )
          vim.keymap.set("n", "<localleader>br", "<cmd>MetalsRestartBuildServer<CR>", { buffer = 0, desc = "Restart Build Server"} )
          vim.keymap.set("n", "<localleader>bI", "<cmd>MetalsShowBuildTargetInfo<CR>", { buffer = 0, desc = "Show Build Target Info"} )

          vim.keymap.set('n', '<localleader>c',  "<Nop>", { buffer = 0, desc = "Compile" })
          vim.keymap.set("n", "<localleader>cc", "<cmd>MetalsCompileClean<CR>", { buffer = 0, desc = "Compile Clean"} )
          vim.keymap.set("n", "<localleader>cC", "<cmd>MetalsCompileCascade<CR>", { buffer = 0, desc = "Compile Clean"} )

          vim.keymap.set("n", "<localleader>o", "<cmd>MetalsOrganizeImports<CR>", { buffer = 0, desc = "Organize Imports"} )

          vim.keymap.set('n', '<localleader>w',  "<Nop>", { buffer = 0, desc = "Workspace" })
          vim.keymap.set("n", "<localleader>wr", "<cmd>MetalsResetWorkspace<CR>", { buffer = 0, desc = "Workspace Reset"} )

          vim.keymap.set('n', '<localleader>t',  "<Nop>", { buffer = 0, desc = "Test" })
          vim.keymap.set("n", "<localleader>tc", "<cmd>MetalsSelectTestCase<CR>", { buffer = 0, desc = "Select TestCase"} )
          vim.keymap.set("n", "<localleader>ts", "<cmd>MetalsSelectTestSuite<CR>", { buffer = 0, desc = "Select TestSuite"} )

          vim.keymap.set("n", "<localleader>s", "<cmd>MetalsAnalyzeStacktrace<CR>", { buffer = 0, desc = "Analyze Stacktrac"} )
        end,
        group = nvim_metals_group,
      })
    end,
  },
}

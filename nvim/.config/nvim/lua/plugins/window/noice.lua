-- https://github.com/folke/noice.nvim
-- noice.nvim: replaces the cmdline, messages, and popups with styled floating windows.
return {
  "folke/noice.nvim",
  lazy = false,
  dependencies = {
    "MunifTanjim/nui.nvim",       -- required UI primitives
    "rcarriga/nvim-notify",       -- notification backend (pretty toast bubbles)
  },
	
  opts = {
    cmdline = {
      enabled = true,
      view = "cmdline_popup", -- floating popup instead of the bottom bar
      format = {
        cmdline   = { icon = ">" },
        search_down = { icon = " " },
        search_up   = { icon = " " },
        filter    = { icon = "$" },
        lua       = { icon = "☾" },
        help      = { icon = "?" },
      },
    },

    messages = {
      enabled      = true,
      view         = "notify",        -- route short messages → toast
      view_error   = "notify",
      view_warn    = "notify",
      view_history = "messages",      -- :messages still works
      view_search  = "virtualtext",   -- search count shown inline, not in a popup
    },

    lsp = {
      progress = {
        enabled = true,
        -- Shows LSP/compile progress (latexmk, etc.) as a small bubble
        view = "mini",
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"]                = true,
        ["cmp.entry.get_documentation"]                  = true,
      },
      hover     = { enabled = true },
      signature = { enabled = true },
      message   = { enabled = true, view = "notify" },
    },

    popupmenu = {
      enabled  = true,
      backend  = "nui", -- nui renders it; swap to "cmp" if you add nvim-cmp later
    },

    presets = {
      bottom_search        = true,  -- classic /search bar at the bottom
      command_palette      = true,  -- :cmd + completion in one centered popup
      long_message_to_split = true, -- long messages go to a split, not a popup
      inc_rename           = false, -- enable if you add inc-rename.nvim
      lsp_doc_border       = true,  -- border on hover/signature popups
    },

    routes = {
      -- "written" file save notification → mini view (tiny, auto-dismisses)
      {
        filter  = { event = "msg_show", kind = "", find = "written" },
        opts    = { skip = false },
        view    = "mini",
      },
      -- Hide the "search hit BOTTOM" wraparound message
      {
        filter = { event = "msg_show", find = "search hit" },
        opts   = { skip = true },
      },
      -- Suppress the "No more valid diagnostics to move to" message
      {
        filter = { event = "msg_show", find = "No more valid" },
        opts   = { skip = true },
      },
    },

    views = {
      notify = {
        merge  = false,  -- don't stack same-message toasts
        replace = false,
      },
      mini = {
        win_options = { winblend = 0 },
        timeout     = 2000, -- auto-dismiss after 2 s
      },
    },
  },
	
	config = function(_, opts)
		require("notify").setup({
			background_color = "#2E3440",
		})

		require("noice").setup(opts)
	end,

  keys = {
    { "<leader>nd", function() require("noice").cmd("dismiss") end,
      desc = "Dismiss all notifications" },
    { "<leader>nl", function() require("noice").cmd("last") end,
      desc = "Show last notification" },
    { "<leader>nh", function() require("noice").cmd("history") end,
      desc = "Notification history" },
    { "<C-f>", function()
        if not require("noice.lsp").scroll(4) then return "<C-f>" end
      end, silent = true, expr = true, desc = "Scroll noice popup down",
      mode = { "i", "n", "s" } },
    { "<C-b>", function()
        if not require("noice.lsp").scroll(-4) then return "<C-b>" end
      end, silent = true, expr = true, desc = "Scroll noice popup up",
      mode = { "i", "n", "s" } },
  },
}

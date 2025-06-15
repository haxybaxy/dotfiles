return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    animate = { enabled = true,},
    bigfile = { enabled = true },
    quickfle = { enabled = true },
    explorer = { enabled = true },
    terminal = { enabled = true },
    image = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = {
      sources = {
        files = { hidden = true },
        explorer = {
          include = { ".*", "hidden" },
          layout = {
            layout = {
              position = "right",
            },
          },
        },
      },
    },
  },
  keys = {
    -- Top Pickers & Explorer
    { "<leader>n",  function() Snacks.picker.notifications() end,    desc = "Notification History" },
    { "<leader>e",  function() Snacks.explorer() end,                desc = "File Explorer" },
    -- find
    { "<leader>z",  function() Snacks.zen() end,                     desc = "Toggle Zen Mode" },
    { "<leader>Z",  function() Snacks.zen.zoom() end,                desc = "Toggle Zoom" },
    { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
    { "<leader>n",  function() Snacks.notifier.show_history() end,   desc = "Notification History" },
    { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
    { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
    { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse",               mode = { "n", "v" } },
    { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
    { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
    { "<leader>t",  function() Snacks.terminal() end,                desc = "Toggle Terminal" },
    { "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",           mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",           mode = { "n", "t" } },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    },
    config = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
        end,
      })
    end,
  }
}

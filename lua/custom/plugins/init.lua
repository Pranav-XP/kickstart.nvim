-- You can add your own plugins here or in other files in this directory!
-- I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = {
      'nhattVim/alpha-ascii.nvim',
      opts = { header = 'para', 
      user_path = vim.fn.stdpath 'config' .. '/ascii' },
    },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      dashboard.section.buttons.val = {
        dashboard.button('e', '📄  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('f', '🔍  Find file', ':Telescope find_files <CR>'),
        dashboard.button('c', '⚙️  Open Config (~/.config/nvim)', ':e ~/.config/nvim<CR>'),
        dashboard.button('l', '📦  Lazy Plugin Manager', ':Lazy<CR>'),
        dashboard.button('m', '🧱  Mason Package Manager', ':Mason<CR>'),
        dashboard.button('q', '🚪  Quit Neovim', ':qa<CR>'),
      }

      vim.api.nvim_create_autocmd('User', {
        once = true,
        pattern = 'LazyVimStarted',
        callback = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = {
            ' ',
            ' Loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins  in ' .. ms .. ' ms ',
          }
          pcall(vim.cmd.AlphaRedraw)
        end,
      })

      alpha.setup(dashboard.opts)
    end,
  },
}

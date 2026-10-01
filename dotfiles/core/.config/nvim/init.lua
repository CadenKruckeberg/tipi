if not vim.g.vscode then
  require('vim._core.ui2').enable {}
end

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/jamessan/vim-gnupg"
})

vim.g.mapleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<Leader>p', '"+p')

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.list = true
vim.opt.listchars = {
  tab = '→ ',
}

vim.opt.number = true
vim.opt.colorcolumn = '80'
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false

vim.cmd.colorscheme 'catppuccin'
vim.opt.winborder = 'rounded'

dofile(vim.fn.stdpath("config") .. "/theme.lua") -- managed with stow
vim.api.nvim_create_user_command("ThemeReload", function()
  dofile(vim.fn.stdpath("config") .. "/theme.lua")
end, {})

vim.lsp.enable { 'lua_ls', 'jdtls', 'pyright' }

vim.cmd('set completeopt+=noselect')
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
      buffer = ev.buf,
      callback = function()
        vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
      end,
    })
  end,
})

vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
  },
  signs = true,
  underline = true,
})

local treesitter_languages = { 'java', 'lua', 'markdown', 'python', 'make',
  'bash', 'csv', 'tsv', 'json' }
require('nvim-treesitter').install(treesitter_languages)
vim.api.nvim_create_autocmd('FileType', {
  pattern = treesitter_languages,
  callback = function()
    vim.treesitter.start()
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.g.GPGPreferSymmetric = 1
local gpg_group = vim.api.nvim_create_augroup("GpgSecurity", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
  pattern = { "*.gpg", "*.asc", "*.pgp" },
  group = gpg_group,
  callback = function()
    vim.opt_local.swapfile = false
    vim.opt_local.undofile = false
    vim.opt_local.shada = ""
  end,
})
vim.g.gpg_update_tty = 1


-------------------
---- TELESCOPE ----
-------------------

-- Install the filetype icons for telescope
vim.pack.add({
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' }
})

-- Install telescope itself
vim.pack.add({
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' }
})

local telescope = require("telescope")
local actions = require("telescope.actions")
local map = vim.keymap.set

telescope.setup({

  defaults = {

    -- Use sharp corners instead of rounded ones
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },

    -- Close telescope on escape, instead of entering normal mode
    mappings = {
      i = {
        ["<esc>"] = actions.close
      }
    },

  },

  -- Include hidden files, but not .git files
  pickers = {
    find_files = {
      find_command = { "rg", "--ignore-case", "--files", "--hidden", "--glob", "!.git" },
    },
    live_grep = {
      additional_args = function()
        return { "--ignore-case", "--hidden", "--glob", "!.git" }
      end
    }
  },

})

-- Telescope keymaps
map('n', '<leader>ff', "<CMD>Telescope find_files<CR>", { desc = 'Telescope find files' })
map('n', '<leader>fg', "<CMD>Telescope live_grep<CR>", { desc = 'Telescope live grep' })
map('n', '<leader>fb', "<CMD>Telescope buffers<CR>", { desc = 'Telescope buffers' })
map('n', '<leader>fh', "<CMD>Telescope help_tags<CR>", { desc = 'Telescope help tags' })


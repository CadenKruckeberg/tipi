require('vim._core.ui2').enable {}

vim.g.mapleader = ' '

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

vim.opt.background = 'light'
vim.cmd.colorscheme 'catppuccin'
vim.opt.winborder = 'rounded'

vim.lsp.enable { 'lua_ls', 'jdtls', }

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

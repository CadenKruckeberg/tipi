-- Move by word in Insert Mode
vim.keymap.set("i", "<C-Left>", "<C-o>b", { desc = "Move back one word" })
vim.keymap.set("i", "<C-Right>", "<C-o>w", { desc = "Move forward one word" })

-- Delete by word in Insert Mode
vim.keymap.set("i", "<C-BS>", "<C-w>", { desc = "Delete word backward" })
vim.keymap.set("i", "<C-h>", "<C-w>", { desc = "Delete word backward (fallback)" })
vim.keymap.set("i", "<C-Delete>", "<C-o>dw", { desc = "Delete word forward" })

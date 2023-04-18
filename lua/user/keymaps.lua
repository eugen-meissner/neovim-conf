local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Harpoon
keymap("n", "<leader>h", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>e", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", opts)
keymap("n", "<leader>5", "<cmd>lua require('harpoon.term').gotoTerminal(5)<CR>", opts)

-- Copilot
keymap("n", "<F2>", "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)
keymap("i", "<C-CR>", "<cmd>lua require('copilot.suggestion').accept()<CR>", opts)
keymap("i", "<C-BS>", "<cmd>lua require('copilot.suggestion').reject()<CR>", opts)
keymap("i", "<C-,>", "<cmd>lua require('copilot.suggestion').prev()<CR>", opts)
keymap("i", "<C-.>", "<cmd>lua require('copilot.suggestion').next()<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Debugging --
keymap("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<F8>", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", opts)
keymap("n", "<F5>", "", {
	callback = function()
		if vim.bo.filetype == "rust" then
			require("rust-tools").debuggables.debuggables()
		else
			require("dap").continue()
		end
	end,
	noremap = true,
	silent = true,
})
keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<S-F10>", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>q", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- NvimTree
keymap("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", opts)

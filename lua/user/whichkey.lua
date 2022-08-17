local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

which_key.setup({})

which_key.register({
	p = {
		name = "project",
		p = { "<cmd>Telescope projects<cr>", "recent-projects" },
		f = { "<cmd>Telescope find_files<cr>", "find-files" },
		g = { "<cmd>Telescope live_grep<cr>", "search-project" },
	},
}, { prefix = "<leader>" })

which_key.register({
	w = {
		name = "window",
		v = { "<C-w>v", "v-split" },
		s = { "<C-w>s", "h-split" },
		d = { "<C-w>c", "close" },
		D = { "<C-w>o", "close-unfocused" },
		r = { "<C-w>r", "rotate" },
		h = { "<C-w>h", "left" },
		l = { "<C-w>l", "right" },
		j = { "<C-w>j", "down" },
		k = { "<C-w>k", "up" },
	},
}, { prefix = "<leader>" })

which_key.register({
	b = {
		name = "buffer",
		d = { "<cmd>Bdelete<cr>", "delete" },
		D = { "<cmd>Bdelete!<cr>", "hard-delete" },
		l = { "<cmd>bnext<cr>", "next" },
		h = { "<cmd>bprev<cr>", "prev" },
		i = { "<cmd>Telescope buffers<cr>", "list" },
	},
}, { prefix = "<leader>" })

which_key.register({
	g = {
		name = "git",
		g = { "<cmd>Neogit<cr>", "git-status" },
	},
}, { prefix = "<leader>" })

which_key.register({
	c = {
		name = "code",
		a = { "<cmd>Lspsaga code_action<cr>", "code-action" },
		r = { "<cmd>Lspsaga rename<cr>", "rename" },
		h = { "<cmd>Lspsaga hover_doc<cr>", "code-action" },
		c = { "<cmd>Neogen<cr>", "generate-doc" },
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "format-code" },
		d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "go-definition" },
		D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "go-declaration" },
		i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "go-implementation" },
		s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "signature-help" },
	},
}, { prefix = "<leader>" })

which_key.register({
	["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", "comment-out" },
	[";"] = { "<cmd>Alpha<cr>", "Dashboard" },
}, { prefix = "<leader>" })

which_key.register({
	["/"] = { '<esc><cmd>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<cr>', "comment-out" },
}, { prefix = "<leader>", mode = "x" })

which_key.register({
	t = {
		name = "toggle",
		z = { "<cmd>ZenMode<cr>", "zen-mode" },
		t = { "<cmd>ToggleTerm<cr>", "terminal" },
		o = { "<cmd>NvimTreeToggle<cr>", "file-tree" },
	},
}, { prefix = "<leader>" })

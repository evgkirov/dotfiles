local keymap = vim.keymap.set
local opts = { silent = true }

-- keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprev<CR>", opts)
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>x", ":BufDel<CR>", opts)
keymap("n", "<leader>XX", ":NvimTreeFocus<CR>:BufDelOthers<CR>:NvimTreeCollapse<CR>", opts)
keymap("n", "<leader>XQ", ":qa<CR>", opts)
keymap("n", "<leader>XW", ":wqa<CR>", opts)
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", ";", ":", {})
keymap("n", "!", ":! ", {})
keymap("n", "<leader>rdu", ":! docker compose up -d<CR>", {})
keymap("n", "<leader>rdU", ":! docker compose up --build -d<CR>", {})
keymap("n", "<leader>rdd", ":! docker compose down<CR>", {})
keymap("n", "<leader>rdt", ":! web test<CR>", {})
keymap("n", "<leader>rdT", ":! web python -Wa manage.py test<CR>", {})
keymap("n", "<leader>rdl", ":TermExec cmd='docker compose logs -f' direction=float<CR><esc>", opts)
keymap("n", "<leader>tt", ":ToggleTerm<CR>", opts)
keymap("n", "<leader>tn", ":terminal<CR>", opts)
keymap("n", "<leader>gs", "<Cmd>LazyGit<CR>", opts)
keymap({ "n", "t"}, "<F10>", "<C-\\><C-n>:ToggleTerm<CR>", opts)
keymap({ "n", "v", "i" }, "<Left>", "<Cmd>wincmd h<CR>", opts)
keymap({ "n", "v", "i" }, "<Down>", "<Cmd>wincmd j<CR>", opts)
keymap({ "n", "v", "i" }, "<Up>", "<Cmd>wincmd k<CR>", opts)
keymap({ "n", "v", "i" }, "<Right>", "<Cmd>wincmd l<CR>", opts)
-- keymap("t", "<leader><esc>", "<C-\\><C-n>", opts)
keymap("t", "<esc>", "<C-\\><C-n>", opts)
keymap("n", "<esc>", ":noh<CR>", opts)
keymap("i", "<Enter>", "<CR>", opts)
keymap("n", "D", "\"_d", opts)

vim.o.langmap="ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

require("which-key").register({
	r = {
		name = " Run",
		d = {
			name = "󰡨 Django",
		}
	},
	t = {
		name = " Terminal",
	},
	f = {
		name = "󰍉 Find",
	},
}, { prefix = "<leader>" })

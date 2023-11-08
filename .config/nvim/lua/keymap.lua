local keymap = vim.keymap.set
local opts = { silent = true }

-- keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- keymap("n", "<S-Tab>", ":bprev<CR>", opts)
--keymap("n", "<Tab>", ":bnext<CR>", opts)
--keymap("n", "<Tab>", function ()
--	require("arena").toggle()
--end, opts)
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>x", ":BufDel<CR>", opts)
keymap("n", "<leader>XX", ":NvimTreeFocus<CR>:BufDelOthers<CR>:NvimTreeCollapse<CR>", opts)
keymap("n", "<leader>XQ", ":qa<CR>", opts)
keymap("n", "<leader>XW", ":wqa<CR>", opts)
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "!", ":! ", {})
keymap("n", "<leader>rdu", ":! docker compose up -d<CR>", {})
keymap("n", "<leader>rdU", ":! docker compose up --build -d<CR>", {})
keymap("n", "<leader>rdd", ":! docker compose down<CR>", {})
keymap("n", "<leader>rdt", ":TermExec cmd='web test' direction=float<CR>", {})
keymap("n", "<leader>rdT", ":TermExec cmd='web test (string replace $PWD/  \"\" %)' direction=float<CR>", {})
keymap("n", "<leader>rdl", ":TermExec cmd='docker compose logs -f' direction=float<CR><esc>", opts)
keymap("n", "<leader>tt", ":ToggleTerm<CR>", opts)
keymap("n", "<leader>tn", ":terminal<CR>", opts)
keymap("n", "<leader>gs", "<Cmd>TermExec cmd='lazygit && exit' direction=float<CR>", opts)
keymap({ "n", "t" }, "<F10>", "<C-\\><C-n>:ToggleTerm<CR>", opts)
keymap({ "n", "t", "v", "i" }, "<C-h>", function()
	local oldnr = vim.fn.winnr()
	vim.cmd("wincmd h")
	if oldnr == vim.fn.winnr() then
		os.execute("yabai -m window --focus west")
	end
end, opts)
keymap({ "n", "t", "v", "i" }, "<C-j>", function()
	local oldnr = vim.fn.winnr()
	vim.cmd("wincmd j")
	if oldnr == vim.fn.winnr() then
		os.execute("yabai -m window --focus south")
	end
end, opts)
keymap({ "n", "t", "v", "i" }, "<C-k>", function()
	local oldnr = vim.fn.winnr()
	vim.cmd("wincmd k")
	if oldnr == vim.fn.winnr() then
		os.execute("yabai -m window --focus north")
	end
end, opts)
keymap({ "n", "t", "v", "i" }, "<C-l>", function()
	local oldnr = vim.fn.winnr()
	vim.cmd("wincmd l")
	if oldnr == vim.fn.winnr() then
		os.execute("yabai -m window --focus east")
	end
end, opts)
keymap("n", "<C-M-S-m>", ":ololo", {})
-- keymap("t", "<leader><esc>", "<C-\\><C-n>", opts)
-- keymap("t", "<esc>", "<C-\\><C-n>", opts)
keymap("n", "<esc>", ":noh<CR>", opts)
keymap("i", "<Enter>", "<CR>", opts)
keymap("n", "D", '"_d', opts)
-- keymap("i", "jj", "<esc>", opts)
-- keymap("i", "kk", "<esc>", opts)
keymap("i", "jk", "<esc>", opts)
-- keymap("t", "jj", "<C-\\><C-n>", opts)
-- keymap("t", "kk", "<C-\\><C-n>", opts)
keymap("t", "jk", "<C-\\><C-n>", opts)

vim.o.langmap =
	"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

require("which-key").register({
	r = {
		name = " Run",
		d = {
			name = "󰡨 Django",
		},
	},
	t = {
		name = " Terminal",
	},
	f = {
		name = "󰍉 Find",
	},
}, { prefix = "<leader>" })

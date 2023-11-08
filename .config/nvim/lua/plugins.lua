local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	-- packer
	use({ "wbthomason/packer.nvim" })

	-- ui
	use({ "nvim-tree/nvim-tree.lua" })
	use({ "nvim-tree/nvim-web-devicons" })
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	use({ "ojroques/nvim-bufdel" })
	use({ "f-person/auto-dark-mode.nvim" })
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = "<F10>",
				-- highlights = {
				-- 	Normal = { link = "Normal" },
				-- 	NormalFloat = { link = "Normal" },
				-- 	FloatBorder = { link = "FloatBorder" },
				-- 	SignColumn = { link = "SignColumn" },
				-- 	StatusLine = { link = "StatusLine" },
				-- 	StatusLineNC = { link = "StatusLineNC" },
				-- },

				shade_terminals = true,
				shading_factor = "-50",
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
			})
		end,
	})
	use({ "folke/which-key.nvim" })
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"lewis6991/gitsigns.nvim",
	})

	-- utilities

	-- themes
	use({ "sainnhe/gruvbox-material" })
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "arzg/vim-colors-xcode" })
	use("Mofiqul/adwaita.nvim")
	--use 'RRethy/nvim-base16'
	use("EdenEast/nightfox.nvim")
	use({ "projekt0n/github-nvim-theme" })
	use("olimorris/onedarkpro.nvim")
	use("sainnhe/edge")
	use({ "rose-pine/neovim", as = "rose-pine" })
	use("p00f/alabaster.nvim")
	use("sainnhe/everforest")

	-- code
	use({ "editorconfig/editorconfig-vim" })
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
	})
	use({ "rmagatti/auto-session" })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use("nvim-treesitter/nvim-treesitter-context")

	-- lsp
	use({ "neovim/nvim-lspconfig" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-vsnip" })
	use({ "hrsh7th/vim-vsnip" })
	use({ "rafamadriz/friendly-snippets" })
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

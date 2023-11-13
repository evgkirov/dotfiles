vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = { "*" },
	callback = function()
		os.execute("im-select org.sil.ukelele.keyboardlayout.t.english-ilyabirmantypography")
	end,
})


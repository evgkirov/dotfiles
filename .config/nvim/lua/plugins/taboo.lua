return {
    "gcmt/taboo.vim",
    event = "VimEnter",
    config = function()
        vim.cmd([[
      "let g:taboo_tab_format=" %d %f %m %x⎹"
      "%N let g:taboo_tab_format="%N %d%U .../%P %m %x▕"
      let g:taboo_tab_format=" %N. %P%m▕"

      let g:taboo_renamed_tab_format=" %N. %l%m▕"
      let g:taboo_close_tab_label = ""
      let g:taboo_modified_tab_flag=" [+]"
    ]])
    end,
}

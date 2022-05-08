-- This function closes the "output" and "stack trace" windows.
-- https://github.com/puremourning/.vim-mac/blob/master/plugin/vimspector_ui.vim
vim.cmd [[
function! s:SetUpUI() abort
  call win_gotoid( g:vimspector_session_windows.output )
  q
  call win_gotoid( g:vimspector_session_windows.stack_trace )
  q
endfunction
augroup VimspectorCustom
  au!
  autocmd User VimspectorUICreated call s:SetUpUI()
augroup END
]]

vim.cmd "packadd! vimspector"
vim.g.vimspector_enable_mappings = "HUMAN"
vim.g.vimspector_base_dir = "/home/akim/.config/nvim/lua/rc/vimspector"

let s:cmdline = vital#of("vital").import("Over.Commandline")


let s:search = s:cmdline.make_plain("/")

" 必要なモジュールを追加
call s:search.connect(s:cmdline.module_delete())
call s:search.connect(s:cmdline.module_scroll())
call s:search.connect(s:cmdline.module_cursor_move())
call s:search.connect(s:cmdline.module_paste())
call s:search.connect(s:cmdline.module_history("/"))
call s:search.connect(s:cmdline.module_incsearch("/"))


" 検索の実行コマンド
function! s:search.execute()
	call feedkeys("/" . self.getline() . "\<CR>")
endfunction


function! Search()
	call s:search.start()
endfunction


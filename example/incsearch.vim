let s:cmdline = vital#of("vital").import("Over.Commandline")


let s:search = s:cmdline.make_basic("/")

" 必要なモジュールを追加
call s:search.connect(s:cmdline.get_module("History").make("/"))
call s:search.connect(s:cmdline.get_module("Incsearch").make("/"))


" 検索の実行コマンド
function! s:search.execute()
	call feedkeys("/" . self.getline() . "\<CR>")
endfunction


function! Search()
	call s:search.start()
endfunction


let s:cmdline = vital#of("vital").import("Over.Commandline")


let s:search = s:cmdline.make_standard("/")

" 必要なモジュールを追加
call s:search.connect(s:cmdline.make_module("History", "/"))
call s:search.connect(s:cmdline.make_module("HistAdd", "/"))
call s:search.connect(s:cmdline.make_module("Incsearch", "/"))


" 検索の実行コマンド
function! s:search.execute()
	call feedkeys("/" . self.getline() . "\<CR>")
endfunction


function! Search()
	call s:search.start()
endfunction


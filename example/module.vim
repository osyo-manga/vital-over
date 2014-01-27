let s:cmdline = vital#of("vital").import("Over.Commandline")


" コマンドラインのオブジェクトを生成
let s:my = s:cmdline.make("$ ")


" モジュールの生成
" <C-v> で @* をペーストする
let s:paste = {}


" キーが入力されて文字が挿入される前
function! s:paste.on_charpre(cmdline)
	" キー入力の判定
	if a:cmdline.is_input("\<C-v>")
		" コマンドラインに @* を挿入
		call a:cmdline.insert(@*)

		" 入力された文字が挿入されないように削除
		call a:cmdline.setchar('')
	endif
endfunction


" モジュールを追加
call s:my.connect(s:paste)


" コマンドラインの開始
call s:my.start()



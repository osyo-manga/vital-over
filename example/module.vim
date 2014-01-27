let s:cmdline = vital#of("vital").import("Over.Commandline")


" コマンドラインのオブジェクトを生成
let s:my = s:cmdline.make("$ ")


" モジュールの生成
let s:module = {}


" キーが入力されて文字が挿入される前に呼ばれる関数
function! s:module.on_charpre(cmdline)
	" キー入力の判定
	if a:cmdline.is_input("\<C-v>")
		" コマンドラインに @* を挿入
		call a:cmdline.insert(@*)

		" 入力された文字が挿入されないように削除
		call a:cmdline.setchar('')
	elseif a:cmdline.is_input("\<C-c>")
		" コマンドラインを終了する
		call a:cmdline.exit()
	endif
endfunction


" モジュールを追加
call s:my.connect(s:module)


" コマンドラインの開始
call s:my.start()



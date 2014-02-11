let s:cmdline = vital#of("vital").import("Over.Commandline")


" コマンドラインのオブジェクトを生成
let s:my = s:cmdline.make_standard("$ ")


" モジュールの生成
let s:module = {
\   "name" : "Custom",
\}


" キーが入力されて文字が挿入される前に呼ばれる関数
function! s:module.on_char_pre(cmdline)
	" キー入力の判定
	" コマンドラインに @* を挿入
	if a:cmdline.is_input("\<C-v>")
		call a:cmdline.insert(@*)

		" 入力された文字が挿入されないように削除
		call a:cmdline.setchar('')

	" コマンドラインを終了する
	elseif a:cmdline.is_input("\<A-c>")
		call a:cmdline.exit()
	endif
endfunction


" モジュールを追加
call s:my.connect(s:module)


" コマンドラインの開始
call s:my.start()



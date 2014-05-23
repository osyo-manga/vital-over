call vital#of("vital").unload()
let s:cmdline = vital#of("vital").import("Over.Commandline")


" コマンドラインのオブジェクトを生成
let s:my = s:cmdline.make_standard("$ ")

" 任意のタイミングに処理を追加する
" :help Vital.Over.Commandline-object-callback

" コマンドラインが開始された時に呼ばれる
function! s:my.on_enter(...)
	" プロンプトを変更
	call self.set_prompt(">>> ")
endfunction

" キーが入力するたびに呼ばれる
function! s:my.on_char_pre(...)
	" 小文字が入力されたら
	if self.char() =~ '[a-z]'
		" 大文字にして入力する
		call self.setchar(toupper(self.char()))
	endif
endfunction

" コマンドラインの開始
call s:my.start()


let s:cmdline = vital#of("vital").import("Over.Commandline")

" コマンドラインのオブジェクトを生成
let s:my = s:cmdline.make_standard("count >> ")

" カウントモジュールを生成
let s:Count = s:cmdline.get_module("Count").make()
call s:my.connect(s:Count)

" キーが入力するたびに呼ばれる
function! s:my.on_char_pre(...)
	if s:Count.vcount > 0
		" カウント分入力を繰り返す
		call self.setchar(repeat(self.char(), s:Count.vcount))
	endif
endfunction

function! s:my.execute()
	" Execute 時にも使用可能
	echom self.getline()
	echom 'Count down...'
	for i in reverse(range(s:Count.vcount + 1))
		sleep 1000m
		echom '...' . i
	endfor
endfunction

function! VitalOverCount()
	" コマンドラインの開始
	call s:my.start()
endfunction


" コマンドラインのオブジェクトを生成
let s:my2 = s:cmdline.make_standard("count2 >> ")

" カウントモジュールを生成
let s:Count2 = s:cmdline.get_module("Count").make()
let s:Count2.use_prefix = 1
call s:my2.cnoremap("\<C-o>", "<Over>(count-prefix)")
call s:my2.connect(s:Count2)

function! s:my2.execute()
	" Execute 時にも使用可能
	echom self.getline()
	echom 'Count down...'
	for i in reverse(range(s:Count2.vcount + 1))
		sleep 1000m
		echom '...' . i
	endfor
endfunction

function! s:my2.on_char(...)
	if s:Count2.vcount > 0
		call self.set_suffix('count: ' . s:Count2.vcount)
	else
		call self.set_suffix('')
	endif
endfunction

function! VitalOverCountPrefix()
	" コマンドラインの開始
	call s:my2.start()
endfunction

" vim: noet

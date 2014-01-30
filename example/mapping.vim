let s:cmdline = vital#of("vital").import("Over.Commandline")


" コマンドラインのオブジェクトを生成
let s:my = s:cmdline.make_plain("$ ")


" 使用したいモジュールを追加
call s:my.connect(s:cmdline.module_scroll())


" 任意のマッピングの辞書を返す
" <C-n>, <C-p> でスクロールする
function! s:my.keymappings()
	return {
\		"\<C-n>" : "\<Plug>(over-cmdline-scroll-e)",
\		"\<C-p>" : "\<Plug>(over-cmdline-scroll-y)",
\	}
endfunction


" コマンドラインの開始
call s:my.start()


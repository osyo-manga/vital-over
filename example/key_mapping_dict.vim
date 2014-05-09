let s:cmdline = vital#of("vital").import("Over.Commandline")


" コマンドラインのオブジェクトを生成
let s:my = s:cmdline.make_standard("$ ")


" 使用したいモジュールを追加
call s:my.connect("Scroll")


" 任意のマッピングの辞書を返す
" <C-f>, <C-b> でカーソル移動
" <C-n>, <C-p> でスクロールする
function! s:my.keymapping()
	return {
\		"\<C-f>" : "\<Right>",
\		"\<C-b>" : "\<Left>",
\		"\<C-n>" : "<Over>(scroll-e)",
\		"\<C-p>" : "<Over>(scroll-y)",
\	}
endfunction


" コマンドラインの開始
call s:my.start()


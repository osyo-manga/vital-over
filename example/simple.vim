let s:cmdline  = vital#of("vital").import("Over.Commandline")


" コマンドラインのオブジェクトを生成
" make_standard() は標準のコマンドラインの挙動に準じたコマンドラインが生成される
" NOTE:全ての機能が実装されているわけではない
let s:my = s:cmdline.make_standard(":")


" コマンドラインの開始
" <CR> でコマンドを実行したり <Esc> でコマンドラインを終了する
call s:my.start()


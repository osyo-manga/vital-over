let s:cmdline = vital#of("vital").import("Over.Commandline")


" コマンドラインのオブジェクトを生成
let s:my = s:cmdline.make("$ ")


" 使用したいモジュールを追加
call s:my.connect(s:cmdline.module_scroll())
call s:my.connect(s:cmdline.module_move())
call s:my.connect(s:cmdline.module_delete())


" コマンドラインの開始
call s:my.start()


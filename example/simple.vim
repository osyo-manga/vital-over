let s:cmdline     = vital#of("vital").import("Over.Commandline")
let s:cursor_move = vital#of("vital").import("Over.Commandline.Modules.CursorMove")
let s:delete      = vital#of("vital").import("Over.Commandline.Modules.Delete")


" コマンドラインのオブジェクトを生成
let s:my = s:cmdline.make_plain("$ ")


" 使用したいモジュールを追加
call s:my.connect(s:cursor_move.make())
call s:my.connect(s:delete.make())


" コマンドラインの開始
call s:my.start()


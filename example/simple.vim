let s:cmdline     = vital#of("vital").import("Over.Commandline")
let s:cursor_move = vital#of("vital").import("Over.Commandline.Modules.CursorMove")
let s:delete      = vital#of("vital").import("Over.Commandline.Modules.Delete")


" コマンドラインのオブジェクトを生成
let s:my = s:cmdline.make_plain("$ ")


" 使用したいモジュールを追加
" get_module() でモジュールを取得できる
call s:my.connect(s:cmdline.get_module("Scroll").make())

" 直接名前をしていする事も可能
" この場合は
" s:cmdline.get_module("CursorMove").make()
" と同等
call s:my.connect("CursorMove")


" コマンドラインの開始
call s:my.start()


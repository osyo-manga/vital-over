let s:cmdline = vital#of("vital").import("Over.Commandline")


" コマンドラインのオブジェクトを生成
let s:my = s:cmdline.make_plain("$ ")


" 使用したいモジュールを追加
call s:my.connect("Scroll")
call s:my.connect("CursorMove")


" 生成したコマンドラインに対してキーマップを設定する
call s:my.cmap("\<C-f>", "\<Right>")
call s:my.cmap("\<C-b>", "\<Left>")
call s:my.cmap("\<C-n>", "<Over>(scroll-e)")
call s:my.cmap("\<C-p>", "<Over>(scroll-y)")


" コマンドラインの開始
call s:my.start()



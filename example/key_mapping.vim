let s:cmdline = vital#of("vital").import("Over.Commandline")


" コマンドラインのオブジェクトを生成
let s:my = s:cmdline.make_standard("$ ")


" 使用したいモジュールを追加
call s:my.connect("Scroll")


" 生成したコマンドラインに対してキーマップを設定する
call s:my.cnoremap("\<C-f>", "\<Right>")
call s:my.cnoremap("\<C-b>", "\<Left>")
call s:my.cnoremap("\<C-n>", "<Over>(scroll-e)")
call s:my.cnoremap("\<C-p>", "<Over>(scroll-y)")


" コマンドラインの開始
call s:my.start()


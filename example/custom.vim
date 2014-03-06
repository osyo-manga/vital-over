let s:cmdline     = vital#of("vital").import("Over.Commandline")


" コマンドラインのオブジェクトを生成
" このオブジェクトは何も行わないので
" 自分で Modules を追加してカスタマイズしていく
let s:my = s:cmdline.make_default("$ ")


" 使用したいモジュールを追加する
" get_module() でモジュールを取得できる
" "DrawCommandline" はコマンドラインに出力を行う
call s:my.connect(s:cmdline.get_module("DrawCommandline").make())


" "Execute" は <CR> で入力されたコマンドを実行する
call s:my.connect(s:cmdline.get_module("Execute").make())


" 直接名前をしていする事も可能
" この場合は
" s:cmdline.get_module("Cancel").make()
" と同等
" "Cancel" は <Esc> でコマンドラインを終了する
call s:my.connect("Cancel")


" コマンドラインの開始
call s:my.start()


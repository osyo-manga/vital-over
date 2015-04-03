#vital-over

Vim commandline frame work


## Requirement

* __[vim-jp/vital.vim](https://github.com/vim-jp/vital.vim)__


##Example

```vim
let s:cmdline = vital#of("vital").import("Over.Commandline")

" コマンドラインのオブジェクトを生成
let s:my = s:cmdline.make_standard(">")

" コマンドラインの入力を開始
call s:my.start()
```


##License

[NYSL](http://www.kmonos.net/nysl/)

[NYSL English](http://www.kmonos.net/nysl/index.en.html)


##Special Thanks

* [@haya14busa](https://github.com/haya14busa)



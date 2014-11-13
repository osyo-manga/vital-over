
call vital#of("vital").unload()
let s:Base = vital#of("vital").import("Over.Commandline.Base")
let s:IgnoreRegexpBackwardWord = vital#of("vital").import("Over.Commandline.Modules.IgnoreRegexpBackwardWord")


function! s:test_backward_word()
	let cmdline = s:Base.make()
	call cmdline.connect(s:IgnoreRegexpBackwardWord.make())
	call cmdline.callevent("on_enter")
	call cmdline._init_variables()

	call cmdline._input('\vword')
	OwlCheck cmdline.backward_word() == 'word'

	call cmdline._input(' \v__homu')
	OwlCheck cmdline.backward_word() == '__homu'
	OwlCheck cmdline.backward_word('[a-z]\+') == 'homu'
endfunction


function! s:func(...)
	return call(s:IgnoreRegexpBackwardWord.backward_word, a:000, s:IgnoreRegexpBackwardWord)
endfunction


function! s:test_free_backward_word()
	OwlCheck s:func('\vword') == "word"
	OwlCheck s:func('\vword  ') == "word  "
	OwlCheck s:func('homu\zsmami') == "mami"
	OwlCheck s:func('\zs\v') == '\v'
	OwlCheck s:func('\zs mado \v') == '\v'
	OwlCheck s:func('\v  ') == '\v  '
	OwlCheck s:func('\\zs  ') == 'zs  '
	OwlCheck s:func('\') == '\'
endfunction



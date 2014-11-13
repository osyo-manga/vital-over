
call vital#of("vital").unload()
let s:Base = vital#of("vital").import("Over.Commandline.Base")


function! s:test_backward_word()
	let cmdline = s:Base.make()
	call cmdline._init_variables()

	call cmdline._input(" __bbb")
	OwlCheck cmdline.backward_word() == "__bbb"
	OwlCheck cmdline.backward_word('[a-z]\+') == "bbb"

	call cmdline._input("bbb  ")
	OwlCheck cmdline.backward_word() == "bbb  "

	call cmdline._input("(")
	OwlCheck cmdline.backward_word() == "("
endfunction


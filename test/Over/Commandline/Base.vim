
call vital#of("vital").unload()
let s:Base = vital#of("vital").import("Over.Commandline.Base")
let s:Cmdline = vital#of("vital").import("Over.Commandline")


function! s:test_backward_word()
	let cmdline = s:Base.make()
	call cmdline._init_variables()

	call cmdline._input(" __bbb")
	OwlCheck cmdline.backward_word() == "__bbb"
	OwlCheck cmdline.backward_word('[a-z]\+') == "bbb"

	call cmdline._input(" bbb  ")
	OwlCheck cmdline.backward_word() == "bbb  "

	call cmdline._input("(")
	OwlCheck cmdline.backward_word() == "("
endfunction


function! s:test_input_key_stack()
	let cmdline = s:Cmdline.make_standard()
	call cmdline.start("mami\<Esc>homu")
	OwlCheck cmdline.input_key_stack() == ["h", "o", "m", "u"]
	OwlCheck cmdline.input_key_stack_string() == "homu"
endfunction


function! s:test_issues_73()
	let cmdline = s:Cmdline.make_standard()
	let cmdline.cnoremap("h", "ho\<Esc>mu")
	echo cmdline.start("h")
	OwlCheck cmdline.getline() == "ho"
	OwlCheck cmdline.input_key_stack_string() == "mu"
endfunction


function! s:test_is_input_watting()
	let Base = s:Base
	let mapping = {
\		"a" : "b",
\		"aa" : "b",
\		"abc" : "b",
\		"c" : "d",
\		"A" : "d",
\	}

	OwlCheck  Base.is_input_waiting(mapping, "a")
	OwlCheck !Base.is_input_waiting(mapping, "bc")
	OwlCheck !Base.is_input_waiting(mapping, "aa")
	OwlCheck !Base.is_input_waiting(mapping, "c")
	OwlCheck !Base.is_input_waiting(mapping, ".")
	OwlCheck !Base.is_input_waiting(mapping, '\w')
	OwlCheck !Base.is_input_waiting(mapping, 'A')
endfunction


function! s:test_setchar()
	let cmdline = s:Base.make()
	call cmdline._init_variables()
	
	let cmdline._input_char("b")
	call cmdline.setchar("b")
	OwlCheck cmdline.variables.input ==# "b"
	call cmdline.setchar("c")
	OwlCheck cmdline.variables.input ==# "c"

	let cmdline._input_char("b")
	call cmdline.setchar("b")
	OwlCheck cmdline.variables.input ==# "b"
	call cmdline.setchar("c", 0)
	OwlCheck cmdline.variables.input ==# "b"
endfunction



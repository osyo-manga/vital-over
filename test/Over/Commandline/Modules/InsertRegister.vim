
call vital#of("vital").unload()
let s:Base = vital#of("vital").import("Over.Commandline.Base")
let s:Cmdline = vital#of("vital").import("Over.Commandline")


function! s:owl_begin()
	let g:owl_success_message_format = ""
	call vital#of("vital").unload()
endfunction

function! s:owl_end()
	let g:owl_success_message_format = "%f:%l:[Success] %e"
endfunction


function! s:test_get_cmdline_cword()
	let InsertRegister = vital#of("vital").import("Over.Commandline.Modules.InsertRegister")
	try
		let ignorecase = &ignorecase

		let &ignorecase = 1
		OwlCheck InsertRegister.get_cmdline_cword("cu", "cursor") == "rsor"
		OwlCheck InsertRegister.get_cmdline_cword("homu cu", "cursor") == "rsor"
		OwlCheck InsertRegister.get_cmdline_cword("homu cu", "CURSoR") == "RSoR"

		let &ignorecase = 0
		OwlCheck InsertRegister.get_cmdline_cword("cu", "cursor") == "rsor"
		OwlCheck InsertRegister.get_cmdline_cword("homu cu", "cursor") == "rsor"
		OwlCheck InsertRegister.get_cmdline_cword("homu cu", "CURSoR") != "RSoR"
	finally
		let &ignorecase = ignorecase
	endtry
endfunction


function! s:test_input_expr()
	let cmdline = s:Cmdline.make_standard()

	call cmdline.cnoremap("\<A-c>", "\<C-r>=1+2\<CR>")
	call cmdline.start("\<A-C>homu\<Esc>")
	OwlCheck cmdline.getline() == "3homu"

" 	call cmdline.start("\<C-r>=Homu")
endfunction


function! s:test_input_issues_83()
	let cmdline = s:Cmdline.make_standard()

	call cmdline.start("\<C-r>=1+2\<CR>homu\<Esc>")
	OwlCheck cmdline.getline() == "3homu"

" 	call cmdline.start("\<C-r>=Homu")
endfunction


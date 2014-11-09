
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


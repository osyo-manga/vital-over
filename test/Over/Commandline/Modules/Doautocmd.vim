
call vital#of("vital").unload()
let s:V = vital#of("vital")
let s:Base = s:V.import("Over.Commandline.Base")
let s:Cmdline = s:V.import("Over.Commandline")
let s:Doautocmd = s:V.import("Over.Commandline.Modules.Doautocmd") 

function! s:func()
	let cmdline = s:Doautocmd.get_cmdline()
	if cmdline.is_input("a")
		call cmdline.setchar("b")
	endif
endfunction


augroup test-vital-over-commandline-modules-doautocmd
	autocmd!
	autocmd User TestVitalOverCharPre call s:func()
augroup END


function! s:test_getcmdline()
	let cmdline = s:Cmdline.make_default()
	call cmdline.connect("Cancel")
	call cmdline.connect(s:Doautocmd.make("TestVitalOver"))
	
	call cmdline.start("aa\<Esc>")
	OwlCheck cmdline.getline() == "bb"
endfunction



call vital#of("vital").unload()
let s:Base = vital#of("vital").import("Over.Commandline.Base")
let s:Cmdline = vital#of("vital").import("Over.Commandline")


function! s:owl_begin()
	let g:owl_success_message_format = ""
endfunction

function! s:owl_end()
	let g:owl_success_message_format = "%f:%l:[Success] %e"
endfunction


function! Test()
	let cmdline = s:Cmdline.make_standard("$ ")
	call cmdline.connect("LiteralInsert")

	call cmdline.cnoremap("\<C-v>", "\<C-v>")
	call cmdline.cnoremap("\<A-c>", "\<C-v>\<Esc>")
	call cmdline.start()
endfunction


function! s:test_remap()
	let cmdline = s:Cmdline.make_default()
	call cmdline.connect("Cancel")
	call cmdline.connect("LiteralInsert")

	call cmdline.cnoremap("\<A-c>", "\<C-v>\<Esc>")
	
	call cmdline.start("\<A-c>\<Esc>")
	OwlCheck cmdline.getline() == "\<Esc>"
endfunction


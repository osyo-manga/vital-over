
call vital#of("vital").unload()
let s:Digraphs = vital#of("vital").import("Over.Commandline.Modules.Digraphs")
let s:digraphs = s:Digraphs.digraph()

function! s:test_backward_word()
	let d = s:digraphs
	OwlCheck d['NU'] ==# "\<C-j>"
	OwlCheck d['SH'] ==# "\<C-a>"
	OwlCheck d['SP'] ==# " "
	OwlCheck d['AC'] =~# "\x9f"
endfunction

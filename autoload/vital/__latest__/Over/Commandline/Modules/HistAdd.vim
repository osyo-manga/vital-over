scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


let s:module = {
\	"mode" : "cmd"
\}

function! s:module.on_leave(cmdline)
	call histadd("cmd", a:cmdline.getline())
endfunction


function! s:make(...)
	let module = deepcopy(s:module)
	let module.mode = get(a:, 1, "cmd")
	return module
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

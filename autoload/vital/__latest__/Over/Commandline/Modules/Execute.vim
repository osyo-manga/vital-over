scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! s:_is_input_enter(cmdline)
	return a:cmdline.is_input("\<CR>")
\		|| a:cmdline.is_input("\<NL>")
\		|| a:cmdline.is_input("\<C-j>")
endfunction


let s:module = {
\	"name" : "Execute"
\}

function! s:module.on_char_pre(cmdline)
	if s:_is_input_enter(a:cmdline)
		call self.execute(a:cmdline)
		call a:cmdline.exit(0)
	endif
	if a:cmdline.is_input("<Over>(execute-no-exit)")
		call self.execute()
		call a:cmdline.setchar("")
	endif
endfunction

function! s:module.execute(cmdline)
	return a:cmdline.execute(a:cmdline)
endfunction


function! s:make()
	return deepcopy(s:module)
endfunction


let s:empty = deepcopy(s:module)

function! s:empty.execute(...)
endfunction


function! s:make_no_execute()
	return deepcopy(s:empty)
endfunction




let &cpo = s:save_cpo
unlet s:save_cpo

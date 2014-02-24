scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:module = {
\	"name" : "DrawCommandline"
\}


function! s:suffix(left, suffix)
	let left_len = strdisplaywidth(a:left)
	let len = &columns - left_len % &columns
	let len = len + (&columns * (strdisplaywidth(a:suffix) > (len - 1))) - 1
	return repeat(" ", len - strdisplaywidth(a:suffix)) . a:suffix
" 	return printf("%" . len . "S", a:suffix)
endfunction


function! s:echon(expr)
	echon strtrans(a:expr)
endfunction


function! s:module.on_draw(cmdline)
	execute "echohl" a:cmdline.highlights.prompt
	call s:echon(a:cmdline.get_prompt())
	echohl NONE
	call s:echon(a:cmdline.backward())
	if empty(a:cmdline.line.pos_word())
		execute "echohl" a:cmdline.highlights.cursor
		call s:echon(' ')
	else
		execute "echohl" a:cmdline.highlights.cursor_on
		call s:echon(a:cmdline.line.pos_word())
	endif
	echohl NONE
	call s:echon(a:cmdline.forward())
	if	a:cmdline.get_suffix() != ""
		call s:echon(s:suffix(a:cmdline.get_prompt() . a:cmdline.getline() . repeat(" ", empty(a:cmdline.line.pos_word())), a:cmdline.get_suffix()))
	endif
endfunction


function! s:make()
	return deepcopy(s:module)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

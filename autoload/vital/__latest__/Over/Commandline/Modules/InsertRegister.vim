scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim



function! s:to_string(expr)
	return type(a:expr) == type("") ? a:expr : string(a:expr)
endfunction


function! s:input(cmdline)
	call a:cmdline.hl_cursor_on()
	try
		redraw
		let input = input("=", "", "expression")
		if !empty(input)
			let input = s:to_string(eval(input))
		endif
	catch
		return ""
	finally
		call a:cmdline.hl_cursor_off()
	endtry
	return input
endfunction

" Get first index of uncommon char in a:str between `a:line` and `a:str`
" echo s:first_uncommon_index('str', 'string') ==# 3
" echo s:first_uncommon_index('mami str', 'string') ==# 3
" echo s:first_uncommon_index('mami', 'string') ==# 0
function! s:first_uncommon_index(line, str)
	if empty(a:line)
		return 0
	endif
	let last_line_pos = len(a:line) - 1
	let index = stridx(a:str, a:line[last_line_pos])
	if index ==# -1
		return 0
	endif
	" Make sure the index is valid, otherwise return 0 with early return
	for i in range(len(a:str[:index]))
		if stridx(a:str, a:line[last_line_pos - i]) !=# (index - i)
			return 0
		endif
	endfor
	return index + 1
endfunction


function! s:get_insert_string(line, cword)
	return a:cword[s:first_uncommon_index(a:line, a:cword):]
endfunction


let s:module = {
\	"name" : "InsertRegister"
\}


function! s:module.on_char_pre(cmdline)
	if a:cmdline.is_input("\<C-r>")
		call a:cmdline.setchar('"')
		let self.prefix_key = a:cmdline.input_key()
		let self.old_line = a:cmdline.getline()
		let self.old_pos  = a:cmdline.getpos()
		let self.cword = expand("<cword>")
		let self.cWORD = expand("<cWORD>")
		let self.cfile = expand("<cfile>")
		return
	elseif exists("self.prefix_key")
\		&& a:cmdline.get_tap_key() == self.prefix_key
		call a:cmdline.setline(self.old_line)
		call a:cmdline.setpos(self.old_pos)
		let char = a:cmdline.input_key()
		if char =~ '^[0-9a-zA-z.%#:/"\-*+]$'
			let register = tr(getreg(char), "\n", "\r")
			call a:cmdline.setchar(register)
		elseif char == "="
			call a:cmdline.setchar(s:input(a:cmdline))
		elseif char == "\<C-w>"
			call a:cmdline.setchar(s:get_insert_string(a:cmdline.backward(), self.cword))
		elseif char == "\<C-a>"
			call a:cmdline.setchar(self.cWORD)
		elseif char == "\<C-f>"
			call a:cmdline.setchar(self.cfile)
		elseif char == "\<C-r>"
			call a:cmdline.setchar('"')
		else
			call a:cmdline.setchar("")
		endif
" 		elseif a:cmdline.is_input('=', self.prefix_key)
" 			call a:cmdline.setchar(s:input(a:cmdline))
" 		elseif a:cmdline.is_input("\<C-w>", self.prefix_key)
" 			call a:cmdline.setchar(self.cword)
" 		elseif a:cmdline.is_input("\<C-a>", self.prefix_key)
" 			call a:cmdline.setchar(self.cWORD)
" 		elseif a:cmdline.is_input("\<C-f>", self.prefix_key)
" 			call a:cmdline.setchar(self.cfile)
" 		elseif a:cmdline.is_input("\<C-r>", self.prefix_key)
" 			call a:cmdline.setchar('"')
" 		else
" 			call a:cmdline.setchar("")
" 		endif
	endif
endfunction


function! s:module.on_char(cmdline)
	if a:cmdline.is_input("\<C-r>")
		call a:cmdline.tap_keyinput(self.prefix_key)
		call a:cmdline.disable_keymapping()
		call a:cmdline.setpos(a:cmdline.getpos()-1)
	else
		if exists("self.prefix_key")
			call a:cmdline.untap_keyinput(self.prefix_key)
			call a:cmdline.enable_keymapping()
			unlet! self.prefix_key
		endif
	endif
endfunction



function! s:make()
	return deepcopy(s:module)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

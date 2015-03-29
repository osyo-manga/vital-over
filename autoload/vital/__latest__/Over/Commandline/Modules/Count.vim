scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


let s:module = {
\	"name" : "Count",
\	"vcount" : 0,
\	"vcount1" : 1,
\	"use_prefix" : 0,
\}

function! s:module._set_count(count)
	let self.vcount = a:count
	let self.vcount1 = a:count == 0 ? 1 : a:count
endfunction

function! s:module.on_char_pre(cmdline)
	if self.use_prefix && a:cmdline.is_input("<Over>(count-prefix)")
		call a:cmdline.setchar('')
		call a:cmdline.tap_keyinput('Count')
	elseif a:cmdline.char() =~# '\v[[:digit:]]' &&
	\	(!self.use_prefix || a:cmdline.get_tap_key() ==# 'Count')
		call a:cmdline.setchar('')
		call a:cmdline.tap_keyinput('Count')

		let new_count = str2nr(
		\		(self.vcount ==# 0) ?
		\		a:cmdline.char() : self.vcount . a:cmdline.char()
		\	)
		call self._set_count(new_count)
	else
		if a:cmdline.untap_keyinput('Count')
			call a:cmdline.callevent('on_char_pre')
		endif
		call self._set_count(0)
	endif
endfunction

function! s:make()
	return deepcopy(s:module)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: noet

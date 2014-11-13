scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

" Improved backward word detection which ignore regular expression
let s:module = {
\	"name" : "IgnoreRegexpBackwardWord"
\}

let s:non_escaped_backslash = '\m\%(\%(^\|[^\\]\)\%(\\\\\)*\)\@<=\\'

function! s:module.on_enter(cmdline)
	function! a:cmdline.backward_word(...)
		let pat = get(a:, 1, '\k\+\s*\|.')
		let flags = s:non_escaped_backslash .
		\   '\%(' . 'z[se]' .
		\   '\|' . '[iIkKfFpPsSdDxXoOwWhHaAlLuUetrbncCZmMvV]' .
		\   '\|' . '%[dxouUCVlcv]' .
		\   '\|' . "%'[a-Z]" .
		\   '\|' . '%#=\d' .
		\   '\|' . 'z\=\d' .
		\   '\)'
		return matchstr(get(split(self.backward(), flags . '\zs'), -1, ""),
		\   '\%(' . flags . '\|' . pat . '\)$')
	endfunction
endfunction

function! s:make()
	return deepcopy(s:module)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

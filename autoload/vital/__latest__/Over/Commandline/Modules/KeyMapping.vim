scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! s:_vital_loaded(V)
	let s:Keymapping = a:V.import("Over.Keymapping")
endfunction


function! s:_vital_depends()
	return [
\		"Over.Keymapping",
\	]
endfunction


let s:emacs = {
\	"name" : "KeyMapping_emacs_like"
\}

function! s:emacs.keymapping(cmdline)
	return {
\		"\<C-f>" : {
\			"key" : "\<Right>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<C-b>" : {
\			"key" : "\<Left>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<C-n>" : {
\			"key" : "\<Down>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<C-p>" : {
\			"key" : "\<Up>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<C-a>" : {
\			"key" : "\<Home>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<C-e>" : {
\			"key" : "\<End>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<C-d>" : {
\			"key" : "\<Del>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<A-d>" : {
\			"key" : "\<C-w>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<A-b>" : {
\			"key" : "\<S-Left>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\		"\<A-f>" : {
\			"key" : "\<S-Right>",
\			"noremap" : 1,
\			"lock" : 1,
\		},
\	}
endfunction


function! s:make_emacs()
	return deepcopy(s:emacs)
endfunction


let s:vim_cmdline_mapping = {
\	"name" : "KeyMapping_vim_cmdline_mapping"
\}

function! s:_auto_cmap()
	let cmaps = {}
	let cmap_info = s:Keymapping.cmap_rhss(0, 1)
	" vital-over currently doesn't support <expr> nor <buffer> mappings
	for c in filter(cmap_info, "v:val['expr'] ==# 0 && v:val['buffer'] ==# 0")
		let cmaps[s:Keymapping.escape_key(c['lhs'])] = {
		\   'noremap' : c['noremap'],
		\   'key' : s:Keymapping.escape_key(c['rhs']),
		\ }
	endfor
	return cmaps
endfunction


function! s:vim_cmdline_mapping.on_enter(cmdline)
	let self._cmaps = s:_auto_cmap()
endfunction


function! s:vim_cmdline_mapping.keymapping(cmdline)
	return self._cmaps
endfunction

function! s:make_vim_cmdline_mapping()
	return deepcopy(s:vim_cmdline_mapping)
endfunction



let s:vim_cmdline_mapping = {
\	"name" : "KeyMapping_vim_cmdline_mapping"
\}
let s:cmaps = {}

function! s:_auto_cmap()
	let verbose_save = &verbose
	let &verbose = 0
	try
		redir => redir_cmaps
		silent! cnoremap
		redir END
	finally
		let &verbose = verbose_save
	endtry
	if substitute(redir_cmaps, '\n', '', 'g') ==# 'No mapping found'
		return {}
	endif
	let cmap_info = map(split(redir_cmaps, '\n'), "maparg(split(v:val, '\\s\\+')[1], 'c', 0, 1)")
	let cmaps = {}
	" vital-over currently doesn't support <expr> nor <buffer> mappings
	for c in filter(cmap_info, "v:val['expr'] ==# 0 && v:val['buffer'] ==# 0")
		let cmaps[s:as_keymapping(c['lhs'])] = {
		\   'noremap' : c['noremap'],
		\   'key' : s:as_keymapping(c['rhs']),
		\ }
	endfor
	return cmaps
endfunction

function! s:as_keymapping(key)
	execute 'let result = "' . substitute(escape(a:key, '\'), '\(<.\{-}>\)', '\\\1', 'g') . '"'
	return result
endfunction

function! s:vim_cmdline_mapping.on_enter(cmdline)
	let s:cmaps = s:_auto_cmap()
endfunction

function! s:vim_cmdline_mapping.keymapping(cmdline)
	return s:cmaps
endfunction

function! s:make_vim_cmdline_mapping()
	return deepcopy(s:vim_cmdline_mapping)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

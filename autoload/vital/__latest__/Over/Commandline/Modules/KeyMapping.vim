scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

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
\	}
endfunction


function! s:make_emacs()
	return deepcopy(s:emacs)
endfunction



let s:cmap = {
\	"name" : "KeyMapping_cmap"
\}

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
	let cmap_list = map(split(redir_cmaps, '\n'), "split(v:val, '\\s\\+')")
	let cmaps = {}
	for x in cmap_list
		unlet x[0]
		let is_noremap = (x[1] ==# '*')
		if is_noremap
			unlet x[1]
		endif
		let cmaps[s:as_keymapping(x[0])] = {
		\   'noremap' : is_noremap,
		\   'key' : s:as_keymapping(join(x[1:], ' ')),
		\ }
	endfor
	return cmaps
endfunction

function! s:as_keymapping(key)
	execute 'let result = "' . substitute(a:key, '\(<.\{-}>\)', '\\\1', 'g') . '"'
	return result
endfunction

function! s:filter_cmap(cmaps)
	" workaround: avoid <expr> mappings...
	" It just assume there would be spaces with most <expr> mappings
	return filter(a:cmaps, "v:val['key'] !~# ' '")
endfunction

function! s:cmap.keymapping(cmdline)
	return s:filter_cmap(s:_auto_cmap())
endfunction

function! s:make_cmap()
	return deepcopy(s:cmap)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

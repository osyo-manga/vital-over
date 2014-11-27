scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim



function! s:_vital_loaded(V)
	let s:V = a:V
	let s:String  = s:V.import("Over.String")
endfunction


function! s:_vital_depends()
	return [
\		"Over.String",
\	]
endfunction



function! s:capture(cmd)
	let verbose_save = &verbose
	let &verbose = 0
	try
		redir => result
		execute "silent!" a:cmd
		redir END
	finally
		let &verbose = verbose_save
	endtry
	return result
endfunction


function! s:escape_key(key)
	execute 'let result = "' . substitute(escape(a:key, '\"'), '\(<.\{-}>\)', '\\\1', 'g') . '"'
	return result
endfunction


function! s:parse_mapping_lhs(map, mode)
	return matchstr(a:map, a:mode . '\s\+\zs\S\{-}\ze\s\+')
endfunction


function! s:lhss(mode)
	let maps = s:capture(a:mode . "map")
	return filter(map(split(maps, "\n"), "s:parse_mapping_lhs(v:val, a:mode)"), 'v:val =~ ''\S\+''')
endfunction


function! s:rhss(mode, ...)
	let abbr = get(a:, 1, 0)
	let dict = get(a:, 2, 0)
	return map(s:lhss(a:mode), "maparg(v:val, a:mode, abbr, dict)")
endfunction


function! s:cmap_lhss()
	return s:lhss("c")
endfunction


function! s:cmap_rhss(...)
	return call("s:rhss", ["c"] + a:000)
endfunction



function! s:_as_key_config(config)
	let base = {
\		"noremap" : 0,
\		"lock"    : 0,
\	}
	return type(a:config) == type({}) ? extend(base, a:config)
\		 : extend(base, {
\		 	"key" : a:config,
\		 })
endfunction


function! s:match_key(keymapping, key)
	let keys = sort(keys(a:keymapping))
	return get(filter(keys, 'a:key =~# ''^'' . v:val'), -1, '')
endfunction


function! s:unmapping(keymapping, key, ...)
	let is_locking = get(a:, 1, 0)
	let key = s:match_key(a:keymapping, a:key)
	if key == ""
		return s:String.length(a:key) <= 1 ? a:key : s:unmapping(a:keymapping, a:key[0], is_locking) . s:unmapping(a:keymapping, a:key[1:], is_locking)
	endif

	let map_conf = s:_as_key_config(a:keymapping[key])

	let next_input = s:unmapping(a:keymapping, a:key[len(key) : ], is_locking)
	if map_conf.lock == 0 && is_locking
		return key . next_input
	elseif map_conf.lock
		return s:unmapping(a:keymapping, map_conf.key, is_locking) . next_input
	else
		return s:unmapping(a:keymapping, map_conf.key, map_conf.noremap) . next_input
	endif
endfunction



let &cpo = s:save_cpo
unlet s:save_cpo

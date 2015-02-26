scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim



function! s:_vital_loaded(V)
	let s:V = a:V
	let s:String  = s:V.import("Over.String")
	let s:List    = s:V.import("Data.List")
endfunction


function! s:_vital_depends()
	return [
\		"Over.String",
\	]
endfunction


let s:keyconf_base = {
\	"noremap" : 0,
\	"lock"    : 0,
\	"expr"    : 0,
\	"regex_match" : 0,
\}


function! s:keyconf_base.is_match(key, input)
	return self.regex_match
\		 ? a:input =~ '^' . a:key
\		 : stridx(a:input, a:key) == 0

endfunction


function! s:as_key_config(config)
	let base = deepcopy(s:keyconf_base)
	return type(a:config) == type({}) ? extend(base, a:config)
\		 : extend(base, {
\		 	"key" : a:config,
\		 })
endfunction


function! s:as_keymapping(data)
	return map(copy(a:data), "s:as_key_config(v:val)")
endfunction


function! s:_is_match(config, key, input)
	return get(a:config, "regex_match", 0)
\		 ? a:input =~ '^' . a:key
\		 : stridx(a:input, a:key) == 0
endfunction


function! s:match_key_conf(keymapping, key)
" 	return get(s:List.sort_by(items(filter(copy(a:keymapping), "v:val.is_match(v:key, a:key)")), "v:val[0]"), -1, ["", {}])
	return get(s:List.sort_by(items(filter(map(copy(a:keymapping), "s:as_key_config(v:val)"), "v:val.is_match(v:key, a:key)")), "v:val[0]"), -1, ["", {}])
endfunction


function! s:match_key(keymapping, key)
	return get(s:match_key_conf(a:keymapping, a:key), 0, "")
" 	let keys = sort(keys(a:keymapping))
" 	return get(filter(keys, 'stridx(a:key, v:val) == 0'), -1, '')
endfunction


function! s:_safe_eval(expr, ...)
	call extend(l:, get(a:, 1, {}))
	let vital_over_result = get(a:, 2, "")
	try
		let vital_over_result = eval(a:expr)
	catch
		echohl ErrorMsg | echom v:exception | echohl None
	endtry
	return vital_over_result
endfunction


function! s:_get_key(conf)
" 	call extend(l:, a:conf)
	let self = a:conf
	return get(a:conf, "expr", 0) ? s:_safe_eval(a:conf.key, l:) : a:conf.key
endfunction


function! s:_unmapping(keymapping, key, ...)
	if has_key(s:cache, a:key)
		return s:cache[a:key]
	endif
	let is_locking = get(a:, 1, 0)
	let [key, map_conf] = s:match_key_conf(a:keymapping, a:key)
	if key == ""
		return s:String.length(a:key) <= 1 ? a:key : s:_unmapping(a:keymapping, a:key[0], is_locking) . s:_unmapping(a:keymapping, a:key[1:], is_locking)
	endif

	let next_input = s:_unmapping(a:keymapping, a:key[len(key) : ], is_locking)
	if map_conf.lock == 0 && is_locking
		let result = key . next_input
	elseif map_conf.lock
		let result = s:_unmapping(a:keymapping, s:_get_key(map_conf), is_locking) . next_input
	else
		let result = s:_unmapping(a:keymapping, s:_get_key(map_conf), map_conf.noremap) . next_input
	endif
	let s:cache[a:key] = result
	return s:cache[a:key]
endfunction


function! s:unmapping(keymapping, key, ...)
	let s:cache = {}
	return s:_unmapping(s:as_keymapping(a:keymapping), a:key, get(a:, 1, 0))
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

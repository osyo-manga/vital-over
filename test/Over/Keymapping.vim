
call vital#of("vital").unload()
let s:Keymapping = vital#of("vital").import("Over.Keymapping")

function! s:test_match_key()
	let Keymapping = s:Keymapping

	let map = {
\		"a" : "bc",
\		"b" : "00",
\		"bc" : "11",
\		"def" : "bc",
\		"de" : "bc",
\		"\<CR>\<Down>" : "bc",
\		"e" : "aa",
\		"ef" : "aa",
\		"efg" : "aa",
\	}

" 	echo Keymapping.match_key(map, "b")
" 	echo Keymapping.match_key(map, "bc")
" 	echo Keymapping.match_key(map, "bcd")

	OwlCheck Keymapping.match_key(map, "") is ""
	OwlCheck Keymapping.match_key(map, "a") is "a"
	OwlCheck Keymapping.match_key(map, "ab") is "a"
	OwlCheck Keymapping.match_key(map, "ba") is "b"
	OwlCheck Keymapping.match_key(map, "bcde") is "bc"
	OwlCheck Keymapping.match_key(map, "b") is "b"
	OwlCheck Keymapping.match_key(map, "bc") is "bc"
	OwlCheck Keymapping.match_key(map, "d") is ""
	OwlCheck Keymapping.match_key(map, "de") is "de"
	OwlCheck Keymapping.match_key(map, "def") is "def"
	OwlCheck Keymapping.match_key(map, "defaa") is "def"
	OwlCheck Keymapping.match_key(map, "\<CR>") is ""
	OwlCheck Keymapping.match_key(map, "\<CR>\<Down>") is "\<CR>\<Down>"
	OwlCheck Keymapping.match_key(map, "e") is "e"
	OwlCheck Keymapping.match_key(map, "ef") is "ef"
	OwlCheck Keymapping.match_key(map, "efg") is "efg"
	OwlCheck Keymapping.match_key(map, "efga") is "efg"
endfunction


function! s:test_unmapping()
	let Keymapping = s:Keymapping

	let map = {
\		"a" : "bc",
\		"b" : "00",
\		"bc" : "11",
\		"def" : "b",
\		"\<Down>\<Up>" : "\<Left>",
\		"\<Left>" : "\<Right>",
\		"\<Right>\<Left>" : "\<Up>",
\		"gh" : "b"
\	}
	OwlCheck Keymapping.unmapping(map, "bc") is "11"
	OwlCheck Keymapping.unmapping(map, "bb") is "0000"
	OwlCheck Keymapping.unmapping(map, "abc") is "1111"
	OwlCheck Keymapping.unmapping(map, "defc") is "00c"
	OwlCheck Keymapping.unmapping(map, "\<Down>\<Up>") is "\<Right>"
	OwlCheck Keymapping.unmapping(map, "\<Right>\<Left>\<Left>") is "\<Up>\<Right>"
	OwlCheck Keymapping.unmapping(map, "\<Right>\<Right>") is "\<Right>\<Right>"
	OwlCheck Keymapping.unmapping(map, "gh") is "00"
endfunction


function! s:test_unmapping_noremap()
	let Keymapping = s:Keymapping

	let map = {
\		"a" : { "key" : "bc", "noremap" : 1 },
\		"bc" : "a",
\	}
	OwlCheck Keymapping.unmapping(map, "a") is "bc"
	OwlCheck Keymapping.unmapping(map, "bc") is "bc"
endfunction


function! s:test_unmapping_lock()
	let Keymapping = s:Keymapping
	let map = {
\		"\<C-l>" : {
\			"key" : "\<C-f>",
\			"lock" : 0,
\			"noremap" : 1,
\		},
\		"\<C-h>" : {
\			"key" : "\<C-b>",
\			"lock" : 0,
\			"noremap" : 1,
\		},
\		"\<C-f>" : {
\			"key" : "\<Right>",
\			"lock" : 1,
\			"noremap" : 1,
\		},
\		"\<C-b>" : {
\			"key" : "\<Left>",
\			"lock" : 0,
\			"noremap" : 1,
\	   },
\		"h" : {
\			"key" : "ho\<C-f>mu",
\			"lock" : 0,
\			"noremap" : 1,
\	   },
\		"a" : {
\			"key" : "c_",
\			"lock" : 1,
\			"noremap" : 1,
\	   },
\		"b" : {
\			"key" : "nacab",
\			"lock" : 0,
\			"noremap" : 1,
\	   },
\		"c" : {
\			"key" : "m",
\			"lock" : 0,
\			"noremap" : 0,
\	   },
\		"_" : {
\			"key" : "-",
\			"lock" : 1,
\			"noremap" : 1,
\		},
\		"aa" : "b"
\	}

	OwlCheck Keymapping.unmapping(map, "\<C-l>") is "\<Right>"
	OwlCheck Keymapping.unmapping(map, "\<C-f>") is "\<Right>"
	OwlCheck Keymapping.unmapping(map, "\<C-h>") is "\<C-b>"
	OwlCheck Keymapping.unmapping(map, "\<Down>\<C-l>\<C-l>\<C-f>") is "\<Down>\<Right>\<Right>\<Right>"
	OwlCheck Keymapping.unmapping(map, "\<Down>\<C-l>\<C-l>\<C-f>") is "\<Down>\<Right>\<Right>\<Right>"
	OwlCheck Keymapping.unmapping(map, "h") is "ho\<Right>mu"
	OwlCheck Keymapping.unmapping(map, "b") is "nc-cc-b"
	OwlCheck Keymapping.unmapping(map, "aa") is "nc-cc-b"
endfunction







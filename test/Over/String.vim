
function! s:owl_begin()
	let g:owl_success_message_format = ""
	call vital#of("vital").unload()
endfunction

function! s:owl_end()
	let g:owl_success_message_format = "%f:%l:[Success] %e"
endfunction


function! s:_test_split()
	let owl_SID = owl#filename_to_SID("vital-over/autoload/vital/__latest__/Over/String.vim")
	OwlCheck s:split_by_keys("abcd") == ["a", "b", "c", "d"]
	OwlCheck s:split_by_keys("\<Down>") == ["\<Down>"]
	OwlCheck s:split_by_keys("\<Down>a") == ["\<Down>", "a"]
	OwlCheck s:split_by_keys("\<Down>\<BS>") == ["\<Down>", "\<BS>"]
	OwlCheck s:split_by_keys("\<Down>\<BS>\<BS><BS>") == ["\<Down>", "\<BS>", "\<BS>", "<", "B", "S", ">"]
	OwlCheck s:split_by_keys("\<C-a>+") == ["\<C-a>", "+"]
	OwlCheck s:split_by_keys("<Over>(scroll-e)") == ["<Over>(scroll-e)"]
	OwlCheck s:split_by_keys("\<CR>") == ["\<CR>"]
	OwlCheck s:split_by_keys("\<A-Space>\<CR>\<A-Down>") == ["\<A-Space>", "\<CR>", "\<A-down>"]
	OwlCheck s:split_by_keys("234567") == ["2", "3", "4", "5", "6", "7"]
endfunction


function! s:test_split()
	let old = &re
	try
		let &re = 1
		call s:_test_split()
		let &re = 2
		call s:_test_split()
	finally
		let &re = old
	endtry
endfunction


function! s:test_index()
	let String = vital#of("vital").import("Over.String")
	try
		let ignorecase = &ignorecase
		let &ignorecase = 1
		OwlCheck String.index("An Example", "Example") == 3
		OwlCheck String.index("An Example", "example") == 3
		OwlCheck String.index("An Example", "Example", 4) == -1

		OwlCheck String.index("An Example", "Example", 0, 0) == 3
		OwlCheck String.index("An Example", "example", 0, 0) == -1
		OwlCheck String.index("An Example", "example", 0, 1) == 3

		let &ignorecase = 0
		OwlCheck String.index("An Example", "example") == -1
		OwlCheck String.index("An Example", "Example", 0, 0) == 3
		OwlCheck String.index("An Example", "example", 0, 0) == -1
		OwlCheck String.index("An Example", "example", 0, 1) == 3
	finally
		let &ignorecase = ignorecase
	endtry
endfunction



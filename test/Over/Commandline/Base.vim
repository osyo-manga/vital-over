
function! s:owl_begin()
	let g:owl_success_message_format = ""
endfunction

function! s:owl_end()
	let g:owl_success_message_format = "%f:%l:[Success] %e"
endfunction


function! s:test_split()
	let owl_SID = owl#filename_to_SID("vital-over/autoload/vital/__latest__/Over/Commandline/Base.vim")
	OwlCheck s:_split_keys("abcd") == ["a", "b", "c", "d"]
	OwlCheck s:_split_keys("\<Down>") == ["\<Down>"]
	OwlCheck s:_split_keys("\<Down>a") == ["\<Down>", "a"]
	OwlCheck s:_split_keys("\<Down>\<BS>") == ["\<Down>", "\<BS>"]
	OwlCheck s:_split_keys("\<Down>\<BS>\<BS><BS>") == ["\<Down>", "\<BS>", "\<BS>", "<", "B", "S", ">"]
	OwlCheck s:_split_keys("\<C-a>+") == ["\<C-a>", "+"]
	OwlCheck s:_split_keys("<Over>(scroll-e)") == ["<Over>(scroll-e)"]
endfunction




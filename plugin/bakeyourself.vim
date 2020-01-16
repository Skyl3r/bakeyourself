let g:cake_file_name = expand('%:t:r')
let g:cake_file_extension = expand('%:e')
let g:cake_file_type = '-1'
let g:cake_project_root = '.'

let g:cake_controller_name = ''
let g:cake_path_to_template = ''

"Identify file type:
if match(cake_file_name, 'Controller$') > -1
	let g:cake_file_type = 'controller'
elseif match(cake_file_name, 'Component$') > -1
	let g:cake_file_type = 'component'
elseif match(cake_file_name, 'Table$') > -1
	let g:cake_file_type = 'model'
elseif match(cake_file_extension, 'ctp') > -1
	let g:cake_file_type = 'template'
endif


"Function gets last defined PHP function and returns it's name
function! GetLastFunction()

	let l:cake_function_to_cursor_list = [] | 1,.s/function\s\+\(.*\)(.*)\s*{\zs/\=add(cake_function_to_cursor_list, submatch(1))[1:0]
	return cake_function_to_cursor_list[len(l:cake_function_to_cursor_list) - 1]

endfunction

function! CakeOpenTemplateFile()
	let g:cake_controller_name = tolower(substitute(g:cake_file_name, "Controller", "", ""))
	let g:cake_path_to_template = g:cake_project_root . "/Template/" . g:cake_controller_name . "/" . GetLastFunction() . ".ctp"
	execute 'vsp ' . g:cake_path_to_template
endfunction

"Choose mappings based on file type...
if cake_file_type == 'controller'
	"Set mappings for navigate to template...
	"Ctrl+g will be the Go command

	nmap <F5> :call CakeOpenTemplateFile()<CR>
endif

if cake_file_type == 'template'
	"set mappings for navigate to controller...
endif

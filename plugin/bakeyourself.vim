let cake_file_name = expand('%:t')
let cake_file_extension = expand('%:e')
let cake_file_type = '-1'

"Identify file type:
if match(cake_file_name, 'Controller$') > -1
	cake_file_type = 'controller'
elseif match(cake_file_name, 'Component$') > -1
	cake_file_type = 'component'
elseif match(cake_file_name, 'Table$') > -1
	cake_file_type = 'model'
elseif match(cake_file_extension, 'ctp') > -1
	cake_file_type = 'template'
endif


"Function gets last defined PHP function and returns it's name
function! GetLastFunction()

	let cake_function_to_cursor_list = [] | 1,.s/function\s\+\(.*\)(.*)\s*{\zs/\=add(cake_function_to_cursor_list, submatch(1))[1:0]
	return cake_function_to_cursor_list[len(cake_function_to_cursor_list) - 1]

endfunction

"Choose mappings based on file type...
if cake_file_type == 'controller'
	"Set mappings for navigate to template...
	"Ctrl+g will be the Go command
	let cake_controller_name = tolower(substitute(cake_file_name, "Controller", "", ""))

	map <C-g> execute "../template/" . cake_controller_name . GetLastFunction()
endif

if cake_file_type == 'template'
	"set mappings for navigate to controller...
endif

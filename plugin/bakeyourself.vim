let g:cake_open_file_command = 'vsp'

let b:cake_file_name = expand('%:t:r')
let b:cake_file_extension = expand('%:e')
let b:cake_file_type = '-1'
let b:cake_containing_folder = ''

let b:cake_controller_name = ''
let b:cake_project_root = '.'

"Identify file type:
if match(b:cake_file_name, 'Controller$') > -1
	let b:cake_file_type = 'controller'
elseif match(b:cake_file_name, 'Component$') > -1
	let b:cake_file_type = 'component'
elseif match(b:cake_file_name, 'Table$') > -1
	let b:cake_file_type = 'model'
elseif match(b:cake_file_extension, 'ctp') > -1
	let b:cake_file_type = 'template'
endif


function! GetCakeFileType()
	let b:cake_file_name = expand('%:t:r')
	let b:cake_file_extension = expand('%:e')
	let b:cake_file_type = '-1'

	let b:cake_controller_name = ''
	let b:cake_project_root = '.'

	"Identify file type:
	if match(b:cake_file_name, 'Controller$') > -1
		let b:cake_file_type = 'controller'
	elseif match(b:cake_file_name, 'Component$') > -1
		let b:cake_file_type = 'component'
	elseif match(b:cake_file_name, 'Table$') > -1
		let b:cake_file_type = 'model'
	elseif match(b:cake_file_extension, 'ctp') > -1
		let b:cake_file_type = 'template'
	endif

endfunction


"Function gets last defined PHP function and returns it's name
function! GetLastFunction()

	let l:cake_function_to_cursor_list = [] | 1,.s/function\s\+\(.*\)(.*)\s*{\zs/\=add(cake_function_to_cursor_list, submatch(1))[1:0]
	return cake_function_to_cursor_list[len(l:cake_function_to_cursor_list) - 1]

endfunction

function! CakeOpenTemplate()
	"Check if we're in a controller

	call GetCakeFileType()
	if b:cake_file_type != 'controller'
		echo "Not a controller!"
		return
	endif

	let b:cake_controller_name = substitute(b:cake_file_name, "Controller", "", "")
	let b:cake_path_to_template = b:cake_project_root . "/src/Template/" . b:cake_controller_name . "/" . GetLastFunction() . ".ctp"

	execute g:cake_open_file_command . ' ' . b:cake_path_to_template

endfunction

function! CakeOpenController()
	call GetCakeFileType()
	if b:cake_file_type != 'template'
		echo "Not a template!"
		return
	endif

	let b:cake_containing_folder = split(expand('%:p:h'), '/')[-1]

	execute g:cake_open_file_command . ' ' . b:cake_project_root . '/src/Controller/' . b:cake_containing_folder . 'Controller.php'

endfunction

# BakeYourself.vim

__Please note, this is a work in progress and you should use with care__

BakeYourself is a CakePHP plugin that will provide nice navigation through CakePHP projects. Currently it works under the assumption that you will open the project in vim from the root of your CakePHP project.

### Variables:
```
g:cake_open_file_command = 'vsp'  " default. You can set this to whatever is convenient.
```

### Functions:

__CakeOpenTemplate()__
Call from within an action to go to the template for that action. Will create a file if one doesn't exist.
Also note, that there's currently an issue with how it functions. It gets the name of the action by looking for the function you are inside of. This can cause issues if you define functions within actions.

__CakeOpenController()__
Call from within a templatee to go to the controller for that template. Will create a file if one doesn't exist.
The controller name is assumed to be the same as the folder name that the template file is within.

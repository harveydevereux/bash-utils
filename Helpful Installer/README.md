## Script to help with installing system/python packages

Starting with a .py file example.py (containing some imported packages) 

- run *./py-to-namefile example.py* to generate the install script's namefile *example.py.namefile*
- run *./install-required-packages -f example.py.namefile* to run the helpful installer

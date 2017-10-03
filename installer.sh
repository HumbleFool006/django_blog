#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin:.
PYTHON_BIN_PATH=''
SED_PRESENT=''
SUCCESS=0
WARNING=1
FAILURE=2
S247_HOME="/opt/site24x7"
VENV_HOME="$S247_HOME/venv"
DOWNLOADER_CMD='curl --progress-bar -LO --insecure'
print_green() {
    printf "\033[32m%s\033[0m\n" "$*"
}

print_console() {
    printf "%s\n" "$*"
}

print_red() {
    printf "\033[31m%s\033[0m\n" "$*"
}


print_done() {
    print_green "Done"
}


check_python_attendance(){
	if command -v python3.4; then
    	PYTHON_BIN_PATH="python3.4"
    elif command -v python2; then
        PYTHON_BIN_PATH="python2"
    elif command -v python3.3; then
    	PYTHON_BIN_PATH="python3.3"
    elif command -v python3; then
    	PYTHON_BIN_PATH="python3"
    elif command -v python2.7; then
    	PYTHON_BIN_PATH="python2.7"
    elif command -v python; then
        PYTHON_BIN_PATH="python"
    else 
    	print_red "Python not found" 
    	exit $FAILURE
    fi
}

check_sed_attendance(){
	if command -v sed; then
		SED_PRESENT="True"
		print_green "Sed found"
	else
		print_red "Sed Not found"
		exit $FAILURE
	fi
}

check_awk_attendance(){
	if command -v sed; then
		AWK_PRESENT="True"
		print_green "awk found"
	else
		print_red "awk Not found"
		exit $FAILURE
	fi
}

check_python_attendance
print_green "Python found "
check_sed_attendance
check_awk_attendance

get_venv_file(){
	$DOWNLOADER_CMD https://raw.githubusercontent.com/pypa/virtualenv/1.11.6/virtualenv.py
}

occupy_opt_folder(){

	mkdir -p /opt/ 2>&1>/dev/null
	if [ -d "/opt/site24x7/monagent" ]; then
		print_red "agent already installed"
		exit $FAILURE
	else
		mkdir -p $S247_HOME 2>&1>/dev/null
		cd $S247_HOME
	fi
}

run_venv_file(){
	print_console "* Setting up a python virtual env"
	$PYTHON_BIN_PATH virtualenv.py --no-pip --no-setuptools "$VENV_HOME"
	rm -f "$S247_HOME/virtualenv.py"
	rm -f "$S247_HOME/virtualenv.pyc"
	print_done
}

set_py_variables(){
	print_console "* Activating the virtual env"
	. "$VENV_HOME/bin/activate"
	PIP_VERSION="6.1.1"
	VIRTUALENV_VERSION="1.11.6"
	SETUPTOOLS_VERSION="20.9.0"
	VENV_PYTHON_CMD="$S247_HOME/venv/bin/python"
	VENV_PIP_CMD="$S247_HOME/venv/bin/pip"
	print_done
}

install_packages(){
	print_console "* Setting up setuptools"
	$DOWNLOADER_CMD https://raw.githubusercontent.com/HumbleFool006/django_blog/master/ez_setup.py
	$VENV_PYTHON_CMD "ez_setup.py" --version="$SETUPTOOLS_VERSION" --to-dir=$S247_HOME
	rm -f "$S247_HOME/setuptools-$SETUPTOOLS_VERSION.zip"
	rm -f "$S247_HOME/ez_setup.py"
	rm -f "$S247_HOME/ez_setup.pyc"
	print_done
	print_console "* Setting up pip"
	$DOWNLOADER_CMD https://github.com/HumbleFool006/django_blog/blob/master/get-pip.py?raw=true
	mv get-pip.py?raw=true get-pip.py
	$VENV_PYTHON_CMD get-pip.py
	$VENV_PIP_CMD install "pip==$PIP_VERSION"
	rm -f get-pip.py
	rm -f get-pip.pyc
	print_done
}

use_pip_install(){
	print_console "* Installing packages using pip"
	$VENV_PIP_CMD install psutil 2>&1>/dev/null
	$VENV_PIP_CMD install requests 2>&1>/dev/null
	$VENV_PIP_CMD install docker-py 2>&1>/dev/null
	$VENV_PIP_CMD install pyparsing 2>&1>/dev/null
	$VENV_PIP_CMD install pycrypto 2>&1>/dev/null
	print_done
}

main(){
	echo $PYTHON_BIN_PATH
	occupy_opt_folder
	print_console "* Setting up a python virtual env"
	get_venv_file
	print_done
	run_venv_file
	set_py_variables
	install_packages
	use_pip_install
	$DOWNLOADER_CMD https://github.com/HumbleFool006/django_blog/blob/master/agent_framework.tar.gz?raw=true
	mkdir monagent
	mv agent_framework.tar.gz?raw=true agent_framework.tar.gz
	cp  agent_framework.tar.gz monagent
	cd monagent
	tar -zxf agent_framework.tar.gz
	touch agent_framework/source/python3.3/src/com/manageengine/virtual_env
	$VENV_PYTHON_CMD agent_framework/source/python3.3/src/com/manageengine/monagent/MonitoringAgent.py  &
}

main

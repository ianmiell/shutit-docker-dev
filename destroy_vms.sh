#!/bin/bash
NAME=ubuntu-xenial-16.04-cloudimg
if [[ $(command -v VBoxManage) != '' ]]
then
	while true 
	do
		VBoxManage list runningvms | grep $NAME | awk '{print $1}' | xargs -IXXX VBoxManage controlvm 'XXX' poweroff && VBoxManage list vms | grep $NAME | awk '{print $1}'  | xargs -IXXX VBoxManage unregistervm 'XXX' --delete
		if [[ $(VBoxManage list vms | grep $NAME| wc -l) -eq '0' ]]
		then
			break
		else
			ps -ef | grep virtualbox | grep $NAME | awk '{print $2}' | xargs kill
			sleep 10
		fi
	done
fi

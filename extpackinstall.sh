#!/bin/bash
version=$(vboxmanage -v | tail -1)
var1=$(echo $version | cut -d 'r' -f 1)
var2=$(echo $version | cut -d 'r' -f 2)
var3=$(echo $version | cut -d '.' -f1 )
var4=$(echo $version | cut -d '.' -f2 )
file="Oracle_VM_VirtualBox_Extension_Pack-$var1-$var2.vbox-extpack"
url1="http://download.virtualbox.org/virtualbox/$var1/$file"
paquete="virtualbox-$var3.$var4"

if [ $(vboxmanage -v | grep vboxconfig | wc -l) -gt 0 ];then
	sudo /sbin/vboxconfig
fi
if [ $(vboxmanage -v | grep vboxconfig | wc -l) -gt 0 ];then
  # quizas estas opciones es mejor hacerlas a mano ya que puede implicar interactividad
  # yes "s" | sudo apt purge virtualbox*
  # sudo apt install $paquete
  echo ejecuta estos comando y vuelve a lanzar este script
  echo ---------------------------------------------------
  echo sudo apt purge virtualbox*
  echo sudo apt install $paquete
  echo ---------------------------------------------------
fi
if [ $(vboxmanage -v | grep vboxconfig | wc -l) -eq 0 ];then
	wget $url1 -O /tmp/$file
	if [ $? -eq 0 ];then
		sudo VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
		yes | sudo VBoxManage extpack install /tmp/$file --replace
	else
		echo "ha ocurrido un error con la descarga del extpack. Numero de error: $?"
	fi
else
	echo hay problema con vboxconfig y no se ha instalado el extension pack $file
fi

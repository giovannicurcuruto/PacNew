#!/bin/bash
# Script dedicado para o envio de fluxos
# PacNew

ajustaParametros(){
	sudo arp -a > ./config/arqBruto.txt
	sed -i '/incompleto/d' ./config/arqBruto.txt
	sed 's/?\|em/\t/g' ./config/arqBruto.txt > ./config/lixoArp.txt
#	grep -i -n -w $ip_recep ./config/lixoArp.txt > ./config/utilArp.txt
        grep -i -n -w $ip_recep ./config/lixoArp.txt > ./config/utilArp.txt
	tr '\t' "\n" < ./config/utilArp.txt > ./config/1Arp.txt 
	sed 's/\[ether]//g' ./config/1Arp.txt > ./config/2Arp.txt
	sed 's/)//g' ./config/2Arp.txt > ./config/3Arp.txt
	sed 's/(//g' ./config/3Arp.txt > ./config/4Arp.txt
	sed -n '2p' ./config/4Arp.txt > ./config/ip1.txt
	sed -n '3p' ./config/4Arp.txt > ./config/mac1.txt
	sed -n '4p' ./config/4Arp.txt > ./config/interface1.txt
	sed 's/ //g' ./config/ip1.txt > ./config/IP
	sed 's/ //g' ./config/mac1.txt > ./config/MAC_R
	sed 's/ //g' ./config/interface1.txt > ./config/INTERFACE
}

enviaFrame1(){
	echo enviando 4 prioridades
	sudo python gop0.py | sudo python gop1.py | sudo python gop2.py | sudo python gop3.py
}

enviaFrame2(){
	echo enviando outras 4 prioridades
	sudo python gop4.py | sudo python gop5.py | sudo python gop6.py | sudo python gop7.py
}

enviaFrameAll(){
	echo envia prio 0
	sudo python gop0.py 
	echo envia prio 1
	sudo python gop1.py
	echo envia prio 2
	sudo python gop2.py
	echo envia prio 3
	sudo python gop3.py
	echo envia prio 4
	sudo python gop4.py 
	echo envia prio 5
	sudo python gop5.py
	echo envia prio 6
	sudo python gop6.py
	echo envia prio 7
	sudo python gop7.py

}




echo Antes de iniciar, vamos limpar a tela...
sleep 3
clear

echo Informe o endereço IP da maquina receptora.
read ip_recep
ping -c 1 $ip_recep
echo 
ajustaParametros
echo
echo Adquirindo o MAC da maquina transmissora.
var=$(cat ./config/INTERFACE)
sudo ifconfig  $var | grep -i hw | awk '{print $7}' > ./config/MAC_T

echo IP do receptor: $ip_recep
echo
echo MAC do receptor: 
cat ./config/MAC_R
echo
echo MAC do transmissor:
cat ./config/MAC_T
echo
echo Interface de saída:
cat ./config/INTERFACE
echo
echo Nesta maquina deseja enviar os pacotes com prioridade [0, 1, 2, 3] ou [4, 5, 6, 7]?
echo Para [0, 1, 2, 3] digite \"1\"
echo Para [4, 5, 6, 7] digite \"2\"
read OP

if [ "$OP" = "1" ]
then
	enviaFrame1
elif [ "$OP" = "2" ]
then
	enviaFrame2
else
	echo Opção incorreta. Encerrando...
fi





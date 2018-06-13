#!/bin/bash

###########################################################################################################3

prioridades(){
	pv0 = "0"
	pv1 = "0"
	pv2 = "0"
	pv3 = "0"
	pv4 = "0"
	pv5 = "0"
	pv6 = "0"
	pv7 = "0"

	v0=$(ls -l ./Receiving/p0 | awk '{print $5}')
	if [ $v0 = "0" ]
	then
		echo Prioridade 0: Não
		pv0="0"	
	else
		echo Prioridade 0: Sim
		pv0="1"
		
	fi
	v1=$(ls -l ./Receiving/p1 | awk '{print $5}')
	if [ $v1 = "0" ]
	then
		echo Prioridade 1: Não
		pv1="0"	
	else
		echo Prioridade 1: Sim
		pv1="1"
	fi
	v2=$(ls -l ./Receiving/p2 | awk '{print $5}')
	if [ $v2 = "0" ]
	then
		echo Prioridade 2: Não
		pv2="0"	
	else
		echo Prioridade 2: Sim
		pv2="1"
	fi
	v3=$(ls -l ./Receiving/p3 | awk '{print $5}')
	if [ $v3 = "0" ]
	then
		echo Prioridade 3: Não
		pv3="0"	
	else
		echo Prioridade 3: Sim
		pv3="1"
	fi
	v4=$(ls -l ./Receiving/p4 | awk '{print $5}')
	if [ $v4 = "0" ]
	then
		echo Prioridade 4: Não	
		pv4="0"
	else
		echo Prioridade 4: Sim
		pv4="1"
	fi
	v5=$(ls -l ./Receiving/p5 | awk '{print $5}')
	if [ $v5 = "0" ]
	then
		echo Prioridade 5: Não	
		pv5="0"
	else
		echo Prioridade 5: Sim
		pv5="1"
	fi
	v6=$(ls -l ./Receiving/p6 | awk '{print $5}')
	if [ $v6 = "0" ]
	then
		echo Prioridade 6: Não	
		pv6="0"
	else
		echo Prioridade 6: Sim
		pv6="1"
	fi
	v7=$(ls -l ./Receiving/p7 | awk '{print $5}')
	if [ $v7 = "0" ]
	then
		echo Prioridade 7: Não	
		pv7="0"
	else
		echo Prioridade 7: Sim
		pv0="1"
	fi

}

###########################################################################################################3

capBruto(){
	sudo tcpdump -i $INTER -w ./Receiving/capBruto &
	sudo sleep 15
	sudo killall tcpdump
	sudo tcpdump -n -e -r ./Receiving/capBruto > ./Receiving/capBrutoVisual
	echo Capitura concluida.
}

###########################################################################################################3

capDiv(){
	sudo grep "p 0" ./Receiving/capBrutoVisual > ./Receiving/p0
	sudo grep "p 1" ./Receiving/capBrutoVisual > ./Receiving/p1
	sudo grep "p 2" ./Receiving/capBrutoVisual > ./Receiving/p2
	sudo grep "p 3" ./Receiving/capBrutoVisual > ./Receiving/p3
	sudo grep "p 4" ./Receiving/capBrutoVisual > ./Receiving/p4
	sudo grep "p 5" ./Receiving/capBrutoVisual > ./Receiving/p5
	sudo grep "p 6" ./Receiving/capBrutoVisual > ./Receiving/p6
	sudo grep "p 7" ./Receiving/capBrutoVisual > ./Receiving/p7
}

###########################################################################################################3

ajustaParametros(){
	sudo arp -a > ./Receiving/arqBruto.txt
	sed -i '/incompleto/d' ./Receiving/arqBruto.txt
	sed 's/?\|em/\t/g' ./Receiving/arqBruto.txt > ./Receiving/lixoArp.txt
        grep -i -n -w $ip_recep ./Receiving/lixoArp.txt > ./Receiving/utilArp.txt
	tr '\t' "\n" < ./Receiving/utilArp.txt > ./Receiving/1Arp.txt 
	sed 's/\[ether]//g' ./Receiving/1Arp.txt > ./Receiving/2Arp.txt
	sed 's/)//g' ./Receiving/2Arp.txt > ./Receiving/3Arp.txt
	sed 's/(//g' ./Receiving/3Arp.txt > ./Receiving/4Arp.txt
	sed -n '2p' ./Receiving/4Arp.txt > ./Receiving/ip1.txt
	sed -n '3p' ./Receiving/4Arp.txt > ./Receiving/mac1.txt
	sed -n '4p' ./Receiving/4Arp.txt > ./Receiving/interface1.txt
	sed 's/ //g' ./Receiving/ip1.txt > ./Receiving/IP
	sed 's/ //g' ./Receiving/mac1.txt > ./Receiving/MAC_R
	sed 's/ //g' ./Receiving/interface1.txt > ./Receiving/INTERFACE
}

###########################################################################################################3

pesoPorP(){
	echo Tamanho do arquivo/prioridade:
	echo Prioridade 0: $v0 Mb
	echo Prioridade 1: $v1 Mb
	echo Prioridade 2: $v2 Mb
	echo Prioridade 3: $v3 Mb
	echo Prioridade 4: $v4 Mb
	echo Prioridade 5: $v5 Mb
	echo Prioridade 6: $v6 Mb
	echo Prioridade 7: $v7 Mb

}

###########################################################################################################3

porcentagem(){
	total=$(ls -l ./Receiving/capBrutoVisual | awk '{print $5}')

	echo O fluxo total corresponde a: $total
	echo Das capturas feitas de cada Fluxo, podemos dizer que o equipamento consegue capturar (caso não apareça nada, não foi feito com sucesso):
	if [ $pv0 != "0" ]
	then
		echo Da prioridade 0, gerou um arquivo no tamanho de: $v0
	fi
	if [ $pv1 != "0" ]
	then
		echo Da prioridade 0, gerou um arquivo no tamanho de: $v1
	fi
	if [ $pv2 != "0" ]
	then
		echo Da prioridade 0, gerou um arquivo no tamanho de: $v2
	fi
	if [ $pv3 != "0" ]
	then
		echo Da prioridade 0, gerou um arquivo no tamanho de: $v3
	fi
	if [ $pv4 != "0" ]
	then
		echo Da prioridade 0, gerou um arquivo no tamanho de: $v4
	fi
	if [ $pv5 != "0" ]
	then
		echo Da prioridade 0, gerou um arquivo no tamanho de: $v5
	fi
	if [ $pv6 != "0" ]
	then
		echo Da prioridade 0, gerou um arquivo no tamanho de: $v6
	fi
	if [ $pv7 != "0" ]
	then
		echo Da prioridade 0, gerou um arquivo no tamanho de: $v7
	fi

}

###########################################################################################################3

echo Antes de iniciar, vamos limpar a tela...
sleep 3
clear
#Coletando a interface

echo Informe o endereço IP da maquina transmissora.
read ip_recep
ping -c 1 $ip_recep
echo 
ajustaParametros
echo
echo Adquirindo as informações da interface deste equipamento. [Maquina Receptora]
INTER=$(cat ./Receiving/INTERFACE)
echo
echo Interface utilizada: $INTER
echo
echo Antes de começar a captura de pacotes, certifique-se que a interface utilizada apareceu corretamente.
echo Caso apareça, pressione enter para iniciar as capturas...
read nothing
capBruto
capDiv
echo No teste até o momento, possuimos as prioridades:
prioridades
echo
pesoPorP
echo
porcentagem




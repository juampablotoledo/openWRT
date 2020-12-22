#!/bin/bash

RESULTADO=()
TIEMPO=`cat /proc/uptime | awk '{print $1}' | cut -f1 -d"."`

if [[ $TIEMPO -gt 1800 ]]
then

	for INTENTO in 0 1 2
	do
		WAN=`mwan3 interfaces | grep ' wan '`
		WAN2=`mwan3 interfaces | grep ' wan2 '`

		if [[ ( $WAN != *"online"* ) && ( $WAN2 != *"online"* && $WAN2 != *"offline"* ) ]]
		then
			RESULTADO[$INTENTO]=0
		else
			RESULTADO[$INTENTO]=1
		fi

                if [[ $INTENTO -ne 2 ]]
                then
                        sleep $1
                fi

	done

	if [[ ${RESULTADO[0]} == 0 && ${RESULTADO[0]} == ${RESULTADO[1]} && ${RESULTADO[0]} == ${RESULTADO[2]} ]]
	then
		echo `uptime` >> /root/caída.txt
		echo `mwan3 interfaces | awk '{print $4}'` >> /root/caída.txt
		rb
	fi

fi

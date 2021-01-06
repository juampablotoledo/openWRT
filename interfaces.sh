#!/bin/bash

RESULTADO=()
TIEMPO=`cat /proc/uptime | awk '{print $1}' | cut -f1 -d"."`

if [[ -d /root/scripts ]]
then
        echo "" > /dev/null
else
        mkdir /root/scripts
fi

if [[ -e /root/scripts/.MWAN3 ]]
then
	echo "" > /dev/null
else
	touch /root/scripts/.MWAN3
fi

INTERFACES=/root/scripts/.MWAN3
LOG=/root/scripts/LOG

if [[ $TIEMPO -gt 1800 ]]
then

	for INTENTO in 0 1 2
	do
		echo `mwan3 interfaces` > $INTERFACES
		WAN=`cat $INTERFACES | awk '{print $6 }'`
		WAN2=`cat $INTERFACES | awk '{print $14}'`

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
		echo "######### Interfaces #########" >> $LOG
		date >> $LOG
		uptime >> $LOG
		echo `cat $INTERFACES | awk '{print $6 " " $14}'` >> $LOG
		rm $INTERFACES
		rb
	fi

fi

#!/bin/bash

RESULTADO=()
TIEMPO=`cat /proc/uptime | awk '{print $1}' | cut -f1 -d"."`
if [[ $TIEMPO -gt 50 ]]
then
	for INTENTO in {0..8..1}
	do
		ESTADO=`top -b -n 1 | grep "CPU:  " | head -n1 | awk '{print $8}' | cut -f1 -d"%"`
		echo $ESTADO
		if [[ $ESTADO -lt 25 ]]
		then
			echo "sí"
			RESULTADO[$INTENTO]=0
		else
			RESULTADO[$INTENTO]=1
			echo "no"
		fi
		if [[ $INTENTO -ne 9 ]]
		then 
			sleep $1
		fi
	done

	if [[ ${RESULTADO[0]} == 0 && ${RESULTADO[0]} == ${RESULTADO[1]} && ${RESULTADO[0]} == ${RESULTADO[2]} && ${RESULTADO[0]} == ${RESULTADO[3]} && ${RESULTADO[0]} == ${RESULTADO[4]} && ${RESULTADO[0]} == ${RESULTADO[5]} && ${RESULTADO[0]} == ${RESULTADO[6]} && ${RESULTADO[0]} == ${RESULTADO[7]} && ${RESULTADO[0]} == ${RESULTADO[8]} ]]
	then
		echo `date` >> /root/proceso.txt
	else
		echo "¡Todo bien!"
	fi
else
	echo "Aún no ha pasado media hora"
fi

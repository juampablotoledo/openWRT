#!/bin/bash

EVIDENCIA=/root/.corro
TIEMPO=`cat /proc/uptime | awk '{print $1}' | cut -f1 -d"."`

if [[ $TIEMPO -lt 120 && -f $EVIDENCIA ]]
then
	rm $EVIDENCIA
fi

if  test -f "$EVIDENCIA"
then
	echo "Ya corrió"
else
	MONTAJE=`iwconfig wlan1`
	INICIO=`dmesg | grep 'ath9k ar934x_wmac: failed to initialize device'`
	if [[ $INICIO == *"ath9k ar934x_wmac: failed to initialize device"* || $MONTAJE == *"No such device"* ]]
	then
		date >> /root/fallo.txt
		uptime >> /root/fallo.txt
		reboot
		rm $EVIDENCIA
	else
		echo '¡Fino!'
		touch $EVIDENCIA
	fi
fi

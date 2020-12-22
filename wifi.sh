#!/bin/bash

EVIDENCIA=/root/.corro

if  test -f "$EVIDENCIA"
then
	echo "Ya corrió"
else
	LECTURA=`dmesg | grep 'ath9k ar934x_wmac: failed to initialize device'`

	if [[ $LECTURA == *"ath9k ar934x_wmac: failed to initialize device"* ]]
	then
		date >> /root/fallo.txt
		reboot
		rm $EVIDENCIA
	else
		echo '¡Fino!'
		touch $EVIDENCIA
	fi

fi

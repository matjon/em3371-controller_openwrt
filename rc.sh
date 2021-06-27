#!/bin/sh /etc/rc.common
# emax_em3371_decoder
 
USE_PROCD=1
START=80
PROG=/usr/sbin/emax_em3371_decoder

start_service() {        
        # TODO: wywołać /usr/lib/emax_em3371_decoder/set_device_to_client.sh
	procd_open_instance
	procd_set_param command $PROG -p 13700 --mysql-server=192.168.1.22 --mysql-user=weather_station_writer --mysql-password='HIDDEN' --mysql-database=weather_station --mysql-buffer-size=4096 --set-time

        # nie wysyłamy stdout / stderr do sysloga
	procd_set_param stderr 0
	procd_set_param stdout 0
	procd_close_instance
}

#### Wifi

`/etc/wpa_supplicant.conf` adapted from `man wpa_supplicant.conf`:

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=wheel
update_config=1

network={
	ssid="nyu"
	eap=PEAP
	key_mgmt=WPA-EAP
	identity="{IDENTITY}"
	password="{PASSWORD}"
}
```

The second line allows `wpa_gui` to alter the config file.

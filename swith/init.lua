-- init
version = "0.0.1"
dofile('func.lua')
dofile('gpio.lua')
print('Init loony swith '..version)

-- trm after connect
tmr_i = 0
tmr.alarm(1000, 1, function() 

  if wifi.sta.getip()=="0.0.0.0" then
    print("connecting to AP..."..c_wifi_ssid.."/"..c_wifi_key)  
    tmr_i = tmr_i + 1
  else
    print('ip: ',wifi.sta.getip())
    getHTTPreq()
    HTTPd()
    tmr.stop()
  end
end)

-- wifi sttings
wifi.setmode(wifi.STATION)
wifi.sta.config(c_wifi_ssid,c_wifi_key)
wifi.sta.autoconnect(1)

print('set mode=STATION (mode='..wifi.getmode()..')')
print('MAC: ',wifi.sta.getmac())
print('chip: ',node.chipid())
print('heap: ',node.heap())

-- wifi config start
-- wifi config end
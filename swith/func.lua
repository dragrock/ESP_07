function getHTTPreq()
  print('send GET to http server...')
end

function HTTPd()
  print('start http serv')
  srv=net.createServer(net.TCP, 5) 
  srv:listen(80,function(conn) 
    conn:on("receive",function(conn,payload)
      print(payload)

      if string.find(payload, "key="..c_api_key) then
        msg = "key_ok"      

        if string.find(payload,"mode=on") then
          on()
        else
          if string.find(payload,"mode=off") then
            tmr.stop()
            off()
          else
            if string.find(payload, "mode=party") then
              party(200)
            end
          end
        end

      else
        msg = "error_key"
      end

      conn:send("<html><head></head><body><h1> mode=[on,off,party] key='api_key' </h1><p>"..msg.."</p></body></html>")

    end) 
    conn:on("sent",function(conn) conn:close() end)
  end)
end

-- read config 
file.open('config')
c_wifi_ssid = string.gsub(file.readline(), "\n", "")
c_wifi_key  = string.gsub(file.readline(), "\n", "")
file.close()

file.open('api_key')
c_api_key = string.gsub(file.readline(), "\n", "")
file.close()
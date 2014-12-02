-- out
gpio.mode(8,gpio.OUTPUT)
gpio.write(8,gpio.HIGH)
oo=0
timer=0

-- key
gpio.mode(9,gpio.INPUT)
gpio.mode(9,gpio.LOW)

function on()
  gpio.write(8,gpio.LOW)
  oo=1 
end

function off()
  gpio.write(8,gpio.HIGH)
  oo=0
end

function switch()
  if oo == 1 then 
    off()
  else
    on()
  end
end

function party(i)
  tmr.alarm(i, 1,function()
    switch()
    tmr.wdclr()
  end)
end

function down()
  tmr.alarm(100, 1, function()
    timer = timer + 1
    if timer == 20 then
      print("!!!!!!!!!")
    end

    if timer == 40 then
      -- com gpio diode! 
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    end

    if timer == 60 then
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    end

    -- ok 
    if gpio.read(9) == 1 then
      print(timer)
      tmr.stop()
      if timer < 20 then
        switch()
      else
        if timer < 40 then
          party(200)
        else
          if timer < 60 then 
            party(100)
          else
            party(50)
          end
        end
      end
      timer = 0
    end
    tmr.wdclr()
  end)
end

gpio.trig(9, "down", function (gp)
  if timer == 0 then
    timer = 1
    down()
  end  
end)


--[[function love.draw()
  love.graphics.print("Hello World!", 400,300)
end
--]]

fish = { x = 200, y = 210, speed = 150, img = nil}

    function love.load()
    fish.img = love.graphics.newImage("fish.png")
    end
--[[
function love.mousepressed(x,y, button)
  if button == '1' then 
    love.graphics.print("wow, Wow, WOW")
  end
end
--]]
function love.update(dt)
  -- exit game

  if love.keyboard.isDown('escape') then 
     love.event.push('quit')
  end

  if love.keyboard.isDown('left', 'a') then
     if fish.x > 0 then 
      fish.x = fish.x - (fish.speed*dt)
     end
  elseif love.keyboard.isDown('right', 'd') then
        if fish.x < (love.graphics.getWidth() - fish.img:getWidth()) then  
           fish.x = fish.x + (fish.speed*dt)
        end
  elseif love.keyboard.isDown('up', 'w') then 
          if fish.y > 0 then
          fish.y = fish.y -(fish.speed*dt)
         end
  elseif love.keyboard.isDown('down', 's') then 
         if (fish.y < love.graphics.getHeight() - fish.img:getHeight()) then
            fish.y = fish.y + (fish.speed*dt)
         end
  end
end


  

    function love.draw()
     love.graphics.draw(fish.img, fish.x, fish.y)
    end
--]]


--[[function love.draw()
  love.graphics.print("Hello World!", 400,300)
end
--]]
--Helper functions
--detects image overlap
function collision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 <(x2 + w2) and x2 <(x1+w1) and y1 <( y2 + h2) and y2 < (y1 + h1)

end

--Handles missiles





--map

location = {x = 1, y =2}
 map = {1,0,0,1,0,1,0,1,0,0,1}
-- load tiles
tile = {}
tile[0] = love.graphics.newImage("flower.png")
tile[1] = love.graphics.newImage("flower2.png")

--readmap
function readmap(coords)
 x = coords.x
for i=x, (x+1) do 
love.graphics.draw(tile[map[i]], 300*(i-x),300)
end 
 end




--set the screen
function love.conf(t)
  t.title = "Sweet fish game"  
  t.version = "0.9.1"
end
-- players and objects


fish = { x = 200, y = 210, speed = 150, img = nil, frame = 1}
octopus = {x = 400, y = 0, speed = 100, img = nil, frame = 0, damage =0, alive = 1, timer = 0 } 
diver = {x = 200, y = 300, speed = 150, img = nil, frame = 1}

    function love.load()
--background
  background = love.graphics.newImage("flower.png")
  background1 = love.graphics.newImage("flower2.png")
--fish
    firstfish = love.graphics.newImage("fish.png")
    secondfish = love.graphics.newImage("fish2.png")
    attackfish = love.graphics.newImage("fish3.png")
    fish.img = firstfish
--octopus
    firstocto = love.graphics.newImage("octopus.png")
    gocto = love.graphics.newImage("octopus7.png")
aocto = love.graphics.newImage("octopus1.png")
bocto = love.graphics.newImage("octopus2.png")
cocto = love.graphics.newImage("octopus3.png")
docto = love.graphics.newImage("octopus4.png")
eocto = love.graphics.newImage("octopus5.png")
focto = love.graphics.newImage("octopus6.png")
    octopus.img = firstocto
    success = love.graphics.toggleFullscreen()

--diver
   firstdiver = love.graphics.newImage("diver.png")
   seconddiver = love.graphics.newImage("diver2.png")
   diver.img = firstdiver

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
--fish controls
  if love.keyboard.isDown('left') then
     if fish.x > 0 then 
      fish.x = fish.x - (fish.speed*dt)
     end
  elseif love.keyboard.isDown('right') then
        if fish.x < (love.graphics.getWidth() - fish.img:getWidth()) then  
           fish.x = fish.x + (fish.speed*dt)
        end
  elseif love.keyboard.isDown('up') then 
          if fish.y > 0 then
          fish.y = fish.y -(fish.speed*dt)
         end
  elseif love.keyboard.isDown('down') then 
         if (fish.y < love.graphics.getHeight() - fish.img:getHeight()) then
            fish.y = fish.y + (fish.speed*dt)
         end
  end

--diver controls
  if love.keyboard.isDown('a') then
     if diver.x > 0 then 
      diver.x = diver.x - (diver.speed*dt)
     end
  end

  if love.keyboard.isDown('d') then
        if diver.x < (love.graphics.getWidth() - diver.img:getWidth()) then  
           diver.x = diver.x + (diver.speed*dt)
        end
  end
  if love.keyboard.isDown('w') then   
          if diver.y > 0 then
          diver.y = diver.y -(diver.speed*dt)
         end
  end

  if love.keyboard.isDown('s') then   
         if (diver.y < love.graphics.getHeight() - diver.img:getHeight()) then
            diver.y = diver.y + (diver.speed*dt)
         end
  end


--octopus position
  if octopus.y < (love.graphics.getHeight() - fish.img:getHeight()) then
     octopus.y = octopus.y+ (octopus.speed*dt)
  else octopus.y  = 0
  end
--octopus timer
  if octopus.alive == 0 then
     octopus.timer = octopus.timer + (1*dt)
  end 

--animate fish
  fish.frame = fish.frame + 1
  
  if fish.frame % 40 ==0 then
     fish.img = firstfish
  elseif fish.frame % 20 == 0 then
     fish.img = secondfish
  end
-- animate diver
  diver.frame = diver.frame + 1

  if diver.frame % 50 ==0 then
     diver.img = firstdiver
  elseif fish.frame % 25 == 0 then
     diver.img = seconddiver
  end




-- check if attacking
  if love.keyboard.isDown('rctrl') then 
     fish.img = attackfish
  end
--fish attack octo
  if fish.img == attackfish and collision(fish.x, fish.y, fish.img:getWidth(), fish.img:getHeight(), octopus.x, octopus.y, octopus.img:getWidth(), octopus.img:getHeight()) then
 
  octopus.damage = octopus.damage + 1

  end

--diver attack octo

  if collision(diver.x, diver.y, diver.img:getWidth(), diver.img:getHeight(), octopus.x, octopus.y, octopus.img:getWidth(), octopus.img:getHeight()) then

  octopus.damage = octopus.damage + 1

  end

--octopus status

  if octopus.damage == 20 then
     octopus.img = aocto
  elseif octopus.damage == 40 then
     octopus.img = bocto
  elseif octopus.damage == 60 then
     octopus.img = cocto
  elseif octopus.damage == 80 then
     octopus.img = docto
  elseif octopus.damage == 100 then
     octopus.img = eocto
  elseif octopus.damage == 120 then
     octopus.img = focto
  elseif octopus.damage == 140 then
     octopus.img = gocto
  elseif octopus.damage > 160 then
    octopus.alive = 0
  end

--move along
---]]

  if fish.x > 650 then
     fish.x = 0
     location.x = location.x +1
  end
--]]
end

   function love.draw()
  --background
   --[[ 
    for i = 0, love.graphics.getWidth() / background:getWidth() do
      for j = 0, love.graphics.getHeight() / background:getHeight() do 
          love.graphics.draw(background, i* background:getWidth(), j* background:getHeight())
      end
    end
   --]]
 
    readmap(location)    

     love.graphics.draw(fish.img, fish.x, fish.y)
    if octopus.alive == 1  and location.x == 1 then  love.graphics.draw(octopus.img, octopus.x, octopus.y) end
    if octopus.alive == 0 and octopus.timer < 2 then love.graphics.print("Allright!", 300, 300) end
    love.graphics.draw(diver.img, diver.x, diver.y)
    width = love.graphics.getWidth()
    height = love.graphics.getHeight() 
   love.graphics.print(""..(location.y*100).." feet", 0,0)
  love.graphics.print(height, 100,200)

 end
--]]


--[[function love.draw()
  love.graphics.print("Hello World!", 400,300)
end
--]]
--Helper functions
--detects image overlap
function collision(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 <(x2 + w2) and x2 <(x1+w1) and y1 <( y2 + h2) and y2 < (y1 + h1)

end
--improved collision.  Obj b takes an optional hit area
function collisionImp(obja,objb, hitarea)
  hitarea = hitarea or {xx= nil, yy= nil, width = nil, height = nil}

  x2= hitarea.xx or objb.x
  y2= hitarea.yy or objb.y
  w2= hitarea.width or objb.img:getWidth()
  h2= hitarea.height or objb.img:getHeight()

  return obja.x < (x2 + w2) and x2 < (obja.x + obja.img:getWidth()) and obja.y < (y2 + h2) and y2 < (obja.y + obja.img:getHeight()) 

end


--Handles missiles
cannonImg= love.graphics.newImage("cannon.png")

timerMax = .2
timer = 0
diverCannon = {}

-- ie if space bar down fire() in update
function fire(player,missileArray,missileImg, dir)
  missileImg = missileImg or cannonImg
  dir = dir or 1
  if player.count < 0 then
  newMiss = {x =(player.x+ player.img:getWidth()/2), y = (player.y+ player.img:getHeight()/3 + 5), img = missileImg, speed = 200}
  table.insert(missileArray, newMiss)
  player.count = timerMax
  end
end

--update each missile object in array
  function moveMissile(missileArray, dt) 
    for i, missile in ipairs(missileArray) do 
      missile.x = (missile.x +missile.speed*dt)
      if missile.x > 800 or missile.x < 0 or missile.y < 0 or missile.y > 600 then
         table.remove(missileArray, i)
      end
   end
  end

--draw the missiles

function showMissile(missileArray)
  for i, missile in ipairs(missileArray) do
    love.graphics.draw(missile.img, missile.x, missile.y)
  end
end

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

--set animation rate
function rate(player,first, second)
     if diver.frame % first ==0 then
     player.img = firstdiver
  elseif diver.frame % second == 0 then
     player.img = seconddiver
  end
end


--set the screen
function love.conf(t)
  t.title = "Sweet fish game"  
  t.version = "0.9.1"
end
-- players and objects


fish = { x = 200, y = 210, speed = 150, img = nil, frame = 1}
octopus = {x = 400, y = 0, speed = 100, img = nil, frame = 0, damage =0, alive = 1, hitarea ={ xx = 400 , yy = 0, width = 100, height= 100}, timer = 0 } 
diver = {x = 200, y = 300, speed = 150, img = nil, frame = 1, count = 0, temp = 200 }

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

  if love.keyboard.isDown(" ") then
     fire(diver, diverCannon)
  end

-- move missiles
  moveMissile(diverCannon, dt)
--octopus position
  if octopus.y < (love.graphics.getHeight() - fish.img:getHeight()) then
     octopus.y = octopus.y+ (octopus.speed*dt)
  else octopus.y  = 0
  end
--update hitarea
  octopus.hitarea.xx = octopus.x + 100
  octopus. hitarea.yy =octopus.y
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
-- animate diver (rate is in helper functions)
  diver.frame = diver.frame +1

  if diver.x == diver.temp then
     diver.temp = diver.x
  else rate(diver,20, 10) 
       diver.temp = diver.x 
  end  

    rate(diver, 100,50)


  --update diver missile timer
   diver.count = diver.count - (1*dt)



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

--cannon attack octo
  for i, fireball in ipairs(diverCannon) do 
     if  collisionImp(fireball, octopus, octopus.hitarea) then
       octopus.damage = octopus.damage + 1
       table.remove(diverCannon,i)
     end
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
--draws the map based on the location of the fish 
    readmap(location)

  --draw missiles
    showMissile(diverCannon)    

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


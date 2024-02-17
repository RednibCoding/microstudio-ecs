init = function()
  icon1 = Player.new("icon", 10, 10)
  icon1._("collider").debug = true
  // icon1._("collider").setHeight(8)
  icon1._("collider").setOffsetY(-8)
  
  mousePointer = Actor.new("icon", -10, -10)
  mousePointer._("collider").debug = true
  mousePointer._("collider").setOffsetY(-4)
  mousePointer._("transform").setScale(1.5)
  
  System.init()
end

update = function()
  if icon1._("collider").overlapsPoint(mouse.x, mouse.y) then
    icon1._("transform").setScale(5)
  else
    icon1._("transform").setScale(1)
  end

  // mousePointer._("transform").x = mouse.x
  // mousePointer._("transform").y = mouse.y
  
  if keyboard.press.SPACE then
    icon1._("transform").isActive = not icon1._("transform").isActive
  end

  System.update()
end

draw = function()
  screen.clear()
  
  screen.drawMap( "map01/ground_1", 0, 0, 400, 200 )
  screen.drawMap( "map01/ground_2", 0, 0, 400, 200 )
  screen.drawMap( "map01/object_1", 0, 0, 400, 200 )
  
  System.draw()
  
  // local y = 80
  // for key in keyboard
  //   if keyboard[key] then
  //     screen.drawText(key,0,y,15, "#FFF")
  //     y -= 20
  //   end
  // end

end


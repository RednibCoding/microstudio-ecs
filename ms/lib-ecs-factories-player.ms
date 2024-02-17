
// Player entity that basically can be drawn, moved and can collide
// also has a simple keyboard controller component

Player = object
  new = function(spriteName, x, y, width, height)
    local entity = new Entity()

    local transform = new TransformComponent(x, y)
    System.addComponent(entity, transform)

    local sprite = new SpriteComponent(spriteName)
    System.addComponent(entity, sprite)
    
    local collider = new OvalColliderComponent(width, height+20)
    System.addComponent(entity, collider)
    
    local wasd = new WasdControllerComponent()
    System.addComponent(entity, wasd)
    
    return entity
  end
end
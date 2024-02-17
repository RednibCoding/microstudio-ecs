
// Actor entity that basically can be drawn, moved and can collide

Actor = object
  new = function(spriteName, x, y, width, height)
    local entity = new Entity()

    local transform = new TransformComponent(x, y)
    System.addComponent(entity, transform)
    
    local sprite = new SpriteComponent(spriteName)
    System.addComponent(entity, sprite)

    local collider = new BoxColliderComponent(width, height)
    System.addComponent(entity, collider)

    return entity
  end
end
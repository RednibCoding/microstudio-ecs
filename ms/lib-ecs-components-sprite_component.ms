SpriteComponent = class extends BaseComponent
  name = "sprite"

  constructor = function(spriteName)
    super()
    this.sprite = sprites[spriteName]
  end
  
  init = function()
    local transform = owner._("transform", "SpriteComponent.init")
    
    if (transform.width() == 0) then
      transform.setWidth(this.sprite.width)
    end
    
    if (transform.height() == 0) then
      transform.setHeight(this.sprite.height)
    end
  end

  draw = function()
    local transform = owner._("transform", "SpriteComponent.draw")

    screen.drawSprite(this.sprite, transform.x, transform.y, transform.width(), transform.height())  
  end
end
BoxColliderComponent = class extends BaseComponent
  name = "collider"
  colliderType = "box"

  constructor = function(width = 0, height = 0, offsetX = 0, offsetY = 0)
    super()
    this.debug = false
    this._width = width
    this._height = height
    this._offsetX = offsetX
    this._offsetY = offsetY
  end
  
  init = function()
    local transform = owner._("transform", "BoxColliderComponent.init")
    
    if this._width == 0 then
      this._width = transform.width()
    end

    if this._height == 0 then
      this._height = transform.height()
    end
  end
  
  width = function()
    return this._width
  end
  
  height = function()
    return this._height
  end
  
  offsetX = function()
    return this._offsetX
  end
  
  offsetY = function()
    return this._offsetY
  end
  
  setWidth = function(width)
    this._width = width
  end
  
  setHeight = function(height)
    this._height = height
  end
  
  setOffsetX = function(offsetX)
    this._offsetX = offsetX
  end
  
  setOffsetY = function(offsetY)
    this._offsetY = offsetY
  end

  draw = function()
    if this.debug then
      local transform = owner._("transform", "BoxColliderComponent.draw")
      local x = transform.x + this._offsetX * transform.scale()
      local y = transform.y + this._offsetY * transform.scale()
      screen.fillRect(x, y, this._width * transform.scale(), this._height * transform.scale(), "#20B2AA88")    
    end
  end

  overlapsPoint = function (x, y)
    if not this.isActive then return false end
   
    local transformOwner = owner._("transform", "BoxColliderComponent.overlapsPoint")
    
    local centerXOwner = transformOwner.x + this._offsetX * transformOwner.scale()
    local centerYOwner = transformOwner.y + this._offsetY * transformOwner.scale()
    local widthOwner = this._width * transformOwner.scale()
    local heightOwner = this._height * transformOwner.scale()
    
    local isColliding = CollisionHelper.rectOverlapsPoint(
        centerXOwner, centerYOwner, widthOwner, heightOwner, x, y
    )
    
    return isColliding
  end

  overlapsEntity = function(otherEntity)
    if not this.isActive then return false end

    local transformOwner = owner._("transform", "BoxColliderComponent.overlapsEntity")
    local transformOther = otherEntity._("transform", "BoxColliderComponent.overlapsEntity")
    local colliderOther = otherEntity._("collider", "BoxColliderComponent.overlapsEntity")
    
    if colliderOther.colliderType == "box" then
      // Box - Box collision
    
      local centerXOwner = transformOwner.x + this._offsetX
      local centerYOwner = transformOwner.y + this._offsetY
      local widthOwner = this._width * transformOwner.scale()
      local heightOwner = this._height * transformOwner.scale()
      
      local centerXOther = transformOther.x + colliderOther.offsetX()
      local centerYOther = transformOther.y + colliderOther.offsetY()
      local widthOther = colliderOther.width() * transformOther.scale()
      local heightOther = colliderOther.height() * transformOther.scale()
      
      local isColliding = CollisionHelper.rectOverlapsRect(
        centerXOwner, centerYOwner, widthOwner, heightOwner,
        centerXOther, centerYOther, widthOther, heightOther
      )
    
      return isColliding
    
    elsif colliderOther.colliderType == "circle" then
      // Box - Circle collision
      
      local centerXOwner = transformOwner.x + this._offsetX
      local centerYOwner = transformOwner.y + this._offsetY
      local widthOwner = this._width * transformOwner.scale()
      local heightOwner = this._height * transformOwner.scale()
      
      local centerXOther = transformOther.x + colliderOther.offsetX()
      local centerYOther = transformOther.y + colliderOther.offsetY()
      local radiusOther = colliderOther.radius() * transformOther.scale()
      
      local isColliding = CollisionHelper.rectOverlapsCircle(
        centerXOwner, centerYOwner, widthOwner, heightOwner,
        centerXOther, centerYOther, radiusOther
      )
    
      return isColliding
      
    elsif colliderOther.colliderType == "oval" then
      // Box - Oval collision
  
      local centerXOwner = transformOwner.x + this._offsetX
      local centerYOwner = transformOwner.y + this._offsetY
      local widthOwner = this._width * transformOwner.scale()
      local heightOwner = this._height * transformOwner.scale()
      
      local centerXOther = transformOther.x + colliderOther.offsetX()
      local centerYOther = transformOther.y + colliderOther.offsetY()
      local widthOther = colliderOther.width() * transformOther.scale()
      local heightOther = colliderOther.height() * transformOther.scale()
      
      local isColliding = CollisionHelper.rectOverlapsOval(
        centerXOwner, centerYOwner, widthOwner, heightOwner,
        centerXOther, centerYOther, widthOther, heightOther
      )
    
      return isColliding
    end
    
  end
end


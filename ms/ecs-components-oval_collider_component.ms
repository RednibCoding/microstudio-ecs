OvalColliderComponent = class extends BaseComponent
  name = "collider"
  colliderType = "oval"

  constructor = function(width = 0, height = 0, offsetX = 0, offsetY = 0)
    super()
    this.debug = false
    this._width = width
    this._height = height
    this._offsetX = offsetX
    this._offsetY = offsetY
  end
  
  init = function()
    local transform = owner._("transform", "OvalColliderComponent.init")
    
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
      local transform = owner._("transform", "OvalColliderComponent.draw")
      local x = transform.x + this._offsetX * transform.scale()
      local y = transform.y + this._offsetY * transform.scale()
      screen.fillRound(x, y, this._width * transform.scale(), this._height * transform.scale(), "#20B2AA88")    
    end
  end

  overlapsPoint = function (x, y)
    if not this.isActive then return false end
   
    local transformOwner = owner._("transform", "OvalColliderComponent.overlapsPoint")
    
    local centerXOwner = transformOwner.x + this._offsetX * transformOwner.scale()
    local centerYOwner = transformOwner.y + this._offsetY * transformOwner.scale()
    local widthOwner = this._width * transformOwner.scale()
    local heightOwner = this._height * transformOwner.scale()
    
    local isColliding = CollisionHelper.ovalOverlapsPoint(
        centerXOwner, centerYOwner, widthOwner, heightOwner, x, y
    )
    
    return isColliding
  end

  overlapsEntity = function(otherEntity)
    if not this.isActive then return false end

    local transformOwner = owner._("transform", "OvalColliderComponent.overlapsEntity")
    local transformOther = otherEntity._("transform", "OvalColliderComponent.overlapsEntity")
    local colliderOther = otherEntity._("collider", "OvalColliderComponent.overlapsEntity")
    
    if colliderOther.colliderType == "oval" then
      // Oval - Oval collision
      local centerXOwner = transformOwner.x + this._offsetX * transformOwner.scale()
      local centerYOwner = transformOwner.y + this._offsetY * transformOwner.scale()
      local widthOwner = this._width * transformOwner.scale()
      local heightOwner = this._height * transformOwner.scale()
      
      local centerXOther = transformOther.x + colliderOther.offsetX() * transformOther.scale()
      local centerYOther = transformOther.y + colliderOther.offsetY() * transformOther.scale()
      local widthOther = colliderOther.width() * transformOther.scale()
      local heightOther = colliderOther.height() * transformOther.scale()

      local isColliding = CollisionHelper.ovalOverlapsOval(
        centerXOther, centerYOther, widthOther, heightOther,
        centerXOwner, centerYOwner, widthOwner, heightOwner
      )
    
      return isColliding
      
    elsif colliderOther.colliderType == "box" then
      // Oval - Box collision
    
      local centerXOwner = transformOwner.x + this._offsetX * transformOwner.scale()
      local centerYOwner = transformOwner.y + this._offsetY * transformOwner.scale()
      local widthOwner = this._width * transformOwner.scale()
      local heightOwner = this._height * transformOwner.scale()
      
      local centerXOther = transformOther.x + colliderOther.offsetX() * transformOther.scale()
      local centerYOther = transformOther.y + colliderOther.offsetY() * transformOther.scale()
      local widthOther = colliderOther.width() * transformOther.scale()
      local heightOther = colliderOther.height() * transformOther.scale()
      
      local isColliding = CollisionHelper.rectOverlapsOval(
        centerXOther, centerYOther, widthOther, heightOther,
        centerXOwner, centerYOwner, widthOwner, heightOwner
      )

      return isColliding
    
    elsif colliderOther.colliderType == "circle" then
      // Oval - Circle collision
      
      local centerXOwner = transformOwner.x + this._offsetX * transformOwner.scale()
      local centerYOwner = transformOwner.y + this._offsetY * transformOwner.scale()
      local widthOwner = this._width * transformOwner.scale()
      local heightOwner = this._height * transformOwner.scale()
      
      local centerXOther = transformOther.x + colliderOther.offsetX() * transformOther.scale()
      local centerYOther = transformOther.y + colliderOther.offsetY() * transformOther.scale()
      local radiusOther = colliderOther.radius() * transformOther.scale()
      
      local isColliding = CollisionHelper.circleOverlapsOval(
        centerXOther, centerYOther, radiusOther,
        centerXOwner, centerYOwner, widthOwner, heightOwner
      )
    
      return isColliding

    end
    
  end
end


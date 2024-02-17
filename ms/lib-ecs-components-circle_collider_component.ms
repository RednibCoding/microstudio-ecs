CircleColliderComponent = class extends BaseComponent
  name = "collider"
  colliderType = "circle"

  constructor = function(radius = 0, offsetX = 0, offsetY = 0)
    super()
    this.debug = false
    this._radius
    this._offsetX = offsetX
    this._offsetY = offsetY
  end
  
  init = function()
    local transform = owner._("transform", "CircleColliderComponent.init")
    
    if this._radius == 0 then
      this._radius = min(transform.width()/2, transform.height()/2)
    end
  end
  
  radius = function()
    return this._radius
  end
  
  offsetX = function()
    return this._offsetX
  end
  
  offsetY = function()
    return this._offsetY
  end

  setRadius = function(radius)
    this._radius = radius
  end
  
  setOffsetX = function(offsetX)
    this._offsetX = offsetX
  end
  
  setOffsetY = function(offsetY)
    this._offsetY = offsetY
  end

  draw = function()
    if this.debug then
      local transform = owner._("transform", "CircleColliderComponent.draw")
      local x = transform.x + this._offsetX * transform.scale()
      local y = transform.y + this._offsetY * transform.scale()
      screen.fillRound(x, y, this._radius*2 * transform.scale(), this._radius*2 * transform.scale(), "#20B2AA88")    
    end
  end

  overlapsPoint = function (x, y)
    if not this.isActive then return false end
   
    local transform = owner._("transform", "CircleColliderComponent.overlapsPoint")
    
    local size = this._radius * transform.scale()
    local cx = transform.x + this._offsetX * transform.scale()
    local cy = transform.y + this._offsetY * transform.scale()
    
    local dx = x - cx
    local dy = y - cy
    local distance = sqrt(dx*dx + dy*dy)

    if distance <= size then
        return true
    end
    
    return false
  end


  overlapsEntity = function(otherEntity)
    if not this.isActive then return false end

    local transformOwner = owner._("transform", "CircleColliderComponent.overlapsEntity")
    local transformOther = otherEntity._("transform", "CircleColliderComponent.overlapsEntity")
    local colliderOther = otherEntity._("collider", "CircleColliderComponent.overlapsEntity")
    
    if colliderOther.colliderType == "box" then
      // Circle - Box collision
      local radiusOwner = this._radius * transformOwner.scale()
      local centerXOwner = transformOwner.x + this._offsetX
      local centerYOwner = transformOwner.y + this._offsetY
    
      local widthOther = colliderOther.width() * transformOther.scale()
      local heightOther = colliderOther.height() * transformOther.scale()
      local centerXOther = transformOther.x + colliderOther.offsetX()
      local centerYOther = transformOther.y + colliderOther.offsetY()
      
      local isColliding = CollisionHelper.rectOverlapsCircle(
        centerXOther, centerYOther, widthOther, heightOther,
        centerXOwner, centerYOwner, radiusOwner
      )
      
      return isColliding

    elsif colliderOther.colliderType == "circle" then
      // Circle - Circle collision
      local radiusOwner = this._radius * transformOwner.scale()
      local centerXOwner = transformOwner.x + this._offsetX
      local centerYOwner = transformOwner.y + this._offsetY
      
      local radiusOther = colliderOther.radius() * transformOther.scale()
      local centerXOther = transformOther.x + colliderOther.offsetX()
      local centerYOther = transformOther.y + colliderOther.offsetY()

      local isColliding = CollisionHelper.circleOverlapsCircle(
        centerXOwner, centerYOwner, radiusOwner,
        centerXOther, centerYOther, radiusOther
      )
      
      return isColliding
      
    elsif colliderOther.colliderType == "oval" then
      // Circle - Oval collision
      local radiusOwner = this._radius * transformOwner.scale()
      local centerXOwner = transformOwner.x + this._offsetX
      local centerYOwner = transformOwner.y + this._offsetY
    
      local widthOther = colliderOther.width() * transformOther.scale()
      local heightOther = colliderOther.height() * transformOther.scale()
      local centerXOther = transformOther.x + colliderOther.offsetX()
      local centerYOther = transformOther.y + colliderOther.offsetY()
      
      local isColliding = CollisionHelper.circleOverlapsOval(
        centerXOwner, centerYOwner, radiusOwner,
        centerXOther, centerYOther, widthOther, heightOther
      )
      
      return isColliding
    end

  end
end











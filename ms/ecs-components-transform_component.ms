TransformComponent = class extends BaseComponent
  name = "transform"

  constructor = function(x = 0, y = 0, speed = 3, width = 0, height = 0, scale = 1)
    super()
    this.x = x 
    this.y = y
    this._scale = scale
    this.setWidth(width)
    this.setHeight(height)
    this._speed = speed
  end
  
  width = function()
    return this._width
  end
  
  height = function()
    return this._height
  end
  
  scale = function()
    return this._scale
  end
  
  speed = function(speed)
    return this._speed
  end
  
  setWidth = function(width)
    if not this.isActive then return end
    
    if this._baseWidth == 0 then
      this._baseWidth = width
    end
    if this.isActive then
      this._width = width * this._scale
    end
  end
  
  setHeight = function(height)
    if not this.isActive then return end
    
    if this._baseHeight == 0 then
      this._baseHeight = height
    end
    if this.isActive then
      this._height = height * this._scale
    end
  end

  setScale = function(scale)
    if not this.isActive then return end

    this._scale = scale
    this._width = this._baseWidth * scale
    this._height = this._baseHeight * scale
  end
  
  setSpeed = function(speed)
    if not this.isActive then return end

    this._speed = speed
  end
  
  move = function(x, y)
    if not this.isActive then return end
    
      this.x = this.x + x
      this.y = this.y + y
  end
end




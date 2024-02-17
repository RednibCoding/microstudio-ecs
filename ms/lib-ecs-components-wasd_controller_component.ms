WasdControllerComponent = class extends BaseComponent
  name = "wasd_controller"

  constructor = function()
    super()
  end
  
  init = function()
    local transform = owner._("transform", "WasdControllerComponent.init")
  end

  update = function()
    local transform = owner._("transform", "WasdControllerComponent.update")

    if keyboard.LEFT then
      transform.move(-transform.speed(), 0)
    end
    
    if keyboard.RIGHT then
      transform.move(transform.speed(), 0)
    end
    
    if keyboard.UP then
      transform.move(0, transform.speed())
    end
    
    if keyboard.DOWN then
      transform.move(0, -transform.speed())
    end
  end
end
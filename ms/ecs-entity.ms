// Entity is basically a container of components, thats it

Entity = class
  _nextId = 1
  
  constructor = function()
    this.id = Entity._nextId
    Entity._nextId += 1
    this._componentsAll = []
    this._componentsToInit = []
    this._componentsToUpdate = []
    this._componentsToDraw = []
  end

  // Function to get a component by name
  _ = function(name, callerName = "")
    for comp in this._componentsAll
      if comp.name == name then
        return comp
      end
    end
  end
  
  hasComponent = function(componentName)
    for comp in this._componentsAll
      if comp.name == componentName then
        return true
      end
    end
    return false
  end
  
  hasComponents = function()
    return this._componentsAll.length > 0
  end
  
  _hasInitComponent = function(componentName)
    for comp in this._componentsToInit
      if comp.name == componentName then
        return true
      end
    end
    return false
  end
  
  _hasUpdateComponent = function(componentName)
    for comp in this._componentsToUpdate
      if comp.name == componentName then
        return true
      end
    end
    return false
  end
  
  _hasDrawComponent = function(componentName)
    for comp in this._componentsToDraw
      if comp.name == componentName then
        return true
      end
    end
    return false
  end
  
  _addComponent = function(component)
    component.owner = this
    
    // Add component to the lists
    
    if not this.hasComponent(component.name) then
      this._componentsAll.push(component)
    end
    
    if component.init then
      if not this._hasInitComponent(component.name) then
        this._componentsToInit.push(component)
      end
    end
    
    if component.update then
      if not this._hasUpdateComponent(component.name) then
        this._componentsToUpdate.push(component)
      end
    end

    if component.draw then
      if not this._hasDrawComponent(component.name) then
        this._componentsToDraw.push(component)
      end
    end
  end
  
  removeComponent = function(componentName)
    if (not this.hasComponent(componentName)) then return end
    local component = this._(componentName, "Entity.removeComponent")

    // Remove component from the lists
    if (component) then
      
      this._componentsAll.removeElement(component)
      
      if component.init then
        this._componentsToInit.removeElement(component)  
      end
      
      if component.update then
        this._componentsToUpdate.removeElement(component)
      end
      
      if component.draw then
        this._componentsToDraw.removeElement(component)
      end
    end
  end

  _init = function()
    for component in this._componentsToInit
      component.init()
    end
  end

  _update = function()
    for component in this._componentsToUpdate
      if component.isActive then
        component.update()
      end
    end
  end

  _draw = function()
    for component in this._componentsToDraw
      if component.isActive then
        component.draw()
      end
    end
  end
end













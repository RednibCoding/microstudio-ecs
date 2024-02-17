System = object
  _entities = []

  addComponent = function(entity, component)
    // Todo: this "contains"-check is costly, try to avoid it
    if not _entities.contains(entity) then
      this._entities.push(entity)  
    end

    entity._addComponent(component)
  end

  removeComponent = function(entity, componentName)
    entity.removeComponent(componentName)
    
    if (not entity.hasComponents()) then
      // Remove entity from the list when it has no components
      this._entities.removeElement(entity)  
    end
  end

  init = function()
    for entity in _entities
      entity._init()
    end
  end
  
  update = function()
    for entity in _entities
      entity._update()
    end
  end
  
  draw = function()
    for entity in _entities
      entity._draw()
    end
  end
end

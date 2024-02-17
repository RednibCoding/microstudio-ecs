BaseComponent = class
  // id
  _nextId = 1
  

  

  // Is set by the deriving class/component and by this name,
  // components can refer/access each other
  name = ""

  constructor = function()
    this.id = BaseComponent._nextId
    BaseComponent._nextId += 1
    
    // Is going to be the entity that owns this component
    this.owner = 0
    
    // Determines whether the component will be updated and/or drawn
    this.isActive = true
  end
  
  // The methods that get called automatically by the system
  // Commented because virtual methods are not supported by MicroScript
  // But basically each component that needs one or all of the three
  // methods should just implement them.
  // When implemented, they get automatically called.
  // See the file: 'entity' for more infos
  //
  // init = function
  // draw = function
  // update = function
end
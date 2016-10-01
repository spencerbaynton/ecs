# Entity Component System (ECS)

```lua
ecs = require "ecs"
```

## ecs.getEntities

Gets all the Entities with a given component.

```lua
ecs.getEntities(component)
```

- `string` `component` The type of component.

## ecs.newEntity

Creates a new `Entity`.

```lua
entity = ecs.newEntity()
```

## Entity

### Entity:add

Adds a component and its data to the Entity. Returns the data from the added component.

```lua
Entity:add(component, data)
```

- `string` `component` The type of component.
- `value` `data` The data of the component.

### Entity:destroy

Destroys the Entity.

```lua
Entity:destroy()
```

### Entity:get

Gets the data for a given component from the Entity.

```lua
Entity:get(component)
```

- `string` `component` The type of component.

### Entity:has

Whether the Entity has a given component.

```lua
Entity:has(component)
```

- `string` `component` The type of component.

### Entity:remove

Removes the component from the Entity.

```lua
Entity:remove(component)
```

- `string` `component` The type of component.

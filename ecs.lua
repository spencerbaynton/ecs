local ecs = {}

local next = next

local entities = {}
local recycle = {}

local maxn = 0

function ecs.getEntities (component)
  if not entities[component] then
    entities[component] = {}
  end
  return entities[component]
end

function ecs.newEntity ()
  local Entity = {}

  local components = {}
  local id

  if next(recycle) then
    id = recycle[#recycle]
    recycle[#recycle] = nil
  else
    maxn = maxn + 1
    id = maxn
  end

  function Entity:add (component, data)
    if not entities[component] then
      entities[component] = {}
    end
    components[component] = data
    entities[component][self] = true
    return data
  end

  function Entity:destroy ()
    for component in next, components do
      entities[component][self] = nil
    end
    components = nil
    recycle[#recycle + 1] = id
  end

  function Entity:get (component)
    return components[component]
  end

  function Entity:has (component)
    return components[component] ~= nil
  end

  function Entity:remove (component)
    components[component] = nil
    entities[component][self] = nil
  end

  return Entity
end

return ecs

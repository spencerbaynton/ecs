local ecs = {}

local next = next

local components = {}
local entities = {}
local recycle = {}

local maxn = 0

local function add (self, component, data)
  local id = self:getID()
  if not entities[component] then
    entities[component] = {}
  end
  components[id][component] = data
  entities[component][id] = self
  return data
end

local function destroy (self)
  local id = self:getID()
  for component in next, components[id] do
    entities[component][id] = nil
  end
  components[id] = nil
  recycle[#recycle + 1] = id
end

local function getComponent (self, component)
  return components[self:getID()][component]
end

local function remove (self, component)
  local id = self:getID()
  components[id][component] = nil
  entities[component][id] = nil
end

function ecs.getEntities (component)
  if not entities[component] then
    entities[component] = {}
  end
  return entities[component]
end

function ecs.newEntity ()
  local Entity = {
    add = add,
    destroy = destroy,
    getComponent = getComponent,
    remove = remove
  }
  local id
  if next(recycle) then
    id = recycle[#recycle]
    recycle[#recycle] = nil
  else
    maxn = maxn + 1
    id = maxn
  end
  function Entity:getID ()
    return id
  end
  components[id] = {}
  return Entity
end

return ecs

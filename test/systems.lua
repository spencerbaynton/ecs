local systems = {}

local dimensions = ecs.getEntities("dimensions")
local positions  = ecs.getEntities("position")
local velocities = ecs.getEntities("velocity")

function systems.destroy ()
  return function ()
    for entity in next, positions do
      local dimensions = entity:get("dimensions")
      local position   = entity:get("position")
      if position.x < -dimensions.width
      or position.x > love.graphics.getWidth()
      or position.y < -dimensions.height
      or position.y > love.graphics.getHeight() then
        entity:destroy()
      end
    end
  end
end

function systems.move ()
  return function (dt)
    for entity in next, velocities do
      local position = entity:get("position")
      local velocity = entity:get("velocity")
      position.x = position.x + velocity.x * dt
      position.y = position.y + velocity.y * dt
    end
  end
end

function systems.render ()
  return function ()
    for entity in next, dimensions do
      local color      = entity:get("color")
      local dimensions = entity:get("dimensions")
      local position   = entity:get("position")
      love.graphics.setColor(color)
      love.graphics.rectangle("fill", position.x, position.y,
        dimensions.width, dimensions.height)
    end
  end
end

return systems

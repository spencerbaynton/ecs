local ecs = require "ecs"

local components = {}

function components.color (red, green, blue, alpha)
  return "color", {red, green, blue, alpha}
end

function components.dimensions (width, height)
  return "dimensions", {height = height or 0, width = width or 0}
end

function components.position (x, y)
  return "position", {x = x or 0, y = y or 0}
end

function components.velocity (x, y)
  return "velocity", {x = x or 0, y = y or 0}
end

local entities = {}

function entities.rectangle ()
  local entity = ecs.newEntity()
  print("Entity", entity:getID(), "created")
  entity:add(components.color(
    love.math.random(0, 255),
    love.math.random(0, 255),
    love.math.random(0, 255),
    256 / 2 - 1
  ))
  local dimensions = entity:add(components.dimensions(
    love.math.random(16, 64),
    love.math.random(16, 64)
  ))
  entity:add(components.position(
    love.math.random(0, love.graphics.getWidth() - dimensions.width),
    love.math.random(0, love.graphics.getHeight() - dimensions.height)
  ))
  entity:add(components.velocity(
    love.math.random(-64, 64),
    love.math.random(-64, 64)
  ))
end

local systems = {}

function systems.destroy ()
  local entities = ecs.getEntities("position")
  return function ()
    for _, entity in next, entities do
      local dimensions = entity:getComponent("dimensions")
      local position   = entity:getComponent("position")
      if position.x < -dimensions.width
      or position.x > love.graphics.getWidth()
      or position.y < -dimensions.height
      or position.y > love.graphics.getHeight() then
        print("Entity", entity:getID(), "destroyed")
        entity:destroy()
      end
    end
  end
end

function systems.move ()
  local entities = ecs.getEntities("velocity")
  return function (dt)
    for _, entity in next, entities do
      local position = entity:getComponent("position")
      local velocity = entity:getComponent("velocity")
      position.x = position.x + velocity.x * dt
      position.y = position.y + velocity.y * dt
    end
  end
end

function systems.render ()
  local entities = ecs.getEntities("dimensions")
  return function ()
    for _, entity in next, entities do
      local color      = entity:getComponent("color")
      local dimensions = entity:getComponent("dimensions")
      local position   = entity:getComponent("position")
      love.graphics.setColor(color)
      love.graphics.rectangle("fill", position.x, position.y,
        dimensions.width, dimensions.height)
    end
  end
end

function love.load ()
  destroy = systems.destroy()
  move    = systems.move()
  render  = systems.render()
end

function love.update (dt)
  entities.rectangle()
  move(dt)
  destroy()
end

function love.draw ()
  render()
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("FPS: " .. love.timer.getFPS())
end

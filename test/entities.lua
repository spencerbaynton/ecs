local entities = {}

local MAX_HEIGHT = 64
local MAX_SPEED = 64
local MAX_WIDTH = 64
local MIN_HEIGHT = 16
local MIN_WIDTH = 16

function entities.rectangle ()
  local entity = ecs.newEntity()
  entity:add(components.color(
    love.math.random(0, 255),
    love.math.random(0, 255),
    love.math.random(0, 255),
    256 / 2 - 1
  ))
  local dimensions = entity:add(components.dimensions(
    love.math.random(MIN_WIDTH, MAX_WIDTH),
    love.math.random(MIN_HEIGHT, MAX_HEIGHT)
  ))
  entity:add(components.position(
    love.math.random(0, love.graphics.getWidth() - dimensions.width),
    love.math.random(0, love.graphics.getHeight() - dimensions.height)
  ))
  entity:add(components.velocity(
    love.math.random(-MAX_SPEED, MAX_SPEED),
    love.math.random(-MAX_SPEED, MAX_SPEED)
  ))
end

return entities

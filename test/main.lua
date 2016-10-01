ecs = require "ecs"

entities   = require "entities"
components = require "components"
systems    = require "systems"

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

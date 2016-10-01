local components = {}

function components.color (red, green, blue, alpha)
  return "color", {red, green, blue, alpha}
end

function components.dimensions (width, height)
  return "dimensions", {height = height, width = width}
end

function components.position (x, y)
  return "position", {x = x, y = y}
end

function components.velocity (x, y)
  return "velocity", {x = x, y = y}
end

return components

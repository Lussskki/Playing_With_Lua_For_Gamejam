
local snake_move = {}

-- Movement direction
local dir_x = 1
local dir_y = 0

-- Movement speed
local timer = 0
local move_interval = 0.2

function snake_move.update(dt, snake)
    -- Keyboard movement (WASD)
    if love.keyboard.isDown("w") and dir_y ~= 1 then
        dir_x = 0
        dir_y = -1
    elseif love.keyboard.isDown("s") and dir_y ~= -1 then
        dir_x = 0
        dir_y = 1
    elseif love.keyboard.isDown("a") and dir_x ~= 1 then
        dir_x = -1
        dir_y = 0
    elseif love.keyboard.isDown("d") and dir_x ~= -1 then
        dir_x = 1
        dir_y = 0
    end

    -- Count time between movements
    timer = timer + dt

    if timer >= move_interval then
        timer = timer - move_interval

        -- Calculate next head position
        local next_x = snake[1].x + dir_x
        local next_y = snake[1].y + dir_y

        -- Add new head and remove old tail
        table.insert(snake, 1, {x = next_x, y = next_y})
        table.remove(snake)
    end
end

-- Get current direction
function snake_move.get_direction()
    return dir_x, dir_y
end

return snake_move

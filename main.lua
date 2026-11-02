
local snake_move = require("src.snake_move")
local assets = require("src.assets")

function love.load()
    -- Load images
    assets.load()

    -- Apple starting position
    apple = {x = 10, y = 10}

    -- Snake starting position
    snake_size = 30
    snake = {
        {x = 12, y = 12},
        {x = 11, y = 12},
        {x = 10, y = 12}
    }
end

function love.draw()
    -- Draw apple
    local scale_x = assets.apple_size / assets.apple_image:getWidth()
    local scale_y = assets.apple_size / assets.apple_image:getHeight()

    love.graphics.draw(
        assets.apple_image,
        apple.x * assets.apple_size,
        apple.y * assets.apple_size,
        0,
        scale_x,
        scale_y
    )

    -- Get movement direction
    local dir_x, dir_y = snake_move.get_direction()

    -- Select head direction
    local current_head_img = assets.head_images.right

    if dir_x == 1 then
        current_head_img = assets.head_images.right
    elseif dir_x == -1 then
        current_head_img = assets.head_images.left
    elseif dir_y == 1 then
        current_head_img = assets.head_images.down
    elseif dir_y == -1 then
        current_head_img = assets.head_images.up
    end

    -- Draw head
    love.graphics.draw(
        current_head_img,
        snake[1].x * snake_size,
        snake[1].y * snake_size,
        0,
        snake_size / current_head_img:getWidth(),
        snake_size / current_head_img:getHeight()
    )

    -- Draw body segments
    for i = 2, #snake - 1 do
        local current = snake[i]
        local next_seg = snake[i - 1]
        local prev_seg = snake[i + 1]
        local img = assets.body_images.horizontal

        -- Distance to neighboring segments
        local dx_1 = next_seg.x - current.x
        local dy_1 = next_seg.y - current.y
        local dx_2 = prev_seg.x - current.x
        local dy_2 = prev_seg.y - current.y

        -- Select straight or corner sprite
        if dy_1 == 0 and dy_2 == 0 then
            img = assets.body_images.horizontal
        elseif dx_1 == 0 and dx_2 == 0 then
            img = assets.body_images.vertical
        elseif (dx_1 == 1 and dy_2 == 1) or (dx_2 == 1 and dy_1 == 1) then
            img = assets.body_images.bottomright
        elseif (dx_1 == -1 and dy_2 == 1) or (dx_2 == -1 and dy_1 == 1) then
            img = assets.body_images.bottomleft
        elseif (dx_1 == 1 and dy_2 == -1) or (dx_2 == 1 and dy_1 == -1) then
            img = assets.body_images.topright
        elseif (dx_1 == -1 and dy_2 == -1) or (dx_2 == -1 and dy_1 == -1) then
            img = assets.body_images.topleft
        end

        -- Draw body segment
        love.graphics.draw(
            img,
            current.x * snake_size,
            current.y * snake_size,
            0,
            snake_size / img:getWidth(),
            snake_size / img:getHeight()
        )
    end

    -- Get tail and its neighboring segment
    local tail_index = #snake
    local tail = snake[tail_index]
    local body_before = snake[tail_index - 1]
    local current_tail_img = assets.tail_images.left

    -- Select tail direction
    if body_before.x > tail.x then
        current_tail_img = assets.tail_images.left
    elseif body_before.x < tail.x then
        current_tail_img = assets.tail_images.right
    elseif body_before.y > tail.y then
        current_tail_img = assets.tail_images.up
    elseif body_before.y < tail.y then
        current_tail_img = assets.tail_images.down
    end

    -- Draw tail
    love.graphics.draw(
        current_tail_img,
        tail.x * snake_size,
        tail.y * snake_size,
        0,
        snake_size / current_tail_img:getWidth(),
        snake_size / current_tail_img:getHeight()
    )
end

function love.update(dt)
    -- Update snake movement
    snake_move.update(dt, snake)
end

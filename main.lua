
local snake_move = require("src.snake_move")

function love.load()
    -- Apple
    apple_image = love.graphics.newImage("assets/apple.png")
    apple_size = 30
    apple = {x = 10, y = 10}

    -- Head sprites
    head_images = {
        up = love.graphics.newImage("assets/head_up.png"),
        down = love.graphics.newImage("assets/head_down.png"),
        left = love.graphics.newImage("assets/head_left.png"),
        right = love.graphics.newImage("assets/head_right.png")
    }

    -- Body sprites
    body_images = {
        horizontal = love.graphics.newImage("assets/body_horizontal.png"),
        vertical = love.graphics.newImage("assets/body_vertical.png"),
        topleft = love.graphics.newImage("assets/body_topleft.png"),
        topright = love.graphics.newImage("assets/body_topright.png"),
        bottomleft = love.graphics.newImage("assets/body_bottomleft.png"),
        bottomright = love.graphics.newImage("assets/body_bottomright.png")
    }

    -- Tail sprites
    tail_images = {
        up = love.graphics.newImage("assets/tail_up.png"),
        down = love.graphics.newImage("assets/tail_down.png"),
        left = love.graphics.newImage("assets/tail_left.png"),
        right = love.graphics.newImage("assets/tail_right.png")
    }

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
    local scale_x = apple_size / apple_image:getWidth()
    local scale_y = apple_size / apple_image:getHeight()

    love.graphics.draw(
        apple_image,
        apple.x * apple_size,
        apple.y * apple_size,
        0,
        scale_x,
        scale_y
    )

    -- Get direction from snake_move.lua
    local dir_x, dir_y = snake_move.get_direction()

    -- Select head direction
    local current_head_img = head_images.right

    if dir_x == 1 then
        current_head_img = head_images.right
    elseif dir_x == -1 then
        current_head_img = head_images.left
    elseif dir_y == 1 then
        current_head_img = head_images.down
    elseif dir_y == -1 then
        current_head_img = head_images.up
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
        local img = body_images.horizontal

        -- Distance to neighboring segments
        local dx_1 = next_seg.x - current.x
        local dy_1 = next_seg.y - current.y
        local dx_2 = prev_seg.x - current.x
        local dy_2 = prev_seg.y - current.y

        -- Select straight or corner sprite
        if dy_1 == 0 and dy_2 == 0 then
            img = body_images.horizontal
        elseif dx_1 == 0 and dx_2 == 0 then
            img = body_images.vertical
        elseif (dx_1 == 1 and dy_2 == 1) or (dx_2 == 1 and dy_1 == 1) then
            img = body_images.bottomright
        elseif (dx_1 == -1 and dy_2 == 1) or (dx_2 == -1 and dy_1 == 1) then
            img = body_images.bottomleft
        elseif (dx_1 == 1 and dy_2 == -1) or (dx_2 == 1 and dy_1 == -1) then
            img = body_images.topright
        elseif (dx_1 == -1 and dy_2 == -1) or (dx_2 == -1 and dy_1 == -1) then
            img = body_images.topleft
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
    local current_tail_img = tail_images.left

    -- Select tail direction
    if body_before.x > tail.x then
        current_tail_img = tail_images.left
    elseif body_before.x < tail.x then
        current_tail_img = tail_images.right
    elseif body_before.y > tail.y then
        current_tail_img = tail_images.up
    elseif body_before.y < tail.y then
        current_tail_img = tail_images.down
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
    snake_move.update(dt, snake)
end

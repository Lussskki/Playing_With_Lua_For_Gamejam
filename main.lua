local dirX = 1
local dirY = 0
local timer = 0
local move_interval = 0.2

function love.load()
    -- apple
    appleImage = love.graphics.newImage("assets/apple.png")
    appleSize = 30
    apple = { x = 10, y = 10 }

    --head
    headImages = {
        up = love.graphics.newImage("assets/head_up.png"),
        down = love.graphics.newImage("assets/head_down.png"),
        left = love.graphics.newImage("assets/head_left.png"),
        right = love.graphics.newImage("assets/head_right.png")
    }

    --body
    bodyImages = {
        horizontal = love.graphics.newImage("assets/body_horizontal.png"),
        vertical = love.graphics.newImage("assets/body_vertical.png"),
        topleft = love.graphics.newImage("assets/body_topleft.png"),
        topright = love.graphics.newImage("assets/body_topright.png"),
        bottomleft = love.graphics.newImage("assets/body_bottomleft.png"),
        bottomright = love.graphics.newImage("assets/body_bottomright.png")
    }

    --tail
    tailImages = {
        up = love.graphics.newImage("assets/tail_up.png"),
        down = love.graphics.newImage("assets/tail_down.png"),
        left = love.graphics.newImage("assets/tail_left.png"),
        right = love.graphics.newImage("assets/tail_right.png")
    }

    -snake sizes
    snakeSize = 30
    snake = {
        {x = 12, y = 12},
        {x = 11, y = 12},
        {x = 10, y = 12}
    }
end

function love.draw()
    local scaleX = appleSize / appleImage:getWidth()
    local scaleY = appleSize / appleImage:getHeight()
    love.graphics.draw(appleImage, apple.x * appleSize, apple.y * appleSize, 0, scaleX, scaleY)

    local currentHeadImg = headImages.right
    if dirX == 1 then currentHeadImg = headImages.right
    elseif dirX == -1 then currentHeadImg = headImages.left
    elseif dirY == 1 then currentHeadImg = headImages.down
    elseif dirY == -1 then currentHeadImg = headImages.up
    end
    love.graphics.draw(currentHeadImg, snake[1].x * snakeSize, snake[1].y * snakeSize, 0, snakeSize / currentHeadImg:getWidth(), snakeSize / currentHeadImg:getHeight())

    for i = 2, #snake - 1 do
        local current = snake[i]
        local nextSeg = snake[i-1]
        local prevSeg = snake[i+1]
        local img = bodyImages.horizontal

        local dx1 = nextSeg.x - current.x
        local dy1 = nextSeg.y - current.y
        local dx2 = prevSeg.x - current.x
        local dy2 = prevSeg.y - current.y

        if dy1 == 0 and dy2 == 0 then
            img = bodyImages.horizontal
        elseif dx1 == 0 and dx2 == 0 then
            img = bodyImages.vertical
        elseif (dx1 == 1 and dy2 == 1) or (dx2 == 1 and dy1 == 1) then
            img = bodyImages.bottomright
        elseif (dx1 == -1 and dy2 == 1) or (dx2 == -1 and dy1 == 1) then
            img = bodyImages.bottomleft
        elseif (dx1 == 1 and dy2 == -1) or (dx2 == 1 and dy1 == -1) then
            img = bodyImages.topright
        elseif (dx1 == -1 and dy2 == -1) or (dx2 == -1 and dy1 == -1) then
            img = bodyImages.topleft
        end

        love.graphics.draw(img, current.x * snakeSize, current.y * snakeSize, 0, snakeSize / img:getWidth(), snakeSize / img:getHeight())
    end

    local tailIndex = #snake
    local tail = snake[tailIndex]
    local bodyBefore = snake[tailIndex-1]
    local currentTailImg = tailImages.left

    if bodyBefore.x > tail.x then currentTailImg = tailImages.left
    elseif bodyBefore.x < tail.x then currentTailImg = tailImages.right
    elseif bodyBefore.y > tail.y then currentTailImg = tailImages.up
    elseif bodyBefore.y < tail.y then currentTailImg = tailImages.down
    end
    love.graphics.draw(currentTailImg, tail.x * snakeSize, tail.y * snakeSize, 0, snakeSize / currentTailImg:getWidth(), snakeSize / currentTailImg:getHeight())
end

function love.update(dt)
    if love.keyboard.isDown("w") and dirY ~= 1 then
        dirX = 0
        dirY = -1
    elseif love.keyboard.isDown("s") and dirY ~= -1 then
        dirX = 0
        dirY = 1
    elseif love.keyboard.isDown("a") and dirX ~= 1 then
        dirX = -1
        dirY = 0
    elseif love.keyboard.isDown("d") and dirX ~= -1 then
        dirX = 1
        dirY = 0
    end

    timer = timer + dt
    if timer >= move_interval then
        timer = timer - move_interval

        local nextX = snake[1].x + dirX
        local nextY = snake[1].y + dirY

        table.insert(snake, 1, {x = nextX, y = nextY})
        table.remove(snake)
    end
end
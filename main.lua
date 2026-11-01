local dirX = 1
local dirY = 0
local timer = 0
local move_interval = 0.2


function love.load()
    -- apple
    appleImage = love.graphics.newImage("assets/apple.png")
    appleSize = 30
    apple = {
        x = 10,
        y = 10
    }

    -- head 
    snakeHeadImage = love.graphics.newImage("assets/head_right.png")
    snakeSize = 30
    snake = {
        {x = 12, y = 12},
        {x = 11, y = 12},
        {x = 10, y = 12}
    } 

    -- body
    snakeBodyImage = love.graphics.newImage("assets/body_horizontal.png")

    -- tail
    snakeTailImage = love.graphics.newImage("assets/tail_left.png")
end

function love.draw()
    -- apple 
    local scaleX = appleSize / appleImage:getWidth()
    local scaleY = appleSize / appleImage:getHeight()

    love.graphics.draw(appleImage, apple.x * appleSize, apple.y * appleSize, 0, scaleX, scaleY)

    -- snake head
    local snakeScaleX = snakeSize / snakeHeadImage:getWidth()
    local snakeScaleY = snakeSize / snakeHeadImage:getHeight()

    -- body
    local snakeBodyScaleX = snakeSize / snakeBodyImage:getWidth()
    local snakeBodyScaleY = snakeSize / snakeBodyImage:getHeight()
    
    -- tail
    local snakeTailScaleX = snakeSize / snakeTailImage:getWidth()
    local snakeTailScaleY = snakeSize / snakeTailImage:getHeight()

    -- draw snake head
    local headAngle = math.atan2(dirY, dirX)
    love.graphics.draw(snakeHeadImage, snake[1].x * snakeSize + (snakeSize / 2), snake[1].y * snakeSize + (snakeSize / 2), headAngle, snakeScaleX, snakeScaleY, snakeHeadImage:getWidth() / 2, snakeHeadImage:getHeight() / 2)

    -- draw snake body
    local bodyAngle = math.atan2(dirY, dirX)
    love.graphics.draw(snakeBodyImage, snake[2].x * snakeSize + (snakeSize / 2), snake[2].y * snakeSize + (snakeSize / 2), bodyAngle, snakeBodyScaleX, snakeBodyScaleY, snakeBodyImage:getWidth() / 2, snakeBodyImage:getHeight() / 2)
     -- draw snake tail
     local tailAngle = math.atan2(dirY, dirX)
     love.graphics.draw(snakeTailImage, snake[3].x * snakeSize + (snakeSize / 2), snake[3].y * snakeSize + (snakeSize / 2), tailAngle, snakeTailScaleX, snakeBodyScaleY, snakeTailImage:getWidth() / 2, snakeTailImage:getHeight() / 2)
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
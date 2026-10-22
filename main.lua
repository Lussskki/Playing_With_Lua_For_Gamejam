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

    -- draw snake head, body, tail
    love.graphics.draw(snakeHeadImage, snake[1].x * snakeSize, snake[1].y * snakeSize, 0, snakeScaleX, snakeScaleY)
    
    for i = 2, #snake - 1 do
        love.graphics.draw(snakeBodyImage, snake[i].x * snakeSize, snake[i].y * snakeSize, 0, snakeBodyScaleX, snakeBodyScaleY)
    end

    love.graphics.draw(snakeTailImage, snake[3].x * snakeSize, snake[3].y * snakeSize, 0, snakeTailScaleX, snakeTailScaleY)
end

function love.update(dt)
    local dirX = 1
    local dirY = 0

    if love.keyboard.isDown("w") and dirY ~= 1 then
        dirX = 0
        dirY = -1
    elseif love.keyboard.isDown("s") and dirY ~= -1 then
        dirX = -1
        dirY = 0   
    elseif love.keyboard.isDown("a") and dirX ~= 1 then
        dirX = -1
        dirY = 0
    elseif love.keyboard.isDown("d") and dirY ~= -1 then
        dirX = 1
        dirY = 0
    end
    
    
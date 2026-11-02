
local assets = {}

function assets.load()
    -- Apple
    assets.apple_image = love.graphics.newImage("assets/apple.png")
    assets.apple_size = 30

    -- Head sprites
    assets.head_images = {
        up = love.graphics.newImage("assets/head_up.png"),
        down = love.graphics.newImage("assets/head_down.png"),
        left = love.graphics.newImage("assets/head_left.png"),
        right = love.graphics.newImage("assets/head_right.png")
    }

    -- Body sprites
    assets.body_images = {
        horizontal = love.graphics.newImage("assets/body_horizontal.png"),
        vertical = love.graphics.newImage("assets/body_vertical.png"),
        topleft = love.graphics.newImage("assets/body_topleft.png"),
        topright = love.graphics.newImage("assets/body_topright.png"),
        bottomleft = love.graphics.newImage("assets/body_bottomleft.png"),
        bottomright = love.graphics.newImage("assets/body_bottomright.png")
    }

    -- Tail sprites
    assets.tail_images = {
        up = love.graphics.newImage("assets/tail_up.png"),
        down = love.graphics.newImage("assets/tail_down.png"),
        left = love.graphics.newImage("assets/tail_left.png"),
        right = love.graphics.newImage("assets/tail_right.png")
    }
end

return assets

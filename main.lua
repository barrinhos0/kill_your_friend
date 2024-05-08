local jogador = {}
local anim8 = require("bibliotecas/anim8")
local sti = require("bibliotecas/sti")
local mapaDoJogo = sti("mapas/mapa.lua")
local camera = require("bibliotecas/camera")
local cam = camera()
-- local fundo
-- local fundo_quad

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    jogador.x = 0
    jogador.y = 0
    jogador.velo = 3

    jogador.spritesheet = love.graphics.newImage("sprites/personagens/jogador.png")
    jogador.grid = anim8.newGrid(48, 48, jogador.spritesheet:getWidth(), jogador.spritesheet:getHeight())

    jogador.animacoes = {}
    jogador.animacoes.cima = anim8.newAnimation(jogador.grid("1-6", 6), 0.1)
    jogador.animacoes.esquerda = anim8.newAnimation(jogador.grid("1-6", 5), 0.1):flipH()
    jogador.animacoes.direita = anim8.newAnimation(jogador.grid("1-6", 5), 0.1)
    jogador.animacoes.baixo = anim8.newAnimation(jogador.grid("1-6", 4), 0.1)

    jogador.animacoes.parado_cima = anim8.newAnimation(jogador.grid("1-6", 3), 0.25)
    jogador.animacoes.parado_esquerda = anim8.newAnimation(jogador.grid("1-6", 2), 0.25):flipH()
    jogador.animacoes.parado_direita = anim8.newAnimation(jogador.grid("1-6", 2), 0.25)
    jogador.animacoes.parado_baixo = anim8.newAnimation(jogador.grid("1-6", 1), 0.25)

    jogador.anim = jogador.animacoes.parado_baixo

    -- fundo = love.graphics.newImage("sprites/tiles/grama.png")
    -- fundo:setWrap("repeat", "repeat")
    -- fundo_quad = love.graphics.newQuad(0, 0, love.graphics.getDimensions(), love.graphics.getDimensions(), fundo:getWidth(), fundo:getHeight())
end

function love.update(dt)
    if love.keyboard.isDown("w") then
        jogador.y = jogador.y - jogador.velo
        jogador.anim = jogador.animacoes.cima
    end

    if love.keyboard.isDown("a") then
        jogador.x = jogador.x - jogador.velo
        jogador.anim = jogador.animacoes.esquerda
    end

    if love.keyboard.isDown("d") then
        jogador.x = jogador.x + jogador.velo
        jogador.anim = jogador.animacoes.direita
    end

    if love.keyboard.isDown("s") then
        jogador.y = jogador.y + jogador.velo
        jogador.anim = jogador.animacoes.baixo
    end

    function love.keyreleased(key)
        if key == "w" then
            jogador.anim = jogador.animacoes.parado_cima
        elseif key == "a" then
            jogador.anim = jogador.animacoes.parado_esquerda 
        elseif key == "d" then
            jogador.anim = jogador.animacoes.parado_direita
        elseif key == "s" then
            jogador.anim = jogador.animacoes.parado_baixo
        end
    end

    jogador.anim:update(dt)
    cam:lookAt(jogador.x, jogador.y)
end

function love.draw()
    -- Feedback da posição do jogador
    local camX, camY = cam:position()
    local feedbackX = camX - 24
    local feedbackY = camY - 24

    cam:attach()
        mapaDoJogo:drawLayer(mapaDoJogo.layers["Chão"])
        mapaDoJogo:drawLayer(mapaDoJogo.layers["Montanhas"])
        jogador.anim:draw(jogador.spritesheet, jogador.x, jogador.y, nil, nil, nil, 24, 24)
        love.graphics.print("X: " .. jogador.x .. " Y: " .. jogador.y, feedbackX, feedbackY)
    cam:detach()
end
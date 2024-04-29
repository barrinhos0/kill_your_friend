-- Define as variáveis locais
local jogador = {}
local fundo
local fundo_quad

-- Função chamada quando o Love2D é inicializado
function love.load()
    local anim8 = require("bibliotecas/anim8")
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Define as propriedades do jogador
    jogador.x = 0
    jogador.y = 0
    jogador.velo = 3

    jogador.spritesheet = love.graphics.newImage("sprites/jogador.png")
    jogador.grid = anim8.newGrid(48, 48, jogador.spritesheet:getWidth(), jogador.spritesheet:getHeight())

    -- Define as animações do jogador
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

    fundo = love.graphics.newImage("sprites/grama.png")
    fundo:setWrap("repeat", "repeat")
    fundo_quad = love.graphics.newQuad(0, 0, love.graphics.getDimensions(), love.graphics.getDimensions(), fundo:getWidth(), fundo:getHeight())
end

-- Função chamada para atualizar o estado do jogo
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

    -- Função chamada quando uma tecla é solta
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

    -- Atualiza a animação do jogador
    jogador.anim:update(dt)
end

-- Função chamada para desenhar o jogo
function love.draw()
    love.graphics.draw(fundo, fundo_quad, 0, 0)
    jogador.anim:draw(jogador.spritesheet, jogador.x, jogador.y, nil, 5, 5)
    love.graphics.print("X: " .. jogador.x .. " Y: " .. jogador.y, 10, 10)
end

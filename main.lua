function love.load()
	Target = {}

	Target.x = 300
	Target.y = 360
	Target.radius = 50

	Score = 0
	Timer = 0
	GameState = 1

	GameFont = love.graphics.newFont( 40 )

	Sprites = {}
	Sprites.sky = love.graphics.newImage('sprites/sky.png')
	Sprites.target = love.graphics.newImage('sprites/target.png')
	Sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')

	love.mouse.setVisible(false)
end

function love.update( dt )
	if Timer > 0 then
		Timer = Timer - dt
	end

	if Timer < 0 then
		Timer = 0

		GameState = 1
	end
end

function love.draw()
	love.graphics.draw(Sprites.sky, 0, 0)

	love.graphics.setColor( 1, 1, 1 )
	love.graphics.setFont( GameFont )

	love.graphics.print("Score: " .. Score, 5, 5 )
	love.graphics.print("Timer: " .. math.ceil(Timer), 300, 5 )

	if GameState == 1 then
		love.graphics.printf("Click anywhere to begin!", 0, 250, love.graphics.getWidth(), 'center')
	end

	if GameState == 2 then
		love.graphics.draw(Sprites.target, Target.x - Target.radius, Target.y - Target.radius)
	end

	love.graphics.draw(Sprites.crosshairs, love.mouse.getX() - 20, love.mouse.getY() - 20)
end

function DistanceBetween(x1, y1, x2, y2)
	return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end

-- Fazemos a verificação de se o mouse está entre o radius do circulo com o uso
-- da função DistanceBetween()

function love.mousepressed( x, y, button )
	if button == 1 and GameState == 2 then
		local mouseToTarget = DistanceBetween(x, y, Target.x, Target.y)

		if mouseToTarget < Target.radius then
			Score = Score + 1
			Target.x = math.floor( math.random(Target.radius, love.graphics.getWidth() - Target.radius) )
			Target.y = math.floor( math.random(Target.radius, love.graphics.getHeight() - Target.radius) )
		end
	elseif button == 1 and GameState == 1 then
		GameState = 2

		Timer = 10

		Score = 0
	end
end

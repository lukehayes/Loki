package loki

import rl "vendor:raylib"
import "core:math"


Player :: struct {

    position: rl.Vector2,
    velocity: rl.Vector2,
    color:    rl.Color,
    acceleration: f32,
    friction:     f32,
    max_speed:    f32,
    scale:        f32,
} 

/* 
Creates a new player instance as position location.
*/
createPlayer :: proc( position: rl.Vector2 ) -> Player
{
    player := Player{}

	player.position = position
	player.velocity = rl.Vector2{0,0}
	player.scale = 20.0
	player.color = rl.WHITE

	player.acceleration = 0.1
	player.friction = 0.015
	player.max_speed = 450.0

	return player
}

/* 
Update the next player frame.
*/
updatePlayer :: proc( player: ^Player, delta:f32)
{
	if(rl.IsKeyDown(rl.KeyboardKey.W))
	{
		player.velocity.y = math.lerp(player.velocity.y, -player.max_speed, player.acceleration)

	}else if(! rl.IsKeyDown(rl.KeyboardKey.W))
	{
		player.velocity.y = math.lerp(player.velocity.y, 0, player.friction)
	}

	if(rl.IsKeyDown(rl.KeyboardKey.S))
	{
		player.velocity.y = math.lerp(player.velocity.y, player.max_speed, player.acceleration)

	}else if(!rl.IsKeyDown(rl.KeyboardKey.S))
	{

		player.velocity.y = math.lerp(player.velocity.y, 0, player.friction)
	}
	if(rl.IsKeyDown(rl.KeyboardKey.A))
	{
		player.velocity.x = math.lerp(player.velocity.x, -player.max_speed, player.acceleration)

	}else if(! rl.IsKeyDown(rl.KeyboardKey.A))
	{
		player.velocity.x = math.lerp(player.velocity.x, 0, player.friction)
	}

	if(rl.IsKeyDown(rl.KeyboardKey.D))
	{
		player.velocity.x = math.lerp(player.velocity.x, player.max_speed, player.acceleration)
	}else if(!rl.IsKeyDown(rl.KeyboardKey.D))
	{

		player.velocity.x = math.lerp(player.velocity.x, 0, player.friction)
	}

	player.position.x = player.position.x + player.velocity.x * delta
	player.position.y = player.position.y + player.velocity.y * delta
}

/**
Draw the player.
*/
drawPlayer :: proc( player: Player ) {
	rl.DrawRectangle(
		i32(player.position.x),
		i32(player.position.y),
		i32(player.scale),
		i32(player.scale),
		player.color,
	)
}

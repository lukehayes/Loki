package gfx

import "../entity"
import rl "vendor:raylib"

EntityBatch :: struct
{
	entities : [dynamic] entity.Entity
}

/**
Draw all of the entities stored inside the batch.
*/
drawBatch :: proc(batch: ^EntityBatch)
{
	rl.BeginDrawing()
	rl.ClearBackground(rl.BLACK)

	for entity in batch.entities
	{
		rl.DrawRectangle(
			i32(entity.position.x),
			i32(entity.position.y),
			i32(entity.scale),
			i32(entity.scale),
			entity.color,
		)
	}
	rl.EndDrawing()
}

/**
Draw a single entity.
*/
draw :: proc(entity: entity.Entity)
{
	rl.BeginDrawing()
	rl.ClearBackground(rl.BLACK)

	rl.DrawRectangle(
		i32(entity.position.x),
		i32(entity.position.y),
		i32(entity.scale),
		i32(entity.scale),
		entity.color,
	)

	rl.EndDrawing()
}


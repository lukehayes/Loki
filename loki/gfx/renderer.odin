package gfx

import "../entity"
import rl "vendor:raylib"

EntityBatch :: struct
{
	entities : [dynamic] entity.Entity
}

/**
Add an entity to an EntityBatch instance.
*/
batchAdd :: proc(batch: ^EntityBatch, entity: entity.Entity)
{
	append(&batch.entities, entity)
}

/**
Draw all of the entities stored inside the batch.
*/
drawBatch :: proc(batch: ^EntityBatch, color: rl.Color = rl.BLACK)
{
	begin_draw(color)

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

	end_draw()
}


/**
Draw a single entity.
*/
draw :: proc(entity: entity.Entity)
{
	rl.DrawRectangle(
		i32(entity.position.x),
		i32(entity.position.y),
		i32(entity.scale),
		i32(entity.scale),
		entity.color,
	)
}

/**
Tell the renderer to get ready!
*/
begin_draw :: proc(color: rl.Color = rl.BLACK)
{
	rl.BeginDrawing()
	rl.ClearBackground(color)
}

/**
Tell the renderer we have finished for this frame.
*/
end_draw :: proc()
{
	rl.EndDrawing()
}

package gfx

import "../entity"
import rl "vendor:raylib"

EntityBatch :: struct
{
	entities : [dynamic] entity.EntityBase
}

/**
Add an entity to an EntityBatch instance.
*/
batch_add :: proc(batch: ^EntityBatch, entity: entity.EntityBase)
{
	append(&batch.entities, entity)
}

/**
Draw all of the entities stored inside the batch.
*/
batch_draw :: proc(batch: ^EntityBatch, color: rl.Color = rl.BLACK)
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
draw :: proc(entity: entity.EntityBase)
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

draw_line :: proc(start: rl.Vector2, end: rl.Vector2, color: rl.Color = rl.WHITE)
{
		rl.DrawLineV(start, end, color)
}

draw_pixel :: proc(x,y : i32, color : rl.Color = rl.WHITE)
{
	rl.DrawPixel(x,y,color)
}

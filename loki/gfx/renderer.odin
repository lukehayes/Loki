package gfx

import "../entity"
import rl "vendor:raylib"

EntityBatch :: struct
{
	entities : [dynamic] ^entity.EntityBase,
	render_texture : rl.RenderTexture2D
}

/**
Add an entity to an EntityBatch instance.
*/
batch_add :: proc(batch: ^EntityBatch, entity: ^entity.EntityBase)
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


draw_to_fb :: proc()
{

	render_texture_source := rl.Rectangle{0.0,0.0, loki.render_texture_width, -loki.render_texture_height}
	render_texture_dest := rl.Rectangle{0.0,0.0, loki.screenHeight, loki.screenHeight}

	rl.DrawTexturePro(
		batch.render_texture.texture,
		render_texture_source,
		render_texture_dest,
		{0,0},
		0,
		rl.WHITE)
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
Tell the render texture renderer to get ready!
*/
begin_draw_fb :: proc(batch: ^EntityBatch, color: rl.Color = rl.BLACK)
{
	rl.BeginTextureMode(batch.render_texture)
	rl.ClearBackground(color)
}

/**
Draw to the render texture.
*/
draw_fb :: proc()
{
	rl.DrawRectangle(10,10,10,10, rl.GREEN)
	rl.DrawRectangle(40,20,100,10, rl.RED)
	rl.DrawRectangle(200,120,10,100, rl.BLUE)
}

/**
End drawing to the render texture.
*/
end_draw_fb :: proc()
{
	rl.EndTextureMode()
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

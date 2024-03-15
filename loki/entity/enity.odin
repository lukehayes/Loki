package entity

import rl "vendor:raylib"
import "core:math/rand"
import col "../collision"

Entity :: struct  {

	using entity_base: EntityBase,
}

PhysicsEntity :: struct 
{
	using entity_base: EntityBase,

	velocity     : rl.Vector2,
	acceleration : f32,
	friction     : f32,
	max_speed    : f32,

	collision : col.CollisionRect,
}

make_entity :: proc(pos: rl.Vector2, scale: f32 = 20, color: rl.Color = rl.RED) -> Entity {
	e := Entity {}

	e.position = pos
	e.scale = scale
	e.color = color

	return e
}

make_entities :: proc(count: int) -> [dynamic]Entity {

    entities := [dynamic]Entity{}

    for _ in 0..<count
    {
        x,y := rand.float32() * f32(800), rand.float32() * f32(600)
        e := make_entity({x,y})
		append(&entities, e)
    }

	return entities
}

updateEntity :: proc(entity: Entity, delta: f32)
{
}

draw_entity :: proc(entity: EntityBase) {

	rl.DrawRectangle(
		i32(entity.position.x),
		i32(entity.position.y),
		i32(entity.scale),
		i32(entity.scale),
		entity.color,
	)
}

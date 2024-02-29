package entity

import rl "vendor:raylib"

Entity :: struct  {
    position: rl.Vector2,
    velocity: rl.Vector2,
    color:    rl.Color,
    acceleration: f32,
    friction:     f32,
    max_speed:    f32,
    scale:        f32,
}

make_entity :: proc(pos: rl.Vector2, scale: f32 = 20, color: rl.Color = rl.RED) -> Entity {
	e := Entity {}

	e.position = pos
	e.scale = scale
	e.color = color

	return e
}

updateEntity :: proc(entity: Entity, delta: f32)
{
}

draw_entity :: proc(entity: Entity) {

	rl.DrawRectangle(
		i32(entity.position.x),
		i32(entity.position.y),
		i32(entity.scale),
		i32(entity.scale),
		entity.color,
	)
}

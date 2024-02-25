package entity

import rl "vendor:raylib"

Entity :: struct 
{
    position: rl.Vector2,
    velocity: rl.Vector2,
    color:    rl.Color,
    acceleration: f32,
    friction:     f32,
    max_speed:    f32,
    scale:        f32,
}

updateEntity :: proc(entity: Entity, delta: f32)
{
}

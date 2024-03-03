package loki_math

import "core:math"
import "core:math/linalg"

import rl "vendor:raylib"

vec2_length_sqr :: proc(vec: rl.Vector2) -> f32 {
    return (vec.x * vec.x + vec.y * vec.y)
}

vec2_length :: proc(vec: rl.Vector2) -> f32 {
    return math.sqrt(vec.x * vec.x + vec.y * vec.y)
}

vec2_normalize :: proc( vec: rl.Vector2 ) -> rl.Vector2 {

    mag := vec2_length(vec)

    return {
	vec.x / mag,
	vec.y / mag,
    }
}

vec2_direction :: proc( vec: rl.Vector2 ) -> rl.Vector2
{
    dir := rl.Vector2 {}

    dir.x = math.cos(math.atan2(vec.y, vec.x))
    dir.y = math.sin(math.atan2(vec.y, vec.x))

    return dir
}

vec2_angle_between :: proc(start: rl.Vector2, end: rl.Vector2) -> f32
{
    return math.atan2(end.y - start.y, end.x - start.x)
}

vec2_angle_between_deg:: proc(start: rl.Vector2, end: rl.Vector2) -> f32
{
    return math.to_degrees(vec2_angle_between(start, end))
}


package game

import rl "vendor:raylib"
import "core:fmt"

import "../loki"
import "../loki/entity"
import "../loki/gfx"

Game :: struct {
    engine: loki.Engine,
    mx : f32,
    my : f32,
    delta: f32,
}

create_game :: proc() -> Game
{
    game := Game {}

    game.engine = loki.init_engine(800,600, "ABC")

    game.mx = f32(rl.GetMouseX())
    game.my = f32(rl.GetMouseX())

    return game
}

update_game :: proc(game: ^Game)
{
    game.engine.delta = rl.GetFrameTime()

    game.delta = rl.GetFrameTime()
    game.mx = f32(rl.GetMouseX())
    game.my = f32(rl.GetMouseY())
}

add_entity :: proc(game: ^Game, entity: ^entity.EntityBase)
{
    append(&game.engine.batch.entities, entity^)
}

draw :: proc(game: ^Game)
{
    gfx.draw_batch(&game.engine.batch)
}

package loki

import rl "vendor:raylib"
import "core:encoding/json"
import "core:strings"

import "loki_io"
import "gfx"
import "entity"


Engine :: struct
{
    delta : f32,
    batch : gfx.EntityBatch,
}

/* Initialize the engine from JSON settings */
init_engine_json:: proc(fps: i32 = 60) -> Engine
{
    width  := loki_io.get_game_settings("game.json")["window_width"].(json.Float)
    height := loki_io.get_game_settings("game.json")["window_height"].(json.Float)
    title  := loki_io.get_game_settings("game.json")["window_title"].(json.String)

    engine := init_engine(width, height, title)

    return engine
}

/* Create an engine struct and set engine/raylib defaults. */
init_engine :: proc( width, height : f64, title: string, fps: i32 = 60) -> Engine
{
    window_titie : cstring = strings.clone_to_cstring(title)

    rl.InitWindow(i32(width), i32(height), window_titie)
    rl.SetTargetFPS(fps)

    rl.SetTraceLogLevel(rl.TraceLogLevel.INFO)
    rl.InitAudioDevice()

    rl.SetExitKey(rl.KeyboardKey.ESCAPE)
    rl.SetExitKey(rl.KeyboardKey.SPACE)

    engine : Engine = { 0, gfx.EntityBatch {} }

    return engine

}

engine_batch_add :: proc(engine: ^Engine, entity: ^entity.EntityBase)
{
    gfx.batch_add(&engine.batch, entity)
}

engine_draw_batch :: proc(engine: ^Engine, color: rl.Color = rl.BLACK)
{
    gfx.begin_draw(color)

    for entity in engine.batch.entities
    {
	rl.DrawRectangle(
	    i32(entity.position.x),
	    i32(entity.position.y),
	    i32(entity.scale),
	    i32(entity.scale),
	    entity.color,
	)
    }

    gfx.end_draw()
}

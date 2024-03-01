package loki

import rl "vendor:raylib"
import "core:encoding/json"
import "core:strings"

import io "loki_io"


Engine :: struct
{
    delta: f32
}

/* Initialize the engine from JSON settings */
init_engine_json:: proc(fps: i32 = 60) -> Engine
{
    width  := io.get_game_settings("game.json")["window_width"].(json.Float)
    height := io.get_game_settings("game.json")["window_height"].(json.Float)
    title  := io.get_game_settings("game.json")["window_title"].(json.String)

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

    engine : Engine = {0}
    engine.delta = 0.0

    return engine

}

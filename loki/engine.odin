package loki

import rl "vendor:raylib"
import "core:strings"


Engine :: struct
{
    delta: f32
}

/* Create an engine struct and set engine/raylib defaults. */
initEngine :: proc( width, height : f64, title: string) -> Engine
{

    window_titie : cstring = strings.clone_to_cstring(title)

    rl.InitWindow(i32(width), i32(height), window_titie)
    rl.SetTargetFPS(60)

    rl.SetTraceLogLevel(rl.TraceLogLevel.INFO)
    rl.InitAudioDevice()
    rl.SetTargetFPS(60)

    rl.SetExitKey(rl.KeyboardKey.SPACE)
    rl.SetExitKey(rl.KeyboardKey.ESCAPE)

    engine : Engine = {0}
    engine.delta = 0.0

    return engine

}

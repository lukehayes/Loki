package loki

import rl "vendor:raylib"
import "core:strings"


Engine :: struct
{
    delta: f32
}

/* Create an engine struct and set engine/raylib defaults. */
initEngine :: proc( width, height : f64, title: string, fps: i32 = 60) -> Engine
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

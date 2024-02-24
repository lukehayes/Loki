package loki

import rl "vendor:raylib"


Engine :: struct
{
    delta: f32
}

/* Create an engine struct and set engine/raylib defaults. */
initEngine :: proc( width:i32, height:i32, title:cstring ) -> Engine
{
    rl.InitWindow(width, height, title)
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

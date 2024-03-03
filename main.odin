package main

import "core:fmt"

import rl "vendor:raylib"

import "loki"
import lokimath "loki/math"
import gfx "loki/gfx"

main :: proc()
{
    engine := loki.init_engine_json()

    player := loki.create_player({300, 400})
    player.scale = 5

    loki.engine_batch_add(&engine, player)

    for (!rl.WindowShouldClose())
    {
        engine.delta = rl.GetFrameTime()

        loki.update_player(&player, engine.delta)

        gfx.begin_draw()
            gfx.draw(&player)
        gfx.end_draw()
    }

    rl.CloseWindow()
}


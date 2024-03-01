package main

import "core:fmt"
import "core:strings"

import rl "vendor:raylib"

import "loki"
import "loki/gfx"
import "loki/entity"

main :: proc()
{
    engine := loki.initEngine(loki.screenWidth, loki.screenHeight, "Loki")

    batch := gfx.EntityBatch {}
 
    player := loki.create_player({100,100})

    gfx.batch_add(&batch, &player)

    for (!rl.WindowShouldClose())
    {
        engine.delta = rl.GetFrameTime()

        loki.update_player(&player, engine.delta)

        fmt.println(player.position.x)

        gfx.draw_batch(&batch)

        //gfx.begin_draw()
            //entity.draw_entity(player)
            //entity.draw_entity(m)
        //gfx.end_draw()
    }

    rl.CloseWindow()
}


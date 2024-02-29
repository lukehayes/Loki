package main

import "core:fmt"
import rl "vendor:raylib"
import "loki"
import "loki/gfx"

import "loki/entity"
import "base:runtime"
import "base:builtin"
import "core:strings"

Mob :: struct {
    using entity: entity.Entity
}

main :: proc()
{
    engine := loki.initEngine(loki.screenWidth, loki.screenHeight, "Loki")

    batch := gfx.EntityBatch {}
 
    player := loki.create_player({100,100})

    m := Mob {}
    m.position = { 300,300 }
    m.scale = 40
    m.color = rl.PURPLE

    gfx.batch_add(&batch, &player)
    gfx.batch_add(&batch, &m)

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


package main

import "core:fmt"

import rl "vendor:raylib"

import "loki"
import lokimath "loki/math"
import gfx "loki/gfx"

main :: proc()
{
    engine := loki.init_engine_json()

    player := loki.create_player({100, 100})
    player.scale = 5

    loki.engine_batch_add(&engine, player)

    for (!rl.WindowShouldClose())
    {
        engine.delta = rl.GetFrameTime()

        //loki.engine_draw_batch(&engine)
        loki.update_player(&player, engine.delta)

        N :: 2

        v := rl.Vector2 { f32(rl.GetMouseX()) - player.position.x, f32(rl.GetMouseY()) - player.position.y }
        //v := rl.Vector2 { player.position.x - f32(rl.GetMouseX()), player.position.y - f32(rl.GetMouseY()) }
        length := lokimath.vec2_length(v)
        length_sqr := lokimath.vec2_length_sqr(v)
        v_dir := lokimath.vec2_direction(v)

        gfx.begin_draw(rl.WHITE)
            gfx.draw(&player)
            gfx.draw_line(v, player.position, rl.BLACK)
            gfx.draw_line(v, player.position / N, rl.BLACK)
            gfx.draw_line(v, player.position * N, rl.BLACK)
            gfx.draw_line(player.position, v / N, rl.BLACK)
            gfx.draw_line(player.position, v * N, rl.BLACK)

            gfx.draw_line(v, player.position / -N, rl.BLACK)
            gfx.draw_line(v, player.position * -N, rl.BLACK)
            gfx.draw_line(player.position, v / -N, rl.BLACK)
            gfx.draw_line(player.position, v * -N, rl.BLACK)
        gfx.end_draw()

        //gfx.begin_draw()
            //entity.draw_entity(player)
            //entity.draw_entity(m)
        //gfx.end_draw()
    }

    rl.CloseWindow()
}


package main

import rl "vendor:raylib"
import "game"
import "loki"
import "loki/gfx"
import "core:fmt"
import "core:mem"

main :: proc()
{
    // --------- Report memory leaks here with the tracking allocator.

    tracking_allocator : mem.Tracking_Allocator
    mem.tracking_allocator_init(&tracking_allocator, context.allocator)
    context.allocator = mem.tracking_allocator(&tracking_allocator)

    report_memory_leaks :: proc(alctr: ^mem.Tracking_Allocator) -> bool
    {
        memory_leak := false

        fmt.println("---------------")
        for key, val in alctr.allocation_map
        {
            fmt.println("")
            fmt.printf("*x*x*x*x* ==> %v: Memory Leak: %v bytes \n", val.location, val.size)
            fmt.println("")
            memory_leak = true
        }

        if !memory_leak {
            fmt.println(" ")
            fmt.println("No memory leaks found.")
            fmt.println(" ")
        }

        fmt.println("---------------")

        mem.tracking_allocator_clear(alctr)

        return memory_leak
    }

    // --------- End memory reporting.

    /** ---------------------------------------------------
    * ENGINE ENTRY POINT
    --------------------------------------------------- **/
    g := game.create_game()

    player := loki.create_player({300, 400})

    game.add_entity(&g, &player)

    bg_texture := rl.LoadTexture("assets/debug-bg.png");

    batch : gfx.EntityBatch

    batch.render_texture  = rl.LoadRenderTexture(
        loki.render_texture_width,
        loki.render_texture_height)


    for (!rl.WindowShouldClose())
    {
        game.update_game(&g)
        loki.update_player(&player, g.delta)

        gfx.begin_draw_fb(&batch)
            gfx.draw_fb()
        gfx.end_draw_fb()

        rl.BeginDrawing()
            rl.ClearBackground(rl.BLACK)

        rl.EndDrawing()

    }

    delete(g.engine.batch.entities)

    rl.UnloadRenderTexture(batch.render_texture)
    rl.UnloadTexture(bg_texture)

    rl.CloseWindow()

    if(ODIN_DEBUG)
    {
        report_memory_leaks(&tracking_allocator)
    }
}


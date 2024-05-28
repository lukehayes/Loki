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

    render_texture := rl.LoadRenderTexture(320,180)

    for (!rl.WindowShouldClose())
    {
        game.update_game(&g)
        loki.update_player(&player, g.delta)

        //game.draw(&g, gfx.Col_7)


        rl.BeginTextureMode(render_texture)
            rl.DrawText("Render Texture Here", 10,10, 10, rl.WHITE)
        rl.EndTextureMode()

        rl.BeginDrawing()

            s := rl.Rectangle{0.0,0.0,100.0,100.0}
            d := rl.Rectangle{0.0,0.0,100.0,100.0}

            rl.ClearBackground(rl.BLUE)
            rl.DrawTexturePro(render_texture.texture, s,d)
        rl.EndDrawing()

    }

    delete(g.engine.batch.entities)

    rl.UnloadRenderTexture(render_texture)

    rl.CloseWindow()

    if(ODIN_DEBUG)
    {
        report_memory_leaks(&tracking_allocator)
    }
}


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

    g := game.create_game()

    player := loki.create_player({300, 400})

    game.add_entity(&g, &player)

    state := game.GameState.Playing

    for (!rl.WindowShouldClose())
    {
        game.update_game(&g)

        if(rl.IsKeyDown(rl.KeyboardKey.Z))
        {
            state = game.GameState.Paused
        }

        if(rl.IsKeyDown(rl.KeyboardKey.P))
        {
            state = game.GameState.Playing
        }

        switch state {

            case .Playing: {
                loki.update_player(&player, g.delta)
                game.draw(&g, gfx.Col_7)
            }

            case .Paused: {
                gfx.begin_draw(gfx.Col_7)
                    rl.DrawText("Paused", 400 - 32,300 - 16, 20, gfx.Col_2)
                gfx.end_draw()
            }
        }


    }

    delete(g.engine.batch.entities)

    rl.CloseWindow()

    if(ODIN_DEBUG)
    {
        report_memory_leaks(&tracking_allocator)
    }
}


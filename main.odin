package main

import rl "vendor:raylib"
import "game"
import "loki"
import "loki/gfx"
import "core:fmt"
import "core:mem"
import "core:math/noise"

Block :: struct 
{
    position: rl.Vector2,
    color:    rl.Color,
    scale:    f32,
    rn:       f32,
}


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

    seed : i64 = 4
    grid_max := 20
    tile_size : f32 = 16

    blocks := make([dynamic]Block, 10,10)

    for x in 0..<grid_max
    {
        for y in 0..<grid_max
        {
            coords : [2]f64 = { f64(x), f64(y) }
            rn := noise.noise_2d(seed, coords)
            //fmt.println(rn, coords)
            xx : f32 = f32(x)
            yy : f32 = f32(y)
            color := rl.WHITE

            if rn > 0.61
            {
                color = rl.Color { 0,255,200, 255 }
            }else if rn > 0.3 && rn < 0.6
            {

                color = rl.YELLOW
            }
            else 
            {
                color = rl.BLUE
            }

            b := Block {
                {xx * tile_size, yy * tile_size},
                color,
                tile_size,
                rn,
            }

            append(&blocks, b)
        }
    }


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
                //game.draw(&g, gfx.Col_7)

                gfx.begin_draw()
                for block in blocks
                {
                    rl.DrawRectangle(
                        i32(block.position.x),
                        i32(block.position.y),
                        i32(block.scale),
                        i32(block.scale),
                        block.color,
                    )
                }
            
                gfx.end_draw()
            }

            case .Paused: {
                gfx.begin_draw(gfx.Col_7)
                    rl.DrawText("Paused", 400 - 32,300 - 16, 20, gfx.Col_2)
                gfx.end_draw()
            }
        }
    }

    delete(g.engine.batch.entities)
    delete(blocks)

    rl.CloseWindow()

    if(ODIN_DEBUG)
    {
        report_memory_leaks(&tracking_allocator)
    }
}


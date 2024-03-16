package main

import rl "vendor:raylib"
import "game"
import "loki"
import "loki/gfx"
import "core:fmt"

GameState :: enum { Playing, Paused }

main :: proc()
{
    g := game.create_game()

    player := loki.create_player({300, 400})

    game.add_entity(&g, &player)

    state := GameState.Playing

    gfx.hex_to_rgb(0x1E, 0x01, 0x4B)
    gfx.hex_to_rgb(0x00, 0x00, 0x00)
    gfx.hex_to_rgb(0x2A, 0x39, 0xC3)

    for (!rl.WindowShouldClose())
    {
        game.update_game(&g)

        fmt.println(state)

        if(rl.IsKeyDown(rl.KeyboardKey.Z))
        {
            state = GameState.Paused
        }

        if(rl.IsKeyDown(rl.KeyboardKey.P))
        {
            state = GameState.Playing
        }

        switch state {

            case .Playing: {
                loki.update_player(&player, g.delta)
                game.draw(&g)
            }

            case .Paused: {
                gfx.begin_draw(rl.BLUE)
                    rl.DrawText("Paused", 400 - 16,300 - 16, 20, rl.WHITE)
                gfx.end_draw()
            }
        }



    }

    rl.CloseWindow()
}


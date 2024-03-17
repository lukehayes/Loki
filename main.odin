package main

import rl "vendor:raylib"
import "game"
import "loki"
import "loki/gfx"
import "core:fmt"


main :: proc()
{
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

    rl.CloseWindow()
}


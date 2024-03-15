package main

import rl "vendor:raylib"

import "loki"
import gfx "loki/gfx"

import "game"

main :: proc()
{
    g := game.create_game()

    player := loki.create_player({300, 400})

    game.add_entity(&g, &player)

    for (!rl.WindowShouldClose())
    {
        game.update_game(&g)

        loki.update_player(&player, g.delta)

        //game.draw(&g)

        gfx.begin_draw()
            gfx.draw(&player)
        gfx.end_draw()
    }

    rl.CloseWindow()
}


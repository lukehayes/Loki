package main

import "core:fmt"
import rl "vendor:raylib"
import "loki"

main :: proc()
{

    engine := loki.initEngine(loki.screenWidth, loki.screenHeight, "Loki")

    player := loki.createPlayer({100,100})

    
    for (!rl.WindowShouldClose())
    {
        engine.delta = rl.GetFrameTime()

        rl.BeginDrawing()
            rl.ClearBackground(rl.BLACK)
            rl.DrawRectangle( 10, 10, 100, 100, rl.YELLOW)
        rl.EndDrawing()

       fmt.println("Delta Time: ", engine.delta)

       loki.updatePlayer(&player, engine.delta)

       loki.drawPlayer(player)
    }

    rl.CloseWindow()
}


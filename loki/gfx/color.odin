package gfx;

import rl "vendor:raylib"
import "core:fmt"

BLACK :: rl.Color{ 0, 0, 0, 255 }
WHITE :: rl.Color{ 255, 255, 255, 255 }
DARK :: rl.Color { 31, 01, 75, 255 }
//MAIN :: rl.Color {  }

//#1e014b DARK
//#78478e MAIN
//#58e1c3 ACCENT
//#ffdaff HILIGHT

Col_1 :: rl.Color { 255, 255, 255, 255}
Col_2 :: rl.Color { 12, 230, 242, 255}
Col_3 :: rl.Color { 0, 152, 219, 255}
Col_4 :: rl.Color { 30, 87, 156, 255}
Col_5 :: rl.Color { 32, 53, 98, 255}
Col_6 :: rl.Color { 37, 36, 70, 255}
Col_7 :: rl.Color { 32, 21, 51, 255}



hex_to_rgb :: proc(r: u8, g: u8, b: u8)
{
	fmt.printf("R: %d G: %d B: %d", r,g,b)
	fmt.printf("\n")
}

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

hex_to_rgb :: proc(r: u8, g: u8, b: u8)
{
	fmt.printf("R: %d G: %d B: %d", r,g,b)
	fmt.printf("\n")
}

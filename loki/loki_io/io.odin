package loki_io

import "core:encoding/json"
import "core:strings"
import "core:os"
import "core:fmt"

FileIOError :: struct {
	filename: string,
	position: int,
}

LokiIOError :: union {
	json.Error,
	FileIOError,
}

/*
General read file helper.
*/
read_file :: proc(file: string) -> string
{
	data, ok := os.read_entire_file_from_filename(file)

	if !ok
	{
		fmt.println("Failed to read file: ", file)
	}

	defer delete(data, context.allocator)

	return string(data)
}

/*
Simple helper functions IO functions
*/
read_game_settings :: proc(file : string) -> (data: []u8 , succ: bool)
{
	data = os.read_entire_file_from_filename(strings.concatenate({"../loki/data/", file})) or_return
	return
}

/**
Get the game settings from the data/game.json file and return a JSON Object.
*/
get_game_settings :: proc(file: string) -> (json.Object)
{
	data, ok := read_game_settings(file)

	if !ok
	{
		fmt.println(" ")
		fmt.println("Failed to load file...", file)
		fmt.println(" ")
	} 
	
	json_data, err := json.parse(data)

	if err != .None
	{
		fmt.eprintln("Failed to parse the json file.")
		fmt.eprintln("Error:", err)
		return nil
	}

	return json_data.(json.Object)
}


example :: proc()
{
	// Load in your json file!
	data, ok := os.read_entire_file_from_filename("game_settings.json")

	if !ok {
		fmt.eprintln("Failed to load the file!")
		return
	}
	defer delete(data) // Free the memory at the end

	// Parse the json file.
	json_data, err := json.parse(data)
	if err != .None {
		fmt.eprintln("Failed to parse the json file.")
		fmt.eprintln("Error:", err)
		return
	}
	defer json.destroy_value(json_data)

	// Access the Root Level Object
	root := json_data.(json.Object)

	fmt.println("Root:")
	fmt.println(
		"window_width:",
		root["window_width"],
		"window_height:",
		root["window_height"],
		"window_title:",
		root["window_title"],
	)
	fmt.println("rendering_api:", root["rendering_api"])

	// Store the value.
	window_width := root["window_width"].(json.Float)
	fmt.println("window_width:", window_width)

	fmt.println("")

	fmt.println("Renderer Settings:")
	renderer_settings := root["renderer_settings"].(json.Object)
	fmt.println("msaa:", renderer_settings["msaa"])
	fmt.println("depth_testing:", renderer_settings["depth_testing"])

}

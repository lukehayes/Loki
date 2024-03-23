package tilemap

import "core:os"
import "core:fmt"
import "core:strings"
import "core:encoding/json"

import "../loki_io"

read_map_json :: proc ( file : string ) -> string
{
	json_file := strings.concatenate({"assets/", file})
	json_data := loki_io.read_file(json_file)

	defer delete(json_file)

	return json_data
}

parse_map :: proc(json_contents: string) -> json.Value
{
	//data_arr : []u8 = transmute([]u8)read_map_json(json_contents)
	json_string := read_map_json(json_contents)
	data_arr : []u8 = transmute([]u8) json_string
	json_data, json_data_ok := json.parse_string("../assets/map.tmj")

	fmt.println(json_data)

	if json_data_ok  == nil
	{
		fmt.println("Error with: ", json_contents)
	}

	return json_data.(json.Object)
}

get_value :: proc(file: string, entry: string) -> (json.Value)
{
	// Custom read file procures mess up the json file. Fix later.
	data, ok := os.read_entire_file_from_filename(strings.concatenate({
		"../assets/",
		file,
	}))

	//data, ok := read_game_settings(file)
	data_arr : []u8 = transmute([]u8)data

	if !ok
	{
		fmt.println(" ")
		fmt.println("Failed to load file...", file)
		fmt.println(" ")
	} 
	
	json_data, err := json.parse(data_arr)

	if err != .None
	{
		fmt.eprintln("Failed to parse the json file.")
		fmt.eprintln("Error:", err)
		return nil
	}

	return (json_data)
}


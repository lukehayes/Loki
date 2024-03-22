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

parse_map :: proc(json_contents: string)
{
	data_arr : []u8 = transmute([]u8)read_map_json(json_contents)
	json_data, json_data_ok := json.parse(data_arr)

	if json_data_ok  == nil
	{
		fmt.println("Error with: ", json_contents)
	}



	fmt.println(json_data)
}

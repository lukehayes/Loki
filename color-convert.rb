# frozen_string_literal: true

color_list = ARGV[0]

if !color_list
  puts "A list of hexadecimal colors need to be added..."
  puts ""
  puts "e.g"
  puts "\t \'ruby color-convert.rb  \"#ffffff #000000\" \' "
  puts ""
  exit
end

color_list = color_list.split(" ")

colors = [
  '#040026',
  '#004bc0',
  '#0097ec',
  '#00f3fc',
  '#ffbcff',
  '#d569f6',
  '#6c1fd3'
]

def highest_color_value(c)
  return c.max
end

def rank_colors(c)

  # Remove hash from string
  c.gsub!('#','')

  # Turn hashes from hex to decimal
  split_colors =  [
    ('0x' + c[0..1]).to_i(16),
    ('0x' + c[2..3]).to_i(16),
    ('0x' + c[4..5]).to_i(16)
  ]

  # Find the highest color value out of R,G and B
  color_index = split_colors.index highest_color_value split_colors

  #puts "Red: #{split_colors[0]}, Green: #{split_colors[1]}, Blue: #{split_colors[2]}"
  #puts "Largest: #{split_colors.max}"
  #puts "Smallest: #{split_colors.min}"
  #puts "------"

  if color_index == 0
    return "Red"
  elsif color_index == 1
    return "Green"
  else color_index == 2
    return "Blue"
  end

end

def replace_hash(s)
  s.gsub('#', '0x')
end

def convert_to_hex(colors)
  colors.map! { |c| replace_hash c }
end

def make_struct(id, r, g, b, a = 255)
  "Col_#{id} :: rl.Color { #{r}, #{g}, #{b}, #{a} }"
end

def make_struct_with_col_name(color_name, id, r, g, b, a = 255)
  "#{color_name}_#{id} :: rl.Color { #{r}, #{g}, #{b}, #{a} }"
end

def print_structs(colors)
  id = 1
  colors.each do |c|

    r = c.slice(2..3).to_i 16
    g = c.slice(4..5).to_i 16
    b = c.slice(6..7).to_i 16

    puts make_struct(id, r,g,b)
    id += 1
  end
end

def print_structs_with_color_names(colors)
  id = 1
  colors.each do |c|

    color_name = rank_colors c

    r = c.slice(2..3).to_i 16
    g = c.slice(4..5).to_i 16
    b = c.slice(6..7).to_i 16

    puts make_struct_with_col_name(color_name, id, r,g,b)
    id += 1
  end
end


print_structs color_list
print_structs_with_color_names color_list


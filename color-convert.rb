# frozen_string_literal: true

colors = [
  '#040026',
  '#004bc0',
  '#0097ec',
  '#00f3fc',
  '#ffbcff',
  '#d569f6',
  '#6c1fd3'
]

def replace_hash(s)
  s.gsub('#', '0x')
end

def convert_to_hex(colors)
  colors.map! { |c| replace_hash c }
end

def make_struct(id, r, g, b, a = 255)
    "Col_#{id} :: rl.Color { #{r}, #{g}, #{b}, #{a} }"
end

def print_structs(colors)
    id = 1
    colors.each do |c|

        r = c.slice(2..3).to_i 16
        g = c.slice(4..5).to_i 16
        b = c.slice(6..7).to_i 16

        # puts "R #{r}, G #{g}, B #{b}"
        puts make_struct(id, r,g,b)
        id += 1
    end
end

#convert_to_hex(colors)
#print_structs(colors)

puts ARGV.class


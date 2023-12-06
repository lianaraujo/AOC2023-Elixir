{:ok, contents} = File.read("day1.txt")

# part1
contents |> String.split("\n", trim: true) \
  |> Enum.map(fn line -> String.split(line, "", trim: true) \
  |> Enum.filter(fn c -> Integer.parse(c) != :error end) end) \
  |> Enum.map(fn nums -> Enum.concat(Enum.take(nums, 1), Enum.take(nums, -1)) \
  |> Enum.join("") end) |> Enum.map(&String.to_integer/1)
  |> Enum.sum()
  |> IO.puts

# part2

defmodule NumberParser do
  def remove_first_char(string) do
    binary_part(string, 1, byte_size(string) - 1)
  end
  def parse_number(string, final_string \\ "")
  def parse_number("", final_string) do final_string end
  def parse_number(string, final_string) do
    case string do
    "one" <> _ -> parse_number(remove_first_char(string), final_string <> "1")
    "1" <> _ -> parse_number(remove_first_char(string), final_string <> "1")
    "two" <> _ -> parse_number(remove_first_char(string), final_string <> "2")
    "2" <> _ -> parse_number(remove_first_char(string), final_string <> "2")
    "three" <> _ -> parse_number(remove_first_char(string), final_string <> "3")
    "3" <> _ -> parse_number(remove_first_char(string), final_string <> "3")
    "four" <> _ -> parse_number(remove_first_char(string), final_string <> "4")
    "4" <> _ -> parse_number(remove_first_char(string), final_string <> "4")
    "five" <> _ -> parse_number(remove_first_char(string), final_string <> "5")
    "5" <> _ -> parse_number(remove_first_char(string), final_string <> "5")
    "six" <> _ -> parse_number(remove_first_char(string), final_string <> "6")
    "6" <> _ -> parse_number(remove_first_char(string), final_string <> "6")
    "seven" <> _ -> parse_number(remove_first_char(string), final_string <> "7")
    "7" <> _ -> parse_number(remove_first_char(string), final_string <> "7")
    "eight" <> _ -> parse_number(remove_first_char(string), final_string <> "8")
    "8" <> _ -> parse_number(remove_first_char(string), final_string <> "8")
    "nine" <> _ -> parse_number(remove_first_char(string), final_string <> "9")
    "9" <> _ -> parse_number(remove_first_char(string), final_string <> "9")
     _ -> parse_number(remove_first_char(string), final_string)
    end
  end
end
contents |> String.split("\n", trim: true) \
  |> Enum.map(&NumberParser.parse_number/1)
  |> Enum.map(fn line -> String.split(line, "", trim: true) end) \
  |> Enum.map(fn nums -> Enum.concat(Enum.take(nums, 1), Enum.take(nums, -1)) |> Enum.join("") end) \
  |> Enum.map(&String.to_integer/1)
  |> Enum.sum
  |> IO.puts

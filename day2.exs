{:ok, input} = File.read("day2.txt")

map = %{
"blue" => 14,
"red" => 12,
"green" => 13
}

games = input |> String.split("\n", trim: true) 

total = length(games)

games |> Enum.map(fn string -> String.split(string, ":", trim: true) end) \
  |> Enum.map(fn ["Game " <> id, dices] -> dices |> String.split(";", trim: true) \
    |> Enum.map(fn string -> String.split(string, ",", trim: true) \
    |> Enum.map(fn string -> string |> String.split(" ", trim: true) \
    |> then(fn [head, tail] -> String.to_integer(head) <= map[tail] end) end) end) \
    |> List.flatten() end) \
  |> Enum.with_index() \
  |> Enum.filter(fn {list , _} -> Enum.all?(list) end) \
  |> Enum.map(fn {_, index} -> index + 1 end) \
  |> Enum.sum \
  |> IO.puts

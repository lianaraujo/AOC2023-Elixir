{:ok, input} = File.read("day2.txt")

example = """
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
"""
map = %{
"blue" => 14,
"red" => 12,
"green" => 13
}

games = input |> String.split("\n", trim: true) 


games |> Enum.map(fn string -> String.split(string, ":", trim: true) end) \
  |> Enum.map(fn ["Game " <> _, dices] -> dices |> String.split(";", trim: true) \
    |> Enum.map(fn string -> String.split(string, ",", trim: true) \
    |> Enum.map(fn string -> string |> String.split(" ", trim: true) \
    |> then(fn [head, tail] -> String.to_integer(head) <= map[tail] end) end) end) \
    |> List.flatten() end) \
  |> Enum.with_index() \
  |> Enum.filter(fn {list , _} -> Enum.all?(list) end) \
  |> Enum.map(fn {_, index} -> index + 1 end) \
  |> Enum.sum \
  |> IO.puts


  games |> Enum.map(fn game -> [game , dices] = String.split(game, ":", trim: true)
  dices end) \
  |> Enum.map(fn game -> String.split(game, ";", trim: true) end) \
  |> Enum.map(fn games -> Enum.reduce(games, {_blue = 0, _red = 0, _green = 0 },
    fn game, {_blue, _red, _green} -> String.split(game, ",", trim: true) \
    |> Enum.reduce({blue = _blue, red = _red, green = _green}, fn g, {blue, red, green} -> String.split(g, " ", trim: true) \
    |> then(fn [head,tail] -> 
      case tail do
        "blue" ->  if String.to_integer(head) > blue, do: {String.to_integer(head), red, green} , else: {blue, red, green} 
        "red" ->  if String.to_integer(head) > red, do: {blue,String.to_integer(head), green} , else: {blue, red, green} 
        "green" ->  if String.to_integer(head) > green, do: {blue, red, String.to_integer(head)} , else: {blue, red, green} 
        _ -> {blue, red, green}
      end
    end) end) end) end) \
  |> Enum.map(fn {blue, red, green} -> blue * red * green end) \
  |> Enum.sum \
  |> IO.puts

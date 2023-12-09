defmodule Day3 do
  @dirs [{1, 0}, {0, 1}, {-1, 0}, {0, -1}, {1, 1}, {-1, 1}, {-1, -1}, {1, -1}]
  defp parse_input(input, regex) do
    lines = String.split(input, "\n", trim: true) 
    chars =
      lines 
      |> Enum.with_index()
      |> Enum.reduce(MapSet.new(),fn {line, i}, acc -> 
        Regex.scan(regex, line, return: :index)
        |> List.flatten()
        |> Enum.reduce(acc, fn {start, _}, acc ->
          MapSet.put(acc, {start, i})
        end)
      end)
      {lines, chars}
  end 
  def full_number({x, y}, lines) do
    line = Enum.at(lines, y)
    {left, right} = {find_n_index(x, line, -1), find_n_index(x, line, 1)}
    full_n = line |> String.slice(left, right - left + 1) |> String.to_integer()
    {full_n, {{left, y}, {right, y}}}
  end
  def find_n_index(x, line, dir) do
    char = String.at(line, x + dir) || ""

    case Integer.parse(char) do
      :error -> x
      _ -> find_n_index(x + dir, line, dir)
    end
  end
  def part1(input) do
    {lines, chars} = parse_input(input, ~r/[^0-9.]/)
    Enum.reduce(chars, MapSet.new(), fn {x,y}, acc ->
      Enum.reduce(@dirs, acc, fn {dx, dy}, acc ->
        check = lines |> Enum.at(y + dy) |> String.at(x + dx)
        case check do
          nil -> acc
          "." -> acc
          _ -> MapSet.put(acc, full_number({x + dx, y + dy},lines))
        end
      end)
    end)
    |> Enum.map(fn {n,_} -> n end)
    |> Enum.sum
  end
end

example = """
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
"""
{:ok, input} = File.read("day3.txt")
Day3.part1(input) |> IO.puts






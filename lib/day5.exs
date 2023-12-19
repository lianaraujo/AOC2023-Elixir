defmodule Day4 do
  def part1(input) do
    [seeds | maps] = parse_input(input)

    tables = Enum.map(maps, &String.split(&1, "\n", trim: true))
    |> Enum.map(fn [_ | rest] ->
      Enum.map(rest, fn numbers ->
        String.split(numbers, " ")
        |> Enum.map(&String.to_integer/1)
      end)
    end)
    
    [_ | rest] = String.split(seeds, " ")
    Enum.map(rest, &pipeline(&1, tables))
    |> Enum.min
  end

  def part2(input) do
  end

  defp pipeline(seed, tables) do
    s = String.to_integer(seed)
    Enum.reduce(tables, s, fn table, acc ->
      Enum.reduce(table, acc, fn [destination, source, range], acc1 -> 
        if acc1 in source..(source + range - 1) do
          (acc1 - source) + destination 
        else
          acc1
        end
      end)
    end)
  end

  defp parse_input(input) do
    String.split(input, "\n\n")
  end
end

example = """
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
"""

{:ok, input} = File.read("lib/day5.txt")

Day4.part1(example) |> IO.inspect(charlists: :as_lists)
Day4.part2(example) |> IO.inspect()

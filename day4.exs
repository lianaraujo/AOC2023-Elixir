defmodule Day4 do
  def part1(input) do
    parse_input(input) |> Enum.map(fn {_, win, nums} ->
      Enum.reduce(nums, 0, fn num, acc ->
        if num in win do
          if acc > 0, do: acc * 2, else: 1
        else
          acc
        end
      end)
    end)
    |> Enum.sum()
  end

  def part2(input) do
    games =parse_input(input) 
    result = process_games(games)
    result + length(games)
  end
  
  defp process_games(processing_list, result \\ %{})
  # brute force
  defp process_games([{id, win, nums} | tail], result) do
    winning_numbers = Enum.reduce(nums, 0, fn num, acc ->
      if num in win do
        acc + 1
      else
        acc
      end
    end)
    multiplier = if Map.has_key?(result, id), do: Map.get(result, id), else: 0 
    if winning_numbers > 0 do
    new_map = Enum.reduce(0..(winning_numbers - 1), result, fn idx, acc ->
      if idx < length(tail) do
        {card_number, _, _} = Enum.at(tail, idx)
        curr_value = if Map.has_key?(acc, card_number), do: Map.get(acc, card_number), else: 0 
        cara = Map.put(acc, card_number, curr_value + (1 * (multiplier + 1)))
        cara
       else 
         acc
       end
    end) 
      process_games(tail, new_map)
    else 
      process_games(tail, result)
    end
  end
  defp process_games([], result) do 
    Enum.map(result, fn {_, value} -> value end)
    |> Enum.sum
  end

  defp parse_input(input) do
    String.split(input, "\n", trim: true) |> Enum.map(fn line ->
      ["Card " <> id, win, nums] = String.split(line, [":","|"], trim: true)
      {String.trim(id), space_split(win), space_split(nums)}
    end)
  end
  defp space_split(list) do
    String.split(list, " ", trim: true)
  end
end

example = """
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
"""

{:ok, input} = File.read("day4.txt")
Day4.part1(input) |> IO.inspect
Day4.part2(input) |> IO.inspect

defmodule Monadish do

  # unit
  # just [name, saying]
  def fighter(someone) do
    case someone do
      "guile" -> [someone, "sonic boom!"]
      "ryu" -> [someone, "hadouken!"]
      "ken" -> [someone, "hadouken!"]
      "blanka" -> [someone, "          (do you get it?!)"]
      true -> ["", ""]
    end
  end

  # bind
  # note that the parameter `vs` will just contain the function
  # Monadish.fight/2 and passes along the fighters there
  def faceoff(fighter1, vs, fighter2) do
    vs.(fighter1, fighter2)
  end

  # things we eventually want to do
  def fight(fighter, challenger) do
    # i know... not a pure function... how dare i
    [fighter_name, fighter_says] = fighter
    [challenger_name, challenger_says] = challenger
    IO.puts(fighter_name <> " vs " <> challenger_name)
    IO.puts(fighter_says <> " <*> " <> challenger_says)
    IO.puts("")

    [winner, winner_says] = [fighter, challenger]
                              |> Enum.random()
    IO.puts(winner <> " won the fight!")
    IO.puts("")

    [winner, winner_says]
  end

  def tournament(fighters) do
    [primary1, challenger1, primary2, challenger2] = Enum.shuffle(fighters)
    # magic time
    primary1 |> faceoff(&fight/2, challenger1)
             |> faceoff(&fight/2, (
                primary2 |> faceoff(&fight/2, challenger2)
              ))
  end

end


ken = Monadish.fighter("ken")
guile = Monadish.fighter("guile")
blanka = Monadish.fighter("blanka")
ryu = Monadish.fighter("ryu")

[winner, _] = Monadish.tournament([ken, guile, blanka, ryu])

IO.puts "#{winner} wins!"

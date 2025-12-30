import gleam/int
import gleam/io
import gleam/result
import gleam/string
import in

pub fn main() {
  // Welcome Message
  welcome()

  let goal = int.clamp(int.random(100), 1, 100)
  let guesses = choose_difficult()
  io.println("Let's start the game!")

  game(goal:, guesses:)
}

fn game(goal goal: Int, guesses guesses: Int) {
  case guesses <= 0 {
    True -> io.println("Game over! The number was ")
    False -> {
      io.print("Enter your guess: ")
      let assert Ok(input) = in.read_line()
      let input =
        string.trim(input)
        |> int.parse()
        |> result.unwrap(or: 0)

      case input {
        _ if input == goal -> io.println("Congratulations! You won!")
        _ if input > goal -> {
          io.println(
            "Incorrect! The number is less than "
            <> int.to_string(input)
            <> ".guesses left: "
            <> int.to_string(guesses),
          )
          game(goal:, guesses: guesses - 1)
        }
        _ -> {
          io.println(
            "Incorrect! The number is greater than "
            <> int.to_string(input)
            <> ".guesses left: "
            <> int.to_string(guesses),
          )
          game(goal:, guesses: guesses - 1)
        }
      }
    }
  }
}

fn choose_difficult() -> Int {
  let assert Ok(difficult) = in.read_line()
  let difficult = string.trim(difficult)

  case difficult {
    "1" -> {
      io.println("Great! You selected the Easy difficult level")
      10
    }

    "2" -> {
      io.println("Great! You selected the Medium difficult level")
      5
    }
    "3" -> {
      io.println("Great! You selected the Hard difficult level")
      3
    }
    _ -> {
      io.println("Please, choose a number your difficult")
      choose_difficult()
    }
  }
}

fn welcome() -> Nil {
  ""
  |> string.append("\nWelcome to the Number Guessing Game!\n")
  |> string.append("I'm thinking of a number between 1 and 100\n\n")
  |> string.append("Please select the difficult level:\n")
  |> string.append("1. Easy (10 chances)\n")
  |> string.append("2. Medium (5 chances\n")
  |> string.append("3. Hard (3 chances\n")
  |> io.println
}

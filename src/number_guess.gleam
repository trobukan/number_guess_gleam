import gleam/int
import gleam/io
import gleam/result
import gleam/string
import in
import utils

type Game {
  Game(goal: Int)
}

pub fn main() {
  let game: Game = Game(goal: goal_randomize())

  echo utils.is_number(20)
  welcome_msg()

  let guesses = choose_difficult()
  io.println("Let's start the game!")

  start_game(goal: game.goal, guesses:)
  restart_game()
}

fn welcome_msg() -> Nil {
  io.println(
    "\n Welcome to Number Guessing Game!\n"
    <> "I'm thinking of a number between 1 and 100\n",
  )
}

fn choose_difficult() -> Int {
  io.println(
    "Please select the difficult level:\n"
    <> "1. Easy (10 chances)\n"
    <> "2. Medium (5 chances)\n"
    <> "3. Hard (3 chances)\n",
  )
  let assert Ok(difficult) = in.read_line()
  let difficult: String = string.trim(difficult)
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

fn goal_randomize() -> Int {
  int.random(100)
  |> int.clamp(1, 100)
}

fn new_game() -> Game {
  Game(goal: goal_randomize())
}

fn restart_game() {
  io.println("Do you want to keep playing?\n" <> "1. Yes\n" <> "2. No")

  let assert Ok(input) = in.read_line()
  case string.trim(input) {
    "1" -> {
      let guesses = choose_difficult()
      io.println("Let's start the game!\n")

      let game = new_game()
      start_game(goal: game.goal, guesses:)
    }
    "2" -> utils.exit_program(msg: "Thanks for playing!\n")
    _ -> restart_game()
  }
}

fn start_game(goal goal: Int, guesses guesses: Int) {
  case guesses <= 0 {
    True ->
      io.println("Game over! The number was " <> int.to_string(goal) <> "\n")
    False -> {
      io.print("Enter your guess: ")
      let assert Ok(input) = in.read_line()
      let input =
        string.trim(input)
        |> int.parse()
        |> result.unwrap(or: 0)

      case input {
        _ if input == goal -> io.println("Congratulations! You won!\n")
        _ if input > goal -> {
          let guesses = guesses - 1
          io.println(
            "Incorrect! The number is less than "
            <> int.to_string(input)
            <> ". guesses left: "
            <> int.to_string(guesses),
          )

          start_game(goal:, guesses: guesses)
        }
        _ -> {
          let guesses = guesses - 1
          io.println(
            "Incorrect! The number is greater than "
            <> int.to_string(input)
            <> ". guesses left: "
            <> int.to_string(guesses),
          )
          start_game(goal:, guesses: guesses)
        }
      }
    }
  }
}

import gleam/int
import gleam/io
import gleam/string
import in
import time
import utils

type Game {
  Game(goal: Int)
}

fn new_game() -> Game {
  Game(goal: goal_randomize())
}

pub fn main() {
  let game: Game = Game(goal: goal_randomize())

  welcome_msg()

  let guesses = choose_difficult()
  let start_time = time.now(time.Second)
  io.println("Let's start the game!")

  start_game(goal: game.goal, guesses:, start_time:)
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

  io.print("> ")
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
      choose_difficult()
    }
  }
}

fn goal_randomize() -> Int {
  int.random(100)
  |> int.clamp(1, 100)
}

fn restart_game() {
  io.println("Do you want to keep playing?\n" <> "1. Yes\n" <> "2. No\n")

  io.print("> ")
  let assert Ok(input) = in.read_line()
  case string.trim(input) {
    "1" -> {
      let guesses = choose_difficult()
      let start_time = time.now(time.Second)
      io.println("Let's start the game!\n")

      let game = new_game()
      start_game(goal: game.goal, guesses:, start_time:)
    }
    "2" -> utils.exit_program(msg: "Thanks for playing!")
    _ -> restart_game()
  }
}

fn start_game(goal goal: Int, guesses guesses: Int, start_time start_time: Int) {
  case guesses <= 0 {
    True ->
      io.println("Game over! The number was " <> int.to_string(goal) <> "\n")
    False -> {
      io.print("Enter your guess: ")
      let assert Ok(input) = in.read_line()
      let input =
        string.trim(input)
        |> int.parse()

      case input {
        Ok(value) ->
          case value {
            _ if value == goal -> {
              io.println("\nCongratulations! You won!")
              show_elapsed_time(start_time)
            }

            _ if value > goal -> {
              let guesses = guesses - 1
              io.println(
                "Incorrect! The number is less than "
                <> int.to_string(value)
                <> ". guesses left: "
                <> int.to_string(guesses),
              )

              start_game(goal:, guesses:, start_time:)
            }
            _ -> {
              let guesses = guesses - 1
              io.println(
                "Incorrect! The number is greater than "
                <> int.to_string(value)
                <> ". guesses left: "
                <> int.to_string(guesses),
              )
              start_game(goal:, guesses:, start_time:)
            }
          }
        Error(_) -> {
          io.println("\nYou must insert a number\n")
          start_game(goal: goal, guesses:, start_time:)
        }
      }
    }
  }
}

fn show_elapsed_time(start_time: Int) {
  let end_time = time.now(time.Second)
  let diff = end_time - start_time
  io.println("You took " <> int.to_string(diff) <> " Seconds\n")
}

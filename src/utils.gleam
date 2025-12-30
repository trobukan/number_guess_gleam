import gleam/io

@external(erlang, "erlang", "halt")
fn exit_erlang(code: Int) -> Nil

pub fn exit_program(msg msg: String) {
  io.println(msg)
  exit_erlang(0)
}
// @external(erlang, "erlang", "is_number")
// pub fn is_number(value value: Int) -> Bool

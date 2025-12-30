pub type TimeUnit {
  Second
  Milisecond
  Microsecond
  Nanosecond
}

@external(erlang, "erlang", "monotonic_time")
fn erlang_now(unit unit: Int) -> Int

pub fn unit_to_int(unit: TimeUnit) -> Int {
  case unit {
    Second -> 1
    Milisecond -> 1000
    Microsecond -> 1_000_000
    Nanosecond -> 1_000_000_000
  }
}

/// Return actual time. 
/// time.now(time.Second)
/// -> Int
pub fn now(unit unit: TimeUnit) -> Int {
  erlang_now(unit_to_int(unit))
}

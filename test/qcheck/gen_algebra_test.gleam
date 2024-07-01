import gleam/int
import gleam/option.{Some}
import gleam/regex
import gleam/result
import gleam/string
import gleeunit/should
import qcheck/generator
import qcheck/qtest
import qcheck/qtest/config as qtest_config
import qcheck/qtest/test_error_message as err

// TODO: a lot of the shrink tests could probably be simplified by inspecting
//   the output of `generator.generate_tree` instead.

// map
// 
//

pub fn map__test() {
  let assert Error(msg) = {
    use <- err.rescue
    qtest.run(
      config: qtest_config.default(),
      generator: generator.small_positive_or_zero_int()
        |> generator.map(int.to_float),
      property: fn(n) { n == 0.0 || n >. 1.0 },
    )
  }

  err.shrunk_value(msg)
  |> should.equal("1.0")
}

fn in_range(min, max) {
  fn(x) { min <= x && x <= max }
}

pub fn map2__test() {
  let min = -100
  let max = 100

  let in_range = in_range(min, max)

  let gen_int = generator.int_uniform_inclusive(min, max)

  qtest.run(
    config: qtest_config.default(),
    generator: generator.map2(fn(a, b) { #(a, b) }, gen_int, gen_int),
    property: fn(tup2) {
      let #(a, b) = tup2

      in_range(a) && in_range(b)
    },
  )
}

pub fn map3__test() {
  let min = -100
  let max = 100

  let in_range = in_range(min, max)

  let gen_int = generator.int_uniform_inclusive(min, max)

  qtest.run(
    config: qtest_config.default(),
    generator: generator.map3(
      fn(a, b, c) { #(a, b, c) },
      gen_int,
      gen_int,
      gen_int,
    ),
    property: fn(tup3) {
      let #(a, b, c) = tup3

      in_range(a) && in_range(b) && in_range(c)
    },
  )
}

pub fn map4__test() {
  let min = -100
  let max = 100

  let in_range = in_range(min, max)

  let gen_int = generator.int_uniform_inclusive(min, max)

  qtest.run(
    config: qtest_config.default(),
    generator: generator.map4(
      fn(a, b, c, d) { #(a, b, c, d) },
      gen_int,
      gen_int,
      gen_int,
      gen_int,
    ),
    property: fn(tup4) {
      let #(a, b, c, d) = tup4

      in_range(a) && in_range(b) && in_range(c) && in_range(d)
    },
  )
}

pub fn map5__test() {
  let min = -100
  let max = 100

  let in_range = in_range(min, max)

  let gen_int = generator.int_uniform_inclusive(min, max)

  qtest.run(
    config: qtest_config.default(),
    generator: generator.map5(
      fn(a, b, c, d, e) { #(a, b, c, d, e) },
      gen_int,
      gen_int,
      gen_int,
      gen_int,
      gen_int,
    ),
    property: fn(tup5) {
      let #(a, b, c, d, e) = tup5

      in_range(a) && in_range(b) && in_range(c) && in_range(d) && in_range(e)
    },
  )
}

pub fn map6__test() {
  let min = -100
  let max = 100

  let in_range = in_range(min, max)

  let gen_int = generator.int_uniform_inclusive(min, max)

  qtest.run(
    config: qtest_config.default(),
    generator: generator.map6(
      fn(a, b, c, d, e, f) { #(a, b, c, d, e, f) },
      gen_int,
      gen_int,
      gen_int,
      gen_int,
      gen_int,
      gen_int,
    ),
    property: fn(tup6) {
      let #(a, b, c, d, e, f) = tup6

      in_range(a)
      && in_range(b)
      && in_range(c)
      && in_range(d)
      && in_range(e)
      && in_range(f)
    },
  )
}

pub fn tuple2__test() {
  let min = -100
  let max = 100

  let in_range = in_range(min, max)

  let gen_int = generator.int_uniform_inclusive(min, max)

  qtest.run(
    config: qtest_config.default(),
    generator: generator.tuple2(gen_int, gen_int),
    property: fn(tup2) {
      let #(a, b) = tup2

      in_range(a) && in_range(b)
    },
  )
}

pub fn tuple3__test() {
  let min = -100
  let max = 100

  let in_range = in_range(min, max)

  let gen_int = generator.int_uniform_inclusive(min, max)

  qtest.run(
    config: qtest_config.default(),
    generator: generator.tuple3(gen_int, gen_int, gen_int),
    property: fn(tup3) {
      let #(a, b, c) = tup3

      in_range(a) && in_range(b) && in_range(c)
    },
  )
}

pub fn tuple4__test() {
  let min = -100
  let max = 100

  let in_range = in_range(min, max)

  let gen_int = generator.int_uniform_inclusive(min, max)

  qtest.run(
    config: qtest_config.default(),
    generator: generator.tuple4(gen_int, gen_int, gen_int, gen_int),
    property: fn(tup4) {
      let #(a, b, c, d) = tup4

      in_range(a) && in_range(b) && in_range(c) && in_range(d)
    },
  )
}

pub fn tuple5__test() {
  let min = -100
  let max = 100

  let in_range = in_range(min, max)

  let gen_int = generator.int_uniform_inclusive(min, max)

  qtest.run(
    config: qtest_config.default(),
    generator: generator.tuple5(gen_int, gen_int, gen_int, gen_int, gen_int),
    property: fn(tup5) {
      let #(a, b, c, d, e) = tup5

      in_range(a) && in_range(b) && in_range(c) && in_range(d) && in_range(e)
    },
  )
}

pub fn tuple6__test() {
  let min = -100
  let max = 100

  let in_range = in_range(min, max)

  let gen_int = generator.int_uniform_inclusive(min, max)

  qtest.run(
    config: qtest_config.default(),
    generator: generator.tuple6(
      gen_int,
      gen_int,
      gen_int,
      gen_int,
      gen_int,
      gen_int,
    ),
    property: fn(tup6) {
      let #(a, b, c, d, e, f) = tup6

      in_range(a)
      && in_range(b)
      && in_range(c)
      && in_range(d)
      && in_range(e)
      && in_range(f)
    },
  )
}

// bind
//
// The following tests exercise the shrinking behavior when using bind to 
// generate custom types.
//
//

type Either(a, b) {
  First(a)
  Second(b)
}

pub fn shrinking_works_with_bind_and_custom_types_test() {
  let assert Error(msg) = {
    use <- err.rescue
    qtest.run(
      config: qtest_config.default(),
      generator: generator.int_uniform()
        |> generator.bind(fn(n) {
          // n >= 0 here will set the shrinker starting on the `First` case, as that
          // is what 0 will become.
          case n >= 0 {
            True ->
              generator.int_uniform_inclusive(10, 19)
              |> generator.map(First)
            False ->
              generator.int_uniform_inclusive(90, 99)
              |> generator.map(int.to_float)
              |> generator.map(Second)
          }
        }),
      property: fn(either) {
        // Adding the two extra failing cases for First and Second to test the 
        // shrinking.
        case either {
          First(15) -> False
          First(14) -> False
          First(_) -> True
          Second(95.0) -> False
          Second(94.0) -> False
          Second(_) -> True
        }
      },
    )
  }
  err.shrunk_value(msg)
  |> should.equal("First(14)")
}

pub fn shrinking_works_with_bind_and_custom_types_2_test() {
  let assert Error(msg) = {
    use <- err.rescue
    qtest.run(
      config: qtest_config.default(),
      generator: generator.int_uniform()
        |> generator.bind(fn(n) {
          // n > 0 here will set the shrinker starting on the `Second` case, as that
          // is what 0 will become.
          case n > 0 {
            True ->
              generator.int_uniform_inclusive(10, 19)
              |> generator.map(First)
            False ->
              generator.int_uniform_inclusive(90, 99)
              |> generator.map(int.to_float)
              |> generator.map(Second)
          }
        }),
      property: fn(either) {
        case either {
          First(15) -> False
          First(14) -> False
          First(_) -> True
          Second(95.0) -> False
          Second(94.0) -> False
          Second(_) -> True
        }
      },
    )
  }

  err.shrunk_value(msg)
  |> should.equal("Second(94.0)")
}

pub fn shrinking_works_with_bind_and_custom_types_3_test() {
  let assert Error(msg) = {
    use <- err.rescue
    qtest.run(
      config: qtest_config.default(),
      generator: generator.int_uniform()
        |> generator.bind(fn(n) {
          case n > 0 {
            True ->
              generator.int_uniform_inclusive(10, 19)
              |> generator.map(First)
            False ->
              generator.int_uniform_inclusive(90, 99)
              |> generator.map(int.to_float)
              |> generator.map(Second)
          }
        }),
      // None of the `Second` shrinks will trigger a failure.
      property: fn(either) {
        case either {
          First(15) -> False
          First(14) -> False
          _ -> True
        }
      },
    )
  }

  err.shrunk_value(msg)
  |> should.equal("First(14)")
}

// apply
// 
// 

fn curry3(f) {
  fn(a) { fn(b) { fn(c) { f(a, b, c) } } }
}

pub fn apply__test() {
  let tuple3 =
    fn(a, b, c) { #(a, b, c) }
    |> curry3

  let generator =
    tuple3
    |> generator.return
    |> generator.apply(generator.int_uniform_inclusive(-5, 5))
    |> generator.apply(generator.int_uniform_inclusive(-10, 10))
    |> generator.apply(generator.int_uniform_inclusive(-100, 100))

  qtest.run(
    config: qtest_config.default(),
    generator: generator,
    property: fn(ns) {
      let #(a, b, c) = ns
      let a_prop = -5 <= a && a <= 5
      let b_prop = -10 <= b && b <= 10
      let c_prop = -100 <= c && c <= 100

      a_prop && b_prop && c_prop
    },
  )
}

/// TODO: consider replacing this with a `generate_tree` inspection.
pub fn shrinking_works_with_apply__test() {
  let tuple3 =
    fn(a, b, c) { #(a, b, c) }
    |> curry3

  let generator =
    tuple3
    |> generator.return
    |> generator.apply(generator.int_uniform_inclusive(-5, 5))
    |> generator.apply(generator.int_uniform_inclusive(-10, 10))
    |> generator.apply(generator.int_uniform_inclusive(-100, 100))

  let assert Error(msg) = {
    use <- err.rescue

    qtest.run(
      config: qtest_config.default(),
      generator: generator,
      property: fn(ns) {
        let #(a, b, c) = ns
        let a_prop = -5 <= a && a <= 3
        let b_prop = -10 <= b && b <= 10
        let c_prop = -100 <= c && c <= 100

        a_prop && b_prop && c_prop
      },
    )
  }
  err.shrunk_value(msg)
  |> should.equal("#(4, 0, 0)")

  let assert Error(msg) = {
    use <- err.rescue
    qtest.run(
      config: qtest_config.default(),
      generator: generator,
      property: fn(ns) {
        let #(a, b, c) = ns
        let a_prop = -3 <= a && a <= 5
        let b_prop = -10 <= b && b <= 10
        let c_prop = -100 <= c && c <= 100

        a_prop && b_prop && c_prop
      },
    )
  }
  err.shrunk_value(msg)
  |> should.equal("#(-4, 0, 0)")

  let assert Error(msg) = {
    use <- err.rescue
    qtest.run(
      config: qtest_config.default(),
      generator: generator,
      property: fn(ns) {
        let #(a, b, c) = ns
        let a_prop = -5 <= a && a <= 5
        let b_prop = -10 <= b && b <= 5
        let c_prop = -100 <= c && c <= 100

        a_prop && b_prop && c_prop
      },
    )
  }
  err.shrunk_value(msg)
  |> should.equal("#(0, 6, 0)")

  let assert Error(msg) = {
    use <- err.rescue
    qtest.run(
      config: qtest_config.default(),
      generator: generator,
      property: fn(ns) {
        let #(a, b, c) = ns
        let a_prop = -5 <= a && a <= 5
        let b_prop = -5 <= b && b <= 10
        let c_prop = -100 <= c && c <= 100

        a_prop && b_prop && c_prop
      },
    )
  }
  err.shrunk_value(msg)
  |> should.equal("#(0, -6, 0)")

  let assert Error(msg) = {
    use <- err.rescue
    qtest.run(
      config: qtest_config.default(),
      generator: generator,
      property: fn(ns) {
        let #(a, b, c) = ns
        let a_prop = -5 <= a && a <= 5
        let b_prop = -10 <= b && b <= 10
        let c_prop = -100 <= c && c <= 50

        a_prop && b_prop && c_prop
      },
    )
  }
  err.shrunk_value(msg)
  |> should.equal("#(0, 0, 51)")

  let assert Error(msg) = {
    use <- err.rescue
    qtest.run(
      config: qtest_config.default(),
      generator: generator,
      property: fn(ns) {
        let #(a, b, c) = ns
        let a_prop = -5 <= a && a <= 5
        let b_prop = -10 <= b && b <= 10
        let c_prop = -50 <= c && c <= 100

        a_prop && b_prop && c_prop
      },
    )
  }
  err.shrunk_value(msg)
  |> should.equal("#(0, 0, -51)")

  let assert Error(msg) = {
    use <- err.rescue
    qtest.run(
      config: qtest_config.default(),
      generator: generator,
      property: fn(ns) {
        let #(a, b, c) = ns
        let a_prop = -5 <= a && a <= 3
        let b_prop = -10 <= b && b <= 5
        let c_prop = -100 <= c && c <= 50

        a_prop || b_prop || c_prop
      },
    )
  }
  err.shrunk_value(msg)
  |> should.equal("#(4, 6, 51)")

  let assert Error(msg) = {
    use <- err.rescue
    qtest.run(
      config: qtest_config.default(),
      generator: generator,
      property: fn(ns) {
        let #(a, b, c) = ns
        let a_prop = -3 <= a && a <= 3
        let b_prop = -5 <= b && b <= 5
        let c_prop = -50 <= c && c <= 50

        a_prop || b_prop || c_prop
      },
    )
  }

  let parse_numbers = fn(str) {
    regex.from_string("#\\((-?\\d+), (-?\\d+), (-?\\d+)\\)")
    // Convert regex.CompileError to a String
    |> result.map_error(string.inspect)
    // Apply the regular expression
    |> result.map(regex.scan(_, str))
    // We should see only a single match
    |> result.then(fn(matches) {
      case matches {
        [match] -> Ok(match)
        _ -> Error("expected exactly one match")
      }
    })
    // Get submatches
    |> result.then(fn(match) {
      let regex.Match(_content, submatches) = match

      case submatches {
        [Some(a), Some(b), Some(c)] -> Ok(#(a, b, c))
        _ -> Error("expected exactly one submatch")
      }
    })
    // Parse to ints
    |> result.then(fn(tup) {
      let #(a, b, c) = tup

      // The way this is set up, the failing values will either be positve or 
      // negative for each "slot", so we must map the absolute value.
      case int.parse(a), int.parse(b), int.parse(c) {
        Ok(a), Ok(b), Ok(c) ->
          Ok(#(
            int.absolute_value(a),
            int.absolute_value(b),
            int.absolute_value(c),
          ))
        _, _, _ -> panic
      }
    })
  }

  let assert Ok(numbers) =
    err.shrunk_value(msg)
    |> parse_numbers

  numbers
  |> should.equal(#(4, 6, 51))
}

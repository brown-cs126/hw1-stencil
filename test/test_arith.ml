open OUnit2
open S_exp
open Hw1.Arith

(* Tests the `test_string_of_s_exp` function *)
let test_string_of_s_exp _ : unit =
  let examples = ["a"; "42"; "(+ 3 (* 4 5))"] in
  List.iter
    (fun ex ->
      assert_equal ~printer:(fun s -> s) ex (string_of_s_exp (parse ex)))
    examples

(* TODO: implement all of the test cases below. Once you're finished, remove this function *)
let todo () = failwith "todo"

(* Tests the `is_bin` function *)
let test_is_bin _ : unit = todo ()

(* Tests the `interp_bin` function *)
let test_interp_bin _ : unit = todo ()

(* Tests the `interp_instr` function *)
let test_interp_instr _ : unit = todo ()

(* Tests the `interp_program` function *)
let test_interp_program _ : unit = todo ()

(* Tests the `compile_bin` function *)
let test_compile_bin _ : unit = todo ()

(* Tests the `desugar_variadic` and `interp_variadic` functions against each other *)
let test_variadic _ : unit = todo ()

let _ =
  run_test_tt_main
    ( "arith tests"
    >::: [ "string_of_s_exp" >:: test_string_of_s_exp
         ; "is_bin" >:: test_is_bin
         ; "interp_bin" >:: test_interp_bin
         ; "interp_instr" >:: test_interp_instr
         ; "interp_program" >:: test_interp_program
         ; "compile_bin" >:: test_compile_bin
         ; "variadic" >:: test_variadic ] )

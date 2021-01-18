open OUnit2
open S_exp

let tests =
  "s_exp"
  >::: [ ( "basic parsing"
         >:: fun _ ->
         assert_equal (parse "()") (Lst []) ~printer:show ;
         assert_equal (parse "42") (Num 42) ~printer:show ;
         assert_equal (parse "a") (Sym "a") ~printer:show ;
         assert_equal (parse "(a b)") (Lst [Sym "a"; Sym "b"]) ~printer:show ;
         assert_equal ~printer:show (parse "(+ 3 (* 4 5))")
           (Lst [Sym "+"; Num 3; Lst [Sym "*"; Num 4; Num 5]]) ) ]

let _ = run_test_tt_main tests

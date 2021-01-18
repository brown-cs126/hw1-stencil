# HW 1

## Introduction

In this homework, you'll be implementing interpreters and compilers for two
languages capable of basic arithmetic:

-   `bin`: a language supporting integers and binary `+` and `*` operators.

    **Example programs:** `1260`, `(+ 1 2)`, `(* 3 4)`

-   `variadic`: a language supporting integers and variadic `+` and `*`
    operators (i.e. operators able to accept **any** number of arguments).

    **Example programs:** `(*)`, `(+ 1)`, `(* 5 6 6 7)`

## Expressions

The `S_exp` module contains types and functions for working with s-expressions.
We represent s-expressions with the `s_exp` type:

```ocaml
type s_exp = Num of int | Sym of string | Lst of t list
```

To parse an expression from a string, we provide the `parse` function:

```ocaml
parse : string -> s_exp
```

Additionally, you can produce a debugging representation of an expression with
the provided `show` function:

```ocaml
show : s_exp -> string
```

## Tasks

**Note:** all functions you must implement are defined with `let`, but you may
change any of them to `let rec` as you see fit.

### Stringifying expressions

**Task:** To get some practice working with `s_exp`s, implement the
`string_of_s_exp` function, which should produce the string representation of
the expression it is given.

### Bin

As described above, `bin` is a language that supports integers and binary `+`
and `*` operators.

**Task:** Implement the function `is_bin` that determines whether or not an
`s_exp` is valid in `bin`.

To get a value out of a `bin` expression, we'll explore two options:

-   Directly _interpret_ the expression, performing the arithmetic operations as
    we go, to produce a value. For example, we would interpret `(+ 1 2)` in
    OCaml as `1 + 2`, which produces `3`.
-   _Compile_ the expression into a lower-level sequence of instructions, which
    can then be evaluated to produce a value.

**Task:** Implement the function `interp_bin` that takes the first approach to
evaluate expressions. If an expression cannot be evaluated, raise the `Stuck`
exception.

Compiling expressions to instructions requires a definition of "instruction".
We'll use this one:

```ocaml
type instr = Push of int | Add | Mul
```

A `Push` instruction takes an integer and _pushes_ it onto a _stack_, a list of
integers that serves as the working memory of whatever is evaluating the
instructions. Instructions that operate on arguments (in this case `Add` and
`Mul`, which each require two arguments), _pop_ them from the stack as needed.
Stacks are last-in-first-out, meaning that a pop will remove the value
most-recently added to the stack. For convenience, a `stack` type is defined as
an alias for `int list`.

**Task:** Implement the function `interp_instr`, which interprets an instruction
in the context of a stack to producing an updated stack, and the function
`interp_program` that interprets a list of instructions, producing the resulting
value (which will be the last value pushed to the stack).

_Note:_ Raise the `ShortStack` exception if there aren't enough arguments on the
stack to perform an instruction.

**Task:** Implement the function `compile_bin` that compiles an expression into
a list of instructions.

### Variadic

The `variadic` language adds support for variadic `+` and `*` operators. That
is, both operators will be callable with **any** number of arguments. There are
two main ways to go about adding this support:

-   Extend the interpreter and compiler of the simpler language to support the
    new features.
-   Translate expressions in the extended language into ones that are valid in
    the simpler one, then use the interpreter and compiler of the simpler
    language.

    **Example:** `(+ 1 2 3)` translates to `(+ 1 (+ 2 3))`.

    **Note:** This approach, which is called _desugaring_ (since it takes a
    sweet/appealing syntax and translates it to an equivalent, often less
    appealing one), is only possible if the simpler language is capable of
    expressing the same functionality as the extended one. For instance, we
    couldn't desugar a division operator into the `bin` language, since no
    combination of addition and multiplication will achieve the same result.

**Task:** Implement the function `desugar_variadic` that takes a `variadic`
expression and translates it into the `bin` language.

-**Hint:** Note that `variadic` supports zero or one arguments for `+` and `*`.
You may assume that any missing arguments may default to the identity elements
`0` and `1`, respectively. For example `(* 4)` should evaluate to `4` and `(+)`
should evaluate to `0`.

**Task:** Implement the function `interp_variadic` that directly interprets a
`variadic` expression (i.e. without relying on `desugar_variadic`).

### Testing

In `test/test_arith.ml`, test the funtions you just implemented. To test
`variadic`, compare the desugaring and direct interpreting approaches against
each other on a variety of different inputs. For an example of this type of
testing, look at the test we've provided for `string_of_s_exp`.

Two testing provided testing forms you might find useful are `assert_equal` and
`assert_raises`. Here is an example of their usage:

```ocaml
(* Asserts that the two arguments must be equal *)
assert_equal (1 + 2) 3

(* Asserts that the exception specified in the first argument will
be raised by running the second argument (a thunk) *)
assert_raises Division_by_zero (fun -> 1 / 0)
```

Additionally, `assert_equal` takes an optional `printer` parameter that
specifies how to print the arguments if the test fails. Example usage is as
follows:

```ocaml
(* Without printer argument *)
assert_equal 10 15
(* Results in "Failure: not equal" *)

(* With printer argument *)
assert_equal ~printer:string_of_int 10 15
(* Results in "Failure: expected: 10 but got: 15" *)
```

## Useful commands

`dune build` builds everything.

`dune runtest -f` runs the tests in the `test/` directory.

`dune utop` runs a toplevel. You can access the functions you're developing for
this homework by running, e.g.,

```shell
# dune utop
utop> open Hw1.Arith;;
utop> string_of_s_exp "42";;
Num 42
```

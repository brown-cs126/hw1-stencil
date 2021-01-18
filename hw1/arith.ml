open S_exp

(* TODO: implement all of the functions below. Once you're finished, remove this function *)
let todo () = failwith "todo"

(** [string_of_s_exp exp] is the string representation of [exp] **)
let string_of_s_exp (exp : s_exp) : string = todo ()

(** [Stuck exp] represents an expression that cannot be interpreted or compiled
 *  on its own **)
exception Stuck of s_exp

(** [is_bin exp] determines whether [exp] is a valid expression in `bin` **)
let is_bin (exp : s_exp) : bool = todo ()

(** [interp_bin exp] is the result of interpreting the `bin` expression [exp] **)
let interp_bin (exp : s_exp) : int = todo ()

(** [instr] represents an instruction **)
type instr = Push of int | Add | Mul

(** [stack] represents a stack of integers **)
type stack = int list

(** [ShortStack stack] signals that [stack] was expected to contain more values
 *  than it actually does**)
exception ShortStack of stack

(** [interp_instr stack instr] is the result of interpreting the instruction [instr]
 *  in the context of the stack [stack] **)
let interp_instr (stack : stack) (instr : instr) : stack = todo ()

(** [interp_program instrs] is the result of interpreting a list of [instrs] **)
let interp_program (instrs : instr list) : int = todo ()

(** [compile_bin exp] compiles a `bin` expression into a list of instructions **)
let compile_bin (exp : s_exp) : instr list = todo ()

(** [desugar_variadic exp] transforms the `variadic` expression [exp] into one
 *  that is valid in `bin` **)
let desugar_variadic (exp : s_exp) : s_exp = todo ()

(** [interp_variadic exp] is the result of interpreting the `variadic` expression [exp].
 *  Note: interpret the expression directly (without relying on `desugar_variadic`) **)
let interp_variadic (exp : s_exp) : int = todo ()

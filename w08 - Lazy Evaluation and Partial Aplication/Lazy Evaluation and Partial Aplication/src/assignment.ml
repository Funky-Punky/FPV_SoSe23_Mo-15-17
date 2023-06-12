(* Type Unit *)

type my_unit = Value

(* Lazy Evaluation *)

let ladd a b () = a + b
let lfive = ladd 2 3
let five = lfive ()

type 'a llist =
  | Cons of 'a * (unit -> 'a llist)

let rec fives = Cons (5, fun () -> fives)

let rec lmap func (Cons (a, f)) =
  Cons (func a, fun () -> lmap func (f ()))

let sixes = lmap (fun x -> x + 1) fives

(* Partial Application *)

(* a -> b -> c -> d *)
let func a b c = a b :: c

(* a -> (b -> (c -> d)) *)

(*
   let func2 =
      fun a ->
        fun b ->
          fun c ->
            a b :: c
*)

(* a -> b -> c ->  d -> e *)
(* a -> b -> c -> (d -> e) *)

let plus_five = (fun x -> x + 5)
let plus_fivedd a = (fun x y -> x + y) 5 a

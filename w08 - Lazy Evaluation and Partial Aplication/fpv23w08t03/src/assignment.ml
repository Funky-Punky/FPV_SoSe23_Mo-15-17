let a : 'a -> int -> int -> int = (fun a b -> (+) b) 
    (* fun a b i1 -> b + i1 *)

let b : int list -> (int -> (int -> int) -> int) -> int
    = (fun a b -> List.fold_left b 1 (List.map ( * ) a))
    (* fun a b -> List.fold_left b 1 (List.map ( * ) a ) *)

let c : int -> (int -> 'a) -> 'a = (fun a b c -> c (a + b)) 3 
    (* fun b c -> c (3 + b) *)

let d : ('a -> string) -> (string -> 'a) -> string list
    = (fun a b c -> b (c a) :: [a]) "x" 
    (* fun b c -> [b (c "x"); "x"] *)

let e : 'a list -> ('a -> bool) list = (let x = List.map in x (<))
    (* fun l -> List.map (<) l *)
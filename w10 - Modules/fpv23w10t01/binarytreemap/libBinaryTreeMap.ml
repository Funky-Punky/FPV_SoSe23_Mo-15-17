open LibPrintable
open LibOrderedPrintable
open LibMap

(* module BinaryTreeMap (K : OrderedPrintable) (V : Printable) : Map = struct
     type key = K.t
     type value = V.t
     type t = Leaf | Node of t * (key * value) * t

     let empty = failwith ""
     let rec set key value map = failwith ""
     let rec get_opt key map = failwith ""
     let get key map = failwith ""
     let rec to_list map = failwith ""
     let to_string map = failwith ""
   end *)

type ('k, 'v) tree = Leaf | Node of ('k, 'v) tree * ('k * 'v) * ('k, 'v) tree

module BinaryTreeMap (K : OrderedPrintable) (V : Printable) :
  Map with type key = K.t and type value = V.t
and type t = (K.t, V.t) tree   = struct
  type key = K.t
  type value = V.t
  type t = (key, value) tree

  let empty = Leaf

  let rec set key value map =
    match map with
    | Leaf -> Node (Leaf, (key, value), Leaf)
    | Node (l, (k, v), r) ->
        let cmp_val = K.compare key k in
        if cmp_val < 0 then Node (set key value l, (k, v), r)
        else if cmp_val > 0 then Node (l, (k, v), set key value r)
        else Node (l, (key, value), r)

  let rec get_opt key map =
    match map with
    | Leaf -> None
    | Node (l, (k, v), r) ->
        let cmp_val = K.compare key k in
        if cmp_val < 0 then get_opt key l
        else if cmp_val > 0 then get_opt key r
        else Some v

  let get key map =
    match get_opt key map with None -> raise Not_found | Some value -> value

  let rec to_list map =
    match map with Leaf -> [] | Node (l, a, r) -> to_list l @ (a :: to_list r)

  let to_string map =
    "{"
    ^ (to_list map
      |> List.map (fun (k, v) -> K.to_string k ^ " -> " ^ V.to_string v)
      |> String.concat ", ")
    ^ "}"
end

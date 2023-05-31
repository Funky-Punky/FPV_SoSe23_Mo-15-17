type direction = Left | Right | Up | Down
type route = direction list

let rec contains_down route =
  match route with
  | [] -> false
  | Down :: _ -> true
  | _ :: route' -> contains_down route'

(*






*)

type student = {
  first_name : string;
  last_name : string;
  id : int;
  semester : int;
  grades : (int * float) list;
}

type 'a option = None | Some of 'a

let exists x = if x = None then false else true

let rec find_by_id id db =
  match db with
  | [] -> None
  | student :: db' ->
      if student.id = id then Some student else find_by_id id db'

(*





*)

type my_list = Empty | Element of int * my_list

let one_two_five = Element (1, Element (2, Element (5, Empty)))
let insert new_element list = Element (new_element, list)

let rec insert_sorted new_element list =
  match list with
  | Empty -> Element (new_element, Empty)
  | Element (v, list') ->
      if new_element > v then Element (v, insert_sorted new_element list')
      else Element (new_element, list)

(* 
   















*)
type vector3 = float * float * float

let p1 = (0., 1., 2.)
let p2 = (-10., -20., -30.)
let p3 = (123.456, 654.321, 0.00001)

let string_of_vector3 (x, y, z) =
  "(" ^ string_of_float x ^ "," ^ string_of_float y ^ "," ^ string_of_float z
  ^ ")"

let vector3_add a b =
  let (a, b, c), (x, y, z) = (a, b) in
  (a +. x, b + y, c +. z)

let vector3_max v1 v2 =
  match (v1, v2) with
  | (a, b, c), (x, y, z) ->
      if (a *. a) +. (b *. b) +. (c *. c) > (x *. x) +. (y *. y) +. (z *. z)
      then (a, b, c)
      else (x, y, z)

let combine a b c = string_of_vector3 (vector3_add a (vector3_max b c))

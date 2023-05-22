type vector3 = float * float * float

let p1 = (1., 2., 3.)
let p2 = (0., -1., -1.) (* TODO: change *)
let p3 = (100., 1000., 1000.) (* TODO: change *)

let string_of_vector3 (a, b, c) =
  "(" ^ string_of_float a ^ "," ^ string_of_float b ^ "," ^ string_of_float c
  ^ ")"

let vector3_add (a, b, c) (x, y, z) = (a +. x, b +. y, c +. z)

let vector3_max (a, b, c) (x, y, z) =
  let len1 = (a *. a) +. (b *. b) +. (c *. c) in
  let len2 = (x *. x) +. (y *. y) +. (z *. z) in
  if len1 > len2 then (a, b, c) else (x, y, z)

let combine a b c = vector3_max b c |> vector3_add a |> string_of_vector3 

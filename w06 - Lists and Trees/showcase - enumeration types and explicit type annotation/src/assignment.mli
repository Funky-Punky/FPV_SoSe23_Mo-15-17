type direction = Left | Right | Up | Down
type route = direction list

val contains_down : route -> bool

type student = {
  first_name : string;
  last_name : string;
  id : int;
  semester : int;
  grades : (int * float) list;
}

type 'a option = None | Some of 'a

val find_by_id : int -> student list -> student option
val exists : 'a option -> bool

type my_list = Empty | Element of int * my_list

val one_two_five : my_list
val insert : int -> my_list -> my_list
val insert_sorted : int -> my_list -> my_list

type 'a llist =
  | Cons of 'a * (unit -> 'a llist)

val lnat : int -> int llist
val lfib : unit -> int llist
val ltake : int -> 'a llist -> 'a list

val lfilter :
  ('a -> bool) -> 'a llist -> 'a llist

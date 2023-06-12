val short_list : int list
val long_list : int list
val create_list : int -> int list
val fac : int -> int
val remove : 'a -> 'a list -> 'a list

val partition :
  ('a -> bool) ->
  'a list ->
  'a list * 'a list

val fac_before : int -> int
val remove_before : 'a -> 'a list -> 'a list

val partition_before :
  ('a -> bool) ->
  'a list ->
  'a list * 'a list

val fac_fl : int -> int
val remove_fl : 'a -> 'a list -> 'a list

val partition_fl :
  ('a -> bool) ->
  'a list ->
  'a list * 'a list

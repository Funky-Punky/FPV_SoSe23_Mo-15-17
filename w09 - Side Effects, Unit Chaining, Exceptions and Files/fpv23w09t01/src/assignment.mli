type student = {
  first_name : string;
  last_name : string;
  id : int;
  semester : int;
  grades : (int * float) list;
}

type database = student list

exception Corrupt_database_file
exception My_Corrupt_database_file of string

val store_db : string -> database -> unit

val load_db : string -> database

val mini_tum : database
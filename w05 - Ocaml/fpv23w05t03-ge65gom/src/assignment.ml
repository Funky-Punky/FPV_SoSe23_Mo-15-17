type student = {
  first_name : string;
  last_name : string;
  id : int;
  semester : int;
  grades : (int * float) list;
}

type database = student list

let insert s db = s :: db

let rec find_by_id id db =
  match db with
  | [] -> []
  | student :: db_rest ->
      if student.id = id then [ student ] else find_by_id id db_rest

let rec find_by_last_name name db =
  match db with
  | [] -> []
  | student :: db_rest ->
      if student.last_name = name then student :: find_by_last_name name db_rest
      else find_by_last_name name db_rest

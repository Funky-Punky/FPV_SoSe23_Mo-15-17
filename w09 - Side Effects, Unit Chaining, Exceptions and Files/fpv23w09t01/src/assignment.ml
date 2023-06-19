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

(*
--------------------------------------------------------------------------------
                         _   _     _
      __      __  _ __  (_) | |_  (_)  _ __     __ _
      \ \ /\ / / | '__| | | | __| | | | '_ \   / _` |
       \ V  V /  | |    | | | |_  | | | | | | | (_| |
        \_/\_/   |_|    |_|  \__| |_| |_| |_|  \__, |
                                               |___/
--------------------------------------------------------------------------------
*)

let string_of_student student =
  student.first_name ^ ";" ^ student.last_name ^ ";"
  ^ string_of_int student.id
  ^ ";"
  ^ string_of_int student.semester
  ^ ";"
  ^ (List.length student.grades |> string_of_int)
  ^ "\n"
  ^ (List.map
       (fun (c_id, grade) ->
         string_of_int c_id ^ ";" ^ string_of_float grade ^ "\n")
       student.grades
    |> String.concat "")

let write_db_to_chan chan db =
  (* List.map string_of_student db |> List.iter (output_string chan) *)
  List.iter (output_string chan) (List.map string_of_student db)

let store_db filename db =
  let out_chan = open_out filename in
  try
    write_db_to_chan out_chan db;
    close_out out_chan
  with ex ->
    close_out out_chan;
    raise ex

(*
--------------------------------------------------------------------------------
                               _   _
     _ __    ___    __ _    __| | (_)  _ __     __ _
    | '__|  / _ \  / _` |  / _` | | | | '_ \   / _` |
    | |    |  __/ | (_| | | (_| | | | | | | | | (_| |
    |_|     \___|  \__,_|  \__,_| |_| |_| |_|  \__, |
                                               |___/
--------------------------------------------------------------------------------
*)

let rec read_grades_from_chan chan grade_count =
  if grade_count <= 0 then []
  else
    try
      let line = input_line chan in
      match String.split_on_char ';' line with
      | [ course_id_str; grade_str ] ->
          (int_of_string course_id_str, float_of_string grade_str)
          :: read_grades_from_chan chan (grade_count - 1)
      | _ ->
          raise
            (My_Corrupt_database_file
               "grade has wrong number of arguments")
    with
    | End_of_file ->
        raise (My_Corrupt_database_file "missing grade")
    | Failure _ ->
        raise
          (My_Corrupt_database_file "incompatible types in grade")

let read_student_from_chan chan =
  try
    let first_line = input_line chan in
    match String.split_on_char ';' first_line with
    | [
     first_name; last_name; id_str; semester_str; grade_count_str;
    ] ->
        let id = int_of_string id_str in
        let semester = int_of_string semester_str in
        let grade_count = int_of_string grade_count_str in
        let grades = read_grades_from_chan chan grade_count in
        Some { first_name; last_name; id; semester; grades }
    | _ ->
        raise
          (My_Corrupt_database_file
             "student line has wrong number of parameters")
  with
  | End_of_file -> None
  | Failure _ ->
      raise (My_Corrupt_database_file "Wrong type of arguments")

let rec read_db_from_chan chan =
  match read_student_from_chan chan with
  | None -> []
  | Some s -> s :: read_db_from_chan chan

let load_db_my filename =
  let in_chan = open_in_bin filename in
  try
    let db = read_db_from_chan in_chan in
    close_in in_chan;
    db
  with ex ->
    close_in in_chan;
    raise ex

let load_db filename =
  try load_db_my filename
  with My_Corrupt_database_file _ ->
    raise Corrupt_database_file

(*
--------------------------------------------------------------------------------
    _                  _     _
   | |_    ___   ___  | |_  (_)  _ __     __ _
   | __|  / _ \ / __| | __| | | | '_ \   / _` |
   | |_  |  __/ \__ \ | |_  | | | | | | | (_| |
    \__|  \___| |___/  \__| |_| |_| |_|  \__, |
                                         |___/
--------------------------------------------------------------------------------
*)
let student_jonas =
  {
    first_name = "Jonas";
    last_name = "Reinstaedtler";
    id = 03742644;
    semester = 4;
    grades = [ (1, 2.3); (2, 5.0); (3, 1.2) ];
  }

let student_max =
  {
    first_name = "Max";
    last_name = "Musterman";
    id = 123456789;
    semester = 3;
    grades = [ (1, 3.0); (2, 2.0); (3, 3.7) ];
  }

let student_frida =
  {
    first_name = "Frida";
    last_name = "Musterman";
    id = 111111111;
    semester = 3;
    grades = [ (1, 3.0); (2, 2.0); (3, 3.7) ];
  }

let mini_tum = [ student_jonas; student_max; student_frida ]

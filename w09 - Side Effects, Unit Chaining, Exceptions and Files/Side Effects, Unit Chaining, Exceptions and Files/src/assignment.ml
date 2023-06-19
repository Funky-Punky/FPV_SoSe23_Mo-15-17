(* Side Effects *)

let (), () =
  let x = print_endline "foo" in
  (x, x)

let (), () =
  let x () = print_endline "foo" in
  (x (), x ())

(*
     1. What are side-effects? Give some examples.
     2. What are pure functions? What are their benefits?
     3. Why does delaying evaluation only make sense in case of side-effects or in presence of non-terminating expressions?
     4. Why do we want to use () instead of some unused variable or the discard _?
*)

(* Error handling *)

exception My_Exn
exception Pw_exn of string




let check_password pwd =
  if String.length pwd < 8 then raise (Pw_exn "password to short")
  else if String.contains pwd ' ' then
    raise (Pw_exn "password cant contain a space")
  else if pwd = "1234" then
    raise (Pw_exn "the password cant be the same, as your TumOnline password")
  else ()





let divide a b = 
try 
  a / b 
with Division_by_zero -> -1




let failwith msg = raise (Failure msg)



(* Unit Chaining *)

let talkative_add a b =
  print_endline "Hi, my Name is Addy";
  print_endline "I will be your Number One Adder Tonight";
  print_endline "Here Goes:";
  let sum = a + b in
  print_endline "That wasnt to bad :)";
  print_endline "Bon Appétit:";
  sum



let () = List.iter (fun x -> print_endline (string_of_int x)) [ 1; 2; 3; 4 ]




(* Jonas' File Handling API *)

(*
  often used Functions (Documentation can be found at https://v2.ocaml.org/api/Stdlib.html)

  Types:
    type in_channel
    type out_channel

  Channel Management:
    open_in : string -> in_channel      (filename)
    open_out : string -> out_channel
    flush : out_channel -> unit

    close_in : in_channel -> unit
    close_out : out_channel -> unit


  Writing:
    output_string : out_channel -> string -> unit

  Reading:
    input_line : in_channel -> string
    String.split_on_char : char -> string -> string list

*)

(* Writing Integer Lists *)

let write_int_list_to_channel channel list =
  List.iter (fun x -> output_string channel (string_of_int x ^ "\n")) list


let store_int_list filename list =
  let channel = open_out filename in
  try
    write_int_list_to_channel channel list;
    close_out channel
  with exxxx ->
    close_out channel;
    raise exxxx




(* Reading Integer Lists *)

let rec read_int_list_from_channel channel =
  try
    let i = int_of_string (input_line channel) in
    i :: read_int_list_from_channel channel
  with
  | End_of_file -> []
  | Failure _ -> failwith "Die Liste darf nur Integer Werte enthalten"


let load_int_list filename =
  let channel = open_in filename in
  try
    let db = read_int_list_from_channel channel in
    close_in channel;
    db
  with ex ->
    close_in channel;
    raise ex

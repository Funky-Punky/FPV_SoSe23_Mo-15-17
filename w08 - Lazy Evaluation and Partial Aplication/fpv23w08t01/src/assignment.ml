(* Write tail recursive versions of the following functions (without changing their types) *)

let rec create_list_help acc n =
  if n < 0 then acc
  else create_list_help (n :: acc) (n - 1)

let create_list n = create_list_help [] n
let long_list = create_list 10_000
let short_list = [ 0; 1; 2; 3; 4; 5 ]

(* 
   


*)
let rec fac_before n =
  if n = 0 then 1 else n * fac_before (n - 1)

let rec remove_before a l =
  match l with
  | [] -> []
  | x :: xs ->
      if x = a then remove_before a xs
      else x :: remove_before a xs

let rec partition_before p l =
  match l with
  | [] -> ([], [])
  | x :: xs ->
      let a, b = partition_before p xs in
      if p x then (x :: a, b) else (a, x :: b)

(* 
   

*)

let rec fac_help acc n =
  if n = 0 then acc
  else fac_help (acc * n) (n - 1)

let fac n = fac_help 1 n





let rec remove_help a l acc =
  match l with
  | [] -> acc
  | x :: xs ->
      if x = a then remove_help a xs acc
      else remove_help a xs (x :: acc)

let remove a l = List.rev (remove_help a l [])




let rec partition_help (accp, accnp) p l =
  match l with
  | [] -> (accp, accnp)
  | x :: xs ->
      if p x then
        partition_help
          (x :: accp, accnp)
          p xs
      else
        partition_help
          (accp, x :: accnp)
          p xs

let partition p l =
  let p, np = partition_help ([], []) p l in
  (List.rev p, List.rev np)

(* 
   




























*)
(* let rec fac_help acc n =
     if n = 0 then acc
     else fac_help (acc * n) (n - 1)

   let fac n = fac_help 1 n

   let rec remove_help acc a l =
     match l with
     | [] -> acc
     | x :: xs ->
         if x = a then remove_help acc a xs
         else remove_help (x :: acc) a xs

   let remove a l =
     List.rev (remove_help [] a l)

   let rec partition_help (accp, accnp) p l =
     match l with
     | [] -> (accp, accnp)
     | x :: xs ->
         if p x then
           partition_help
             (x :: accp, accnp)
             p xs
         else
           partition_help
             (accp, x :: accnp)
             p xs

   let partition p l =
     let p, np = partition_help ([], []) p l in
     (List.rev p, List.rev np)*)

(* 
   







*)
let fac_fl n =
  List.fold_left ( * ) 1
    (List.init n (( + ) 1))

let remove_fl a l =
  List.rev
    (List.fold_left
       (fun acc x ->
         if a = x then acc else x :: acc)
       [] l)

let partition_fl p l =
  let p, np =
    List.fold_left
      (fun (accp, accnp) x ->
        if p x then (x :: accp, accnp)
        else (accp, x :: accnp))
      ([], []) l
  in
  (List.rev p, List.rev np)

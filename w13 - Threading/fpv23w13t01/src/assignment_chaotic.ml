open Thread
open Event

let rec count n =
  if n <= 0 then ()
  else (
    print_endline
      ("Number: " ^ string_of_int n ^ ", Thread: "
      ^ string_of_int (Thread.id (Thread.self ())));
    count (n - 1))

let spawn_counter n = Thread.create count n

let run_counters m n =
  let threads = List.init m (fun _ -> spawn_counter n) in
  List.iter join threads

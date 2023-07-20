open Thread
open Event

let rec count (n, chan) =
  if n <= 0 then ()
  else (
    sync (receive chan);
    print_endline
      ("Number: " ^ string_of_int n ^ ", Thread: "
      ^ string_of_int (Thread.id (Thread.self ())));
    sync (send chan ());
    count (n - 1, chan))

let spawn_counter n chan = Thread.create count (n, chan)

let rec run_counters_aux channels n =
  if n <= 0 then ()
  else (
    List.iter (fun chan -> sync (send chan ())) channels;
    List.iter (fun chan -> sync (receive chan)) channels;
    (* List.iter
       (fun chan ->
         sync (send chan ());
         sync (receive chan))
       channels; *)
    run_counters_aux channels (n - 1))

let run_counters m n =
  let channels = List.init m (fun _ -> Event.new_channel ()) in
  let threads = List.map (fun chan -> spawn_counter n chan) channels in
  run_counters_aux channels n;
  List.iter (fun thr -> Thread.join thr) threads

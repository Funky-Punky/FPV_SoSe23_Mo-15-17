open Thread
open Event

(*
   Threads:

   type t

   Thread.create : ('a -> 'b) -> 'a -> t
   Thread.join : t -> unit
   Thread.self : unit -> t
   Thread.id : t -> int



   Channel:

   Event.new_channel : unit -> 'a channel

   sync(send <chan> <val>) : unit
   sync(recieve <chan>) : 'a
*)

(* Thread-Safe Server *)

type request = Req1 of int | Req2

let start_server () =
  let channel = Event.new_channel () in
  let rec help thread_state =
    failwith "Recieve from channel and handle request - then recursion"
  in
  let _ = Thread.create help [] in
  channel

let req1 chan arg = sync (send chan (Req1 arg))

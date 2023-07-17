open Thread
open Event

type ('k, 'v) request = Put of ('k * 'v) | Get of ('k * 'v option channel)

let start_server () =
  let channel = Event.new_channel () in
  let rec help assoq_list =
    match sync (receive channel) with
    | Put (key, value) -> help ((key, value) :: assoq_list)
    | Get (key, ret_chan) ->
        sync (send ret_chan (List.assoc_opt key assoq_list));
        help assoq_list
  in
  let _ = Thread.create help [] in
  channel

let put map key value = 
  sync (send map (Put(key, value)))


let get_opt map key = 
  let chan = Event.new_channel () in
  sync(send map (Get (key, chan)));
  sync(receive chan)






(* let create_Map () =
     let channel = Event.new_channel () in
     let rec help list =
       match sync (receive channel) with
       | Put (key, value) -> help ((key, value) :: List.remove_assoc key list)
       | Get (key, retchan) ->
           sync (send retchan (List.assoc_opt key list));
           help list
     in

     let _ = Thread.create help [] in
     channel

   let put map key value = sync (send map (Put (key, value)))

   let get map key =
     let chan = new_channel () in
     sync (send map (Get (key, chan)));
     sync (receive chan) *)

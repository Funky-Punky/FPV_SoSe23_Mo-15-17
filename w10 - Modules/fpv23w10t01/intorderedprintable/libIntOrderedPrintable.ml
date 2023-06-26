open LibOrderedPrintable

module IntOrderedPrintable : OrderedPrintable with type t = int = struct
  type t = int

  let to_string = string_of_int
  let compare a b = if a < b then -1 else if a = b then 0 else 1
end

(* module IntOrderedPrintable : OrderedPrintable with type t = int = struct
     type t = int

     let to_string = string_of_int
     let compare a b = if a < b then -1 else if a > b then 1 else 0
   end *)

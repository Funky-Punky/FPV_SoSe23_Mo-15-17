open LibPrintable

module StringPrintable : Printable with type t = string = struct
  type t = string

  let to_string s = "\"" ^ s ^ "\""
end











(*


module StringPrintable : Printable with type t = string = struct
  type t = string

  let to_string s = "\"" ^ s ^ "\""
end *)

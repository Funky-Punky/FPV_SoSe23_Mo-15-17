(*


module type Module = sig
  val foo : int -> int
  type t
end

<==>

interface Module {
  int foo(int i);
} 


*)

(*
   module type Module = sig
     include Bar
   end

   <==>

   interface Module implements Bar {
   }
*)

(*
   module Foo : Bar = struct
    type t = int
   end

   <==>

   class Foo implements Bar {

   }
*)
(*
   module Foo(F : Bar) = struct
   end

   <==>

   class Foo<F extends Bar>{

   }
*)

(*
   Complicated Example:

   module ComparingCollection
    (E : Comparable) : Collection
   with type entry = E.t =
   struct

   end
*)

module type Bar = sig
  type t

  val foo : t -> t
end

module ImplementsBar : Bar with type t = int = struct
  type t = int

  let foo x = 2 * x
end

module type Module = sig
  include Bar
end

module FooFoo (B : Bar) = struct end
module FooBar = FooFoo (ImplementsBar)

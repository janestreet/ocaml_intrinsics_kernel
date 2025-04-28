open Base
open Stdio

module type Hum = sig
  type t

  val to_string_hum : ?delimiter:char -> t -> string
end

module Hum_string (H : Hum) = struct
  include H

  let to_string = to_string_hum
end

let test
  (type i o)
  (module Input : Hum with type t = i)
  (module Output : Stringable.S with type t = o)
  ~name
  ~op
  x
  =
  let module Input = Hum_string (Input) in
  print_endline [%string "%{name} %{x#Input} = %{op x#Output}"]
;;

let test_shifts
  (type t)
  (module Input : Hum with type t = t)
  (module Shift : Hum with type t = t)
  ~name
  ~(op : t -> t -> t)
  ~(expected_op : t -> t -> t)
  x
  y
  =
  let module Input = Hum_string (Input) in
  let module Shift = Hum_string (Shift) in
  let expected = expected_op x y in
  let res = op x y in
  print_endline [%string "%{x#Input} %{name} by %{y#Shift} ="];
  print_endline [%string "%{res#Input}"];
  if Stdlib.compare res expected <> 0
  then print_endline [%string "%{expected#Input} expected"]
;;

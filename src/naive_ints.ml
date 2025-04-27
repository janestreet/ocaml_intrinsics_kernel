module type Intlike = sig @@ portable
  type t : immutable_data

  val logand : local_ t -> local_ t -> local_ t
  val zero : t
  val one : t
  val equal : local_ t -> local_ t -> bool
  val compare : local_ t -> local_ t -> int
  val shift_right : local_ t -> int -> local_ t
  val shift_right_logical : local_ t -> int -> local_ t
  val shift_left : local_ t -> int -> local_ t
  val bitwidth : t
  val to_int : local_ t -> int
  val of_int : int -> t
end

module type S = sig @@ portable
  type t : immutable_data

  (** See documentation of [Int]. *)
  val count_leading_zeros : local_ t -> t

  val count_set_bits : local_ t -> t
  val count_trailing_zeros : local_ t -> t
  val shift_left : local_ t -> local_ t -> local_ t
  val shift_right : local_ t -> local_ t -> local_ t
  val shift_right_logical : local_ t -> local_ t -> local_ t
end

module Make (Int : Intlike) : S with type t = Int.t = struct
  type t = Int.t

  let least_significant_bit n = exclave_ Int.logand n Int.one

  let is_least_significant_bit_set n =
    let lsb = least_significant_bit n in
    if Int.equal lsb Int.one
    then true
    else if Int.equal lsb Int.zero
    then false
    else assert false
  ;;

  let is_most_significant_bit_set n = if Int.compare n Int.zero < 0 then true else false

  let count_trailing_zeros n =
    let rec loop ~acc ~mask = exclave_
      if is_least_significant_bit_set mask
      then acc
      else (
        let mask = Int.shift_right_logical mask 1 in
        let acc = acc + 1 in
        loop ~mask ~acc)
    in
    if Int.equal n Int.zero then Int.bitwidth else loop ~acc:0 ~mask:n |> Int.of_int
  ;;

  let count_leading_zeros n =
    let rec loop ~acc ~mask = exclave_
      if is_most_significant_bit_set mask
      then acc
      else (
        let mask = Int.shift_left mask 1 in
        let acc = acc + 1 in
        loop ~mask ~acc)
    in
    if Int.equal n Int.zero then Int.bitwidth else loop ~acc:0 ~mask:n |> Int.of_int
  ;;

  let count_set_bits n =
    let rec loop ~acc ~mask = exclave_
      if Int.equal mask Int.zero
      then acc
      else (
        let acc = if is_least_significant_bit_set mask then acc + 1 else acc in
        let mask = Int.shift_right_logical mask 1 in
        loop ~mask ~acc)
    in
    loop ~acc:0 ~mask:n |> Int.of_int
  ;;

  let shift_mask = (Int.bitwidth |> Int.to_int) - 1 |> Int.of_int
  let to_int_shift y = exclave_ Int.logand y shift_mask |> Int.to_int
  let shift_left x y = exclave_ Int.shift_left x (to_int_shift y)
  let shift_right x y = exclave_ Int.shift_right x (to_int_shift y)
  let shift_right_logical x y = exclave_ Int.shift_right_logical x (to_int_shift y)
end

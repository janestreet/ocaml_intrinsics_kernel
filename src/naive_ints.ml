module type Intlike = sig
  type t

  val logand : t -> t -> t
  val zero : t
  val one : t
  val equal : t -> t -> bool
  val compare : t -> t -> int
  val shift_right : t -> int -> t
  val shift_right_logical : t -> int -> t
  val shift_left : t -> int -> t
  val bitwidth : t
  val to_int : t -> int
  val of_int : int -> t
end

module type S = sig
  type t

  (** See documentation of [Int]. *)
  val count_leading_zeros : t -> t

  val count_set_bits : t -> t
  val count_trailing_zeros : t -> t
  val shift_left : t -> t -> t
  val shift_right : t -> t -> t
  val shift_right_logical : t -> t -> t
end

module Make (Int : Intlike) : S with type t = Int.t = struct
  type t = Int.t

  let least_significant_bit n = Int.logand n Int.one

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
    let rec loop ~acc ~mask =
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
    let rec loop ~acc ~mask =
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
    let rec loop ~acc ~mask =
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
  let to_int_shift y = Int.logand y shift_mask |> Int.to_int
  let shift_left x y = Int.shift_left x (to_int_shift y)
  let shift_right x y = Int.shift_right x (to_int_shift y)
  let shift_right_logical x y = Int.shift_right_logical x (to_int_shift y)
end

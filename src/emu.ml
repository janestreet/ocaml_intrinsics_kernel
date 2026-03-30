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

module Make (I : Intlike) : S with type t = I.t = struct
  type t = I.t

  let[@inline] least_significant_bit n = I.logand n I.one

  let[@inline] is_least_significant_bit_set n =
    let lsb = least_significant_bit n in
    I.equal lsb I.one [@nontail]
  ;;

  let[@inline] is_most_significant_bit_set n = I.compare n I.zero < 0

  let count_trailing_zeros n =
    let[@inline] [@loop] rec loop ~acc ~mask =
      if is_least_significant_bit_set mask
      then acc
      else (
        let mask = I.shift_right_logical mask 1 in
        let acc = acc + 1 in
        loop ~mask ~acc)
    in
    if I.equal n I.zero then I.bitwidth else loop ~acc:0 ~mask:n |> I.of_int
  ;;

  let count_leading_zeros n =
    let[@inline] [@loop] rec loop ~acc ~mask =
      if is_most_significant_bit_set mask
      then acc
      else (
        let mask = I.shift_left mask 1 in
        let acc = acc + 1 in
        loop ~mask ~acc)
    in
    if I.equal n I.zero then I.bitwidth else loop ~acc:0 ~mask:n |> I.of_int
  ;;

  let count_set_bits n =
    let[@inline] [@loop] rec loop ~acc ~mask =
      if I.equal mask I.zero
      then acc
      else (
        let acc = if is_least_significant_bit_set mask then acc + 1 else acc in
        let mask = I.shift_right_logical mask 1 in
        loop ~mask ~acc)
    in
    loop ~acc:0 ~mask:n |> I.of_int
  ;;

  let shift_mask = (I.bitwidth |> I.to_int) - 1 |> I.of_int
  let[@inline] to_int_shift y = I.logand y shift_mask |> I.to_int
  let[@inline] shift_left x y = I.shift_left x (to_int_shift y)
  let[@inline] shift_right x y = I.shift_right x (to_int_shift y)
  let[@inline] shift_right_logical x y = I.shift_right_logical x (to_int_shift y)
end

module Int = Make (struct
    include Stdlib.Int

    external compare : t -> t -> int = "%compare"
    external equal : t -> t -> bool = "%equal"

    let bitwidth = Sys.int_size
    let to_int = Fun.id
    let of_int t = t
  end)

module Int32 = Make (struct
    include Stdlib.Int32

    external compare : t -> t -> int = "%compare"
    external equal : t -> t -> bool = "%equal"

    let bitwidth = 32l
  end)

module Int64 = Make (struct
    include Stdlib.Int64

    external compare : t -> t -> int = "%compare"
    external equal : t -> t -> bool = "%equal"

    let bitwidth = 64L
  end)

module Nativeint = Make (struct
    include Stdlib.Nativeint

    external compare : t -> t -> int = "%compare"
    external equal : t -> t -> bool = "%equal"

    let bitwidth = Sys.word_size |> of_int
  end)

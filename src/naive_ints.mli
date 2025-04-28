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

module Make (I : Intlike) : S with type t = I.t

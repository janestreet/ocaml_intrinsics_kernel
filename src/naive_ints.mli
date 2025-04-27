@@ portable

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

module Make (I : Intlike) : S with type t = I.t

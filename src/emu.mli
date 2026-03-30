module type S = sig
  type t

  val count_leading_zeros : t -> t
  val count_set_bits : t -> t
  val count_trailing_zeros : t -> t
  val shift_left : t -> t -> t
  val shift_right : t -> t -> t
  val shift_right_logical : t -> t -> t
end

module Int : S with type t := int
module Int32 : S with type t := int32
module Int64 : S with type t := int64
module Nativeint : S with type t := nativeint

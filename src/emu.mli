@@ portable

module type S = sig @@ portable
  type t : immutable_data

  val count_leading_zeros : t @ local -> t
  val count_set_bits : t @ local -> t
  val count_trailing_zeros : t @ local -> t
  val shift_left : t @ local -> t @ local -> t @ local
  val shift_right : t @ local -> t @ local -> t @ local
  val shift_right_logical : t @ local -> t @ local -> t @ local
end

module Int : S with type t := int
module Int32 : S with type t := int32
module Int64 : S with type t := int64
module Nativeint : S with type t := nativeint

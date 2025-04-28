(** [count_leading_zeros n] returns the number of most-significant zero bits before the
    most significant set bit in [n]. If [n] is 0, the result is the number of bits in [n],
    that is 64. *)
val count_leading_zeros : int64 -> int64

(** Same as [count_leading_zeros] except if the argument is zero, then the result is
    undefined. Emits more efficient code.

    This is no longer needed when using an flambda-backend compiler, which translates
    [count_leading_zeros] to LZCNT by default (amd64). *)
val count_leading_zeros_nonzero_arg : int64 -> int64

(** [count_trailing_zeros n] returns the number of least-significant zero bits before the
    least significant set bit in [n]. If [n] is 0, the result is the number of bits in
    [n], that is 64. *)
val count_trailing_zeros : int64 -> int64

(** Same as [count_trailing_zeros] except if the argument is zero, then the result is
    undefined. Emits more efficient code.

    This is no longer needed when using an flambda-backend compiler, which translates
    [count_trailing_zeros] to TZCNT by default (amd64). *)
val count_trailing_zeros_nonzero_arg : int64 -> int64

(** [count_set_bits n] returns the number of bits that are 1 in [n]. *)

val count_set_bits : int64 -> int64

(** Shift operations below differ from the corresponding [Stdlib.Int64.shift_*] operations
    in two ways:
    (a) shift count (second argument) is the same type as the first argument, allowing
        unboxed types to be used as counts.
    (b) the operations are defined for arbitrary shift counts and rely on the hardware to
        mask the count to [bitwidth-1] bits, where [bitwidth] is determined by the type of
        the first argument. *)

(** [shift_left x y] shifts [x] to the left by [y & (bitwidth-1)] bits. *)
val shift_left : int64 -> int64 -> int64

(** [Int64.shift_right x y] shifts [x] to the right by [y] bits. This is an arithmetic
    shift: the sign bit of [x] is replicated and inserted in the vacated bits. *)
val shift_right : int64 -> int64 -> int64

(** [Int64.shift_right_logical x y] shifts [x] to the right by [y] bits. This is a logical
    shift: zeroes are inserted in the vacated bits regardless of the sign of [x]. *)
val shift_right_logical : int64 -> int64 -> int64

module Naive : Naive_ints.S with type t = int64

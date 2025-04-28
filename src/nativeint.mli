(** [count_leading_zeros n] returns the number of most-significant zero bits before the
    most significant set bit in [n]. If [n] is 0, the result is the number of bits in [n],
    that is 32 or 64, depending on the target. *)
val count_leading_zeros : nativeint -> nativeint

(** Same as [count_leading_zeros] except if the argument is zero, then the result is
    undefined. Emits more efficient code.

    This is no longer needed when using an flambda-backend compiler, which translates
    [count_leading_zeros] to LZCNT by default (amd64). *)
val count_leading_zeros_nonzero_arg : nativeint -> nativeint

(** [count_trailing_zeros n] returns the number of least-significant zero bits before the
    least significant set bit in [n]. If [n] is 0, the result is the number of bits in
    [n], that is 32 or 64, depending on the target. *)
val count_trailing_zeros : nativeint -> nativeint

(** Same as [count_trailing_zeros] except if the argument is zero, then the result is
    undefined. Emits more efficient code.

    This is no longer needed when using an flambda-backend compiler, which translates
    [count_trailing_zeros] to TZCNT by default (amd64). *)
val count_trailing_zeros_nonzero_arg : nativeint -> nativeint

(** [count_set_bits n] returns the number of bits that are 1 in [n]. *)
val count_set_bits : nativeint -> nativeint

(** Shift operations below differ from the corresponding [Stdlib.Nativeint.shift_*]
    operations in two ways:
    (a) shift count (second argument) is the same type as the first argument, allowing
        unboxed types to be used as counts.
    (b) the operations are defined for arbitrary shift counts and rely on the hardware to
        mask the shift to [bitwidth-1] bits, where [bitwidth] is determined by the type of
        the first argument. *)

(** [shift_left x y] shifts [x] to the left by [y & (bitwidth-1)] bits. *)
val shift_left : nativeint -> nativeint -> nativeint

(** [Nativeint.shift_right x y] shifts [x] to the right by [y] bits. This is an arithmetic
    shift: the sign bit of [x] is replicated and inserted in the vacated bits. *)
val shift_right : nativeint -> nativeint -> nativeint

(** [Nativeint.shift_right_logical x y] shifts [x] to the right by [y] bits. This is a
    logical shift: zeroes are inserted in the vacated bits regardless of the sign of [x]. *)
val shift_right_logical : nativeint -> nativeint -> nativeint

module Naive : Naive_ints.S with type t = nativeint

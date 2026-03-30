(** Equivalent to [if x < y then x else y]. This operation has atypical NaN handling: if
    either [x] or [y] is a NaN, [min] returns [y].

    On amd64, this compiles to [minsd xmm0, xmm1]. *)
val min : float -> float -> float

(** Equivalent to [if x > y then x else y]. This operation has atypical NaN handling: if
    either [x] or [y] is a NaN, [max] returns [y].

    On amd64, this compiles to [maxsd xmm0, xmm1]. *)
val max : float -> float -> float

(** Rounds a [float] to an [int64] using the current rounding mode. In native code, the
    default rounding mode is "round half to even," and we expect that no program will
    change the rounding mode.

    If the argument is NaN or infinite or if the rounded value cannot be represented, the
    result is unspecified. *)
val iround_current : float -> int64

(** Rounds a [float] to an integer [float] using the current rounding mode. In native
    code, the default rounding mode is "round half to even," and we expect that no program
    will change the rounding mode. *)
val round_current : float -> float

(** Rounds a [float] to an integer [float] using the mode specified in the function name. *)

val round_down : float -> float
val round_up : float -> float
val round_towards_zero : float -> float

module Unboxed : sig
  val min : float -> float -> float
  val max : float -> float -> float
  val iround_current : float -> int64
  val round_current : float -> float
  val round_down : float -> float
  val round_up : float -> float
  val round_towards_zero : float -> float
end

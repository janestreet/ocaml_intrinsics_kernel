external min
  :  (float[@unboxed])
  -> (float[@unboxed])
  -> (float[@unboxed])
  = "caml_simd_float64_min_bytecode" "caml_simd_float64_min"
[@@noalloc] [@@no_effects] [@@no_coeffects]

external max
  :  (float[@unboxed])
  -> (float[@unboxed])
  -> (float[@unboxed])
  = "caml_simd_float64_max_bytecode" "caml_simd_float64_max"
[@@noalloc] [@@no_effects] [@@no_coeffects]

external iround_current
  :  (float[@unboxed])
  -> (int64[@unboxed])
  = "caml_simd_cast_float64_int64_bytecode" "caml_simd_cast_float64_int64"
[@@noalloc] [@@no_effects] [@@no_coeffects]

external round_current
  :  (float[@unboxed])
  -> (float[@unboxed])
  = "caml_simd_float64_round_current_bytecode" "caml_simd_float64_round_current"
[@@noalloc] [@@no_effects] [@@no_coeffects]

external round_down
  :  (float[@unboxed])
  -> (float[@unboxed])
  = "caml_simd_float64_round_neg_inf_bytecode" "caml_simd_float64_round_neg_inf"
[@@noalloc] [@@no_effects] [@@no_coeffects]

external round_up
  :  (float[@unboxed])
  -> (float[@unboxed])
  = "caml_simd_float64_round_pos_inf_bytecode" "caml_simd_float64_round_pos_inf"
[@@noalloc] [@@no_effects] [@@no_coeffects]

external round_towards_zero
  :  (float[@unboxed])
  -> (float[@unboxed])
  = "caml_simd_float64_round_towards_zero_bytecode" "caml_simd_float64_round_towards_zero"
[@@noalloc] [@@no_effects] [@@no_coeffects]

module Unboxed = struct
  external min
    :  (float[@unboxed])
    -> (float[@unboxed])
    -> (float[@unboxed])
    = "caml_simd_float64_min_bytecode" "caml_simd_float64_min"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external max
    :  (float[@unboxed])
    -> (float[@unboxed])
    -> (float[@unboxed])
    = "caml_simd_float64_max_bytecode" "caml_simd_float64_max"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external iround_current
    :  (float[@unboxed])
    -> (int64[@unboxed])
    = "caml_simd_cast_float64_int64_bytecode" "caml_simd_cast_float64_int64"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external round_current
    :  (float[@unboxed])
    -> (float[@unboxed])
    = "caml_simd_float64_round_current_bytecode" "caml_simd_float64_round_current"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external round_down
    :  (float[@unboxed])
    -> (float[@unboxed])
    = "caml_simd_float64_round_neg_inf_bytecode" "caml_simd_float64_round_neg_inf"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external round_up
    :  (float[@unboxed])
    -> (float[@unboxed])
    = "caml_simd_float64_round_pos_inf_bytecode" "caml_simd_float64_round_pos_inf"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external round_towards_zero
    :  (float[@unboxed])
    -> (float[@unboxed])
    = "caml_simd_float64_round_towards_zero_bytecode"
      "caml_simd_float64_round_towards_zero"
  [@@noalloc] [@@no_effects] [@@no_coeffects]
end

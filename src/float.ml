external min
  :  (float[@unboxed])
  -> (float[@unboxed])
  -> (float[@unboxed])
  = "caml_sse2_float64_min_bytecode" "caml_sse2_float64_min"
[@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

external max
  :  (float[@unboxed])
  -> (float[@unboxed])
  -> (float[@unboxed])
  = "caml_sse2_float64_max_bytecode" "caml_sse2_float64_max"
[@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

external iround_current
  :  (float[@unboxed])
  -> (int64[@unboxed])
  = "caml_sse2_cast_float64_int64_bytecode" "caml_sse2_cast_float64_int64"
[@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

module Unboxed = struct
  external min
    :  (float[@unboxed])
    -> (float[@unboxed])
    -> (float[@unboxed])
    = "caml_sse2_float64_min_bytecode" "caml_sse2_float64_min"
  [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

  external max
    :  (float[@unboxed])
    -> (float[@unboxed])
    -> (float[@unboxed])
    = "caml_sse2_float64_max_bytecode" "caml_sse2_float64_max"
  [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

  external iround_current
    :  (float[@unboxed])
    -> (int64[@unboxed])
    = "caml_sse2_cast_float64_int64_bytecode" "caml_sse2_cast_float64_int64"
  [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]
end

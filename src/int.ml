module Stubs = struct
  external count_leading_zeros
    :  int
    -> (int[@untagged])
    = "caml_int_clz" "caml_int_clz_tagged_to_untagged"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external count_leading_zeros2
    :  int
    -> int
    = "caml_int_clz" "caml_int_clz_untagged_to_untagged"
  [@@untagged] [@@noalloc] [@@no_effects] [@@no_coeffects]

  (** [count_set_bits n] returns the number of bits that are 1 in [n]. *)
  external count_set_bits
    :  int
    -> (int[@untagged])
    = "caml_int_popcnt" "caml_int_popcnt_tagged_to_untagged"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external count_set_bits2
    :  int
    -> int
    = "caml_int_popcnt" "caml_int_popcnt_untagged_to_untagged"
  [@@untagged] [@@noalloc] [@@no_effects] [@@no_coeffects]

  external count_trailing_zeros
    :  int
    -> int
    = "caml_int_ctz" "caml_int_ctz_untagged_to_untagged"
  [@@untagged] [@@noalloc] [@@no_effects] [@@no_coeffects]
end

let[@inline always] count_leading_zeros n =
  match Common.available with
  | true -> Stubs.count_leading_zeros n
  | false -> Emu.Int.count_leading_zeros n
;;

let[@inline always] count_leading_zeros2 n =
  match Common.available with
  | true -> Stubs.count_leading_zeros2 n
  | false -> Emu.Int.count_leading_zeros n
;;

let[@inline always] count_set_bits2 n =
  match Common.available with
  | true -> Stubs.count_set_bits2 n
  | false -> Emu.Int.count_set_bits n
;;

let[@inline always] count_trailing_zeros n =
  match Common.available with
  | true -> Stubs.count_trailing_zeros n
  | false -> Emu.Int.count_trailing_zeros n
;;

let[@inline always] count_set_bits n =
  match Common.available with
  | true -> Stubs.count_set_bits n
  | false -> Emu.Int.count_set_bits n
;;

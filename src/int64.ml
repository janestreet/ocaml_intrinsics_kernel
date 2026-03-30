module Stubs = struct
  external count_leading_zeros
    :  (int64[@unboxed] [@local_opt])
    -> (int64[@unboxed])
    = "caml_int64_clz" "caml_int64_clz_unboxed_to_untagged"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external count_leading_zeros_nonzero_arg
    :  (int64[@unboxed] [@local_opt])
    -> (int64[@unboxed])
    = "caml_int64_clz" "caml_int64_clz_nonzero_unboxed_to_untagged"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external count_trailing_zeros
    :  (int64[@unboxed] [@local_opt])
    -> (int64[@unboxed])
    = "caml_int64_ctz" "caml_int64_ctz_unboxed_to_untagged"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external count_trailing_zeros_nonzero_arg
    :  (int64[@unboxed] [@local_opt])
    -> (int64[@unboxed])
    = "caml_int64_ctz" "caml_int64_ctz_nonzero_unboxed_to_untagged"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external count_set_bits
    :  (int64[@unboxed] [@local_opt])
    -> (int64[@unboxed])
    = "caml_int64_popcnt" "caml_int64_popcnt_unboxed_to_untagged"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external shift_left
    :  (int64[@local_opt])
    -> (int64[@local_opt])
    -> (int64[@local_opt])
    = "caml_int64_shift_left_by_int64" "caml_int64_shift_left_by_int64_unboxed"
  [@@noalloc] [@@no_effects] [@@no_coeffects] [@@unboxed]

  external shift_right
    :  (int64[@local_opt])
    -> (int64[@local_opt])
    -> (int64[@local_opt])
    = "caml_int64_shift_right_by_int64" "caml_int64_shift_right_by_int64_unboxed"
  [@@noalloc] [@@no_effects] [@@no_coeffects] [@@unboxed]

  external shift_right_logical
    :  (int64[@local_opt])
    -> (int64[@local_opt])
    -> (int64[@local_opt])
    = "caml_int64_shift_right_logical_by_int64"
      "caml_int64_shift_right_logical_by_int64_unboxed"
  [@@noalloc] [@@no_effects] [@@no_coeffects] [@@unboxed]
end

let[@inline always] count_leading_zeros n =
  match Common.available with
  | true -> Stubs.count_leading_zeros n
  | false -> Emu.Int64.count_leading_zeros n
;;

let[@inline always] count_leading_zeros_nonzero_arg n =
  match Common.available with
  | true -> Stubs.count_leading_zeros_nonzero_arg n
  | false -> Emu.Int64.count_leading_zeros n
;;

let[@inline always] count_trailing_zeros n =
  match Common.available with
  | true -> Stubs.count_trailing_zeros n
  | false -> Emu.Int64.count_trailing_zeros n
;;

let[@inline always] count_trailing_zeros_nonzero_arg n =
  match Common.available with
  | true -> Stubs.count_trailing_zeros_nonzero_arg n
  | false -> Emu.Int64.count_trailing_zeros n
;;

let[@inline always] count_set_bits n =
  match Common.available with
  | true -> Stubs.count_set_bits n
  | false -> Emu.Int64.count_set_bits n
;;

let[@inline always] shift_left x y =
  match Common.available with
  | true -> Stubs.shift_left x y
  | false -> Emu.Int64.shift_left x y
;;

let[@inline always] shift_right x y =
  match Common.available with
  | true -> Stubs.shift_right x y
  | false -> Emu.Int64.shift_right x y
;;

let[@inline always] shift_right_logical x y =
  match Common.available with
  | true -> Stubs.shift_right_logical x y
  | false -> Emu.Int64.shift_right_logical x y
;;

module Unboxed = struct
  external box : int64 -> int64 = "%identity"
  external unbox : int64 -> int64 = "%identity"

  module Stubs = struct
    external count_leading_zeros
      :  (int64[@unboxed])
      -> (int64[@unboxed])
      = "caml_int64_clz" "caml_int64_clz_unboxed_to_untagged"
    [@@noalloc] [@@no_effects] [@@no_coeffects]

    external count_leading_zeros_nonzero_arg
      :  (int64[@unboxed])
      -> (int64[@unboxed])
      = "caml_int64_clz" "caml_int64_clz_nonzero_unboxed_to_untagged"
    [@@noalloc] [@@no_effects] [@@no_coeffects]

    external count_trailing_zeros
      :  (int64[@unboxed])
      -> (int64[@unboxed])
      = "caml_int64_ctz" "caml_int64_ctz_unboxed_to_untagged"
    [@@noalloc] [@@no_effects] [@@no_coeffects]

    external count_trailing_zeros_nonzero_arg
      :  (int64[@unboxed])
      -> (int64[@unboxed])
      = "caml_int64_ctz" "caml_int64_ctz_nonzero_unboxed_to_untagged"
    [@@noalloc] [@@no_effects] [@@no_coeffects]

    external count_set_bits
      :  (int64[@unboxed])
      -> (int64[@unboxed])
      = "caml_int64_popcnt" "caml_int64_popcnt_unboxed_to_untagged"
    [@@noalloc] [@@no_effects] [@@no_coeffects]
  end

  let[@inline always] count_leading_zeros n =
    match Common.available with
    | true -> Stubs.count_leading_zeros n
    | false -> unbox (Emu.Int64.count_leading_zeros (box n))
  ;;

  let[@inline always] count_leading_zeros_nonzero_arg n =
    match Common.available with
    | true -> Stubs.count_leading_zeros_nonzero_arg n
    | false -> unbox (Emu.Int64.count_leading_zeros (box n))
  ;;

  let[@inline always] count_trailing_zeros n =
    match Common.available with
    | true -> Stubs.count_trailing_zeros n
    | false -> unbox (Emu.Int64.count_trailing_zeros (box n))
  ;;

  let[@inline always] count_trailing_zeros_nonzero_arg n =
    match Common.available with
    | true -> Stubs.count_trailing_zeros_nonzero_arg n
    | false -> unbox (Emu.Int64.count_trailing_zeros (box n))
  ;;

  let[@inline always] count_set_bits n =
    match Common.available with
    | true -> Stubs.count_set_bits n
    | false -> unbox (Emu.Int64.count_set_bits (box n))
  ;;
end

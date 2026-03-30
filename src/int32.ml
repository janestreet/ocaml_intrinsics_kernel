module Stubs = struct
  external count_leading_zeros
    :  (int32[@unboxed] [@local_opt])
    -> (int32[@unboxed])
    = "caml_int32_clz" "caml_int32_clz_unboxed_to_untagged"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external count_leading_zeros_nonzero_arg
    :  (int32[@unboxed] [@local_opt])
    -> (int32[@unboxed])
    = "caml_int32_clz" "caml_int32_clz_nonzero_unboxed_to_untagged"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external count_trailing_zeros
    :  (int32[@unboxed] [@local_opt])
    -> (int32[@unboxed])
    = "caml_int32_ctz" "caml_int32_ctz_unboxed_to_untagged"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external count_trailing_zeros_nonzero_arg
    :  (int32[@unboxed] [@local_opt])
    -> (int32[@unboxed])
    = "caml_int32_ctz" "caml_int32_ctz_nonzero_unboxed_to_untagged"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external count_set_bits
    :  (int32[@unboxed] [@local_opt])
    -> (int32[@unboxed])
    = "caml_int32_popcnt" "caml_int32_popcnt_unboxed_to_untagged"
  [@@noalloc] [@@no_effects] [@@no_coeffects]

  external shift_left
    :  (int32[@local_opt])
    -> (int32[@local_opt])
    -> (int32[@local_opt])
    = "caml_int32_shift_left_by_int32" "caml_int32_shift_left_by_int32_unboxed"
  [@@noalloc] [@@no_effects] [@@no_coeffects] [@@unboxed]

  external shift_right
    :  (int32[@local_opt])
    -> (int32[@local_opt])
    -> (int32[@local_opt])
    = "caml_int32_shift_right_by_int32" "caml_int32_shift_right_by_int32_unboxed"
  [@@noalloc] [@@no_effects] [@@no_coeffects] [@@unboxed]

  external shift_right_logical
    :  (int32[@local_opt])
    -> (int32[@local_opt])
    -> (int32[@local_opt])
    = "caml_int32_shift_right_logical_by_int32"
      "caml_int32_shift_right_logical_by_int32_unboxed"
  [@@noalloc] [@@no_effects] [@@no_coeffects] [@@unboxed]
end

let[@inline always] count_leading_zeros n =
  match Common.available with
  | true -> Stubs.count_leading_zeros n
  | false -> Emu.Int32.count_leading_zeros n
;;

let[@inline always] count_leading_zeros_nonzero_arg n =
  match Common.available with
  | true -> Stubs.count_leading_zeros_nonzero_arg n
  | false -> Emu.Int32.count_leading_zeros n
;;

let[@inline always] count_trailing_zeros n =
  match Common.available with
  | true -> Stubs.count_trailing_zeros n
  | false -> Emu.Int32.count_trailing_zeros n
;;

let[@inline always] count_trailing_zeros_nonzero_arg n =
  match Common.available with
  | true -> Stubs.count_trailing_zeros_nonzero_arg n
  | false -> Emu.Int32.count_trailing_zeros n
;;

let[@inline always] count_set_bits n =
  match Common.available with
  | true -> Stubs.count_set_bits n
  | false -> Emu.Int32.count_set_bits n
;;

let[@inline always] shift_left x y =
  match Common.available with
  | true -> Stubs.shift_left x y
  | false -> Emu.Int32.shift_left x y
;;

let[@inline always] shift_right x y =
  match Common.available with
  | true -> Stubs.shift_right x y
  | false -> Emu.Int32.shift_right x y
;;

let[@inline always] shift_right_logical x y =
  match Common.available with
  | true -> Stubs.shift_right_logical x y
  | false -> Emu.Int32.shift_right_logical x y
;;

module Unboxed = struct
  external box : int32 -> int32 = "%identity"
  external unbox : int32 -> int32 = "%identity"

  module Stubs = struct
    external count_leading_zeros
      :  (int32[@unboxed])
      -> (int32[@unboxed])
      = "caml_int32_clz" "caml_int32_clz_unboxed_to_untagged"
    [@@noalloc] [@@no_effects] [@@no_coeffects]

    external count_leading_zeros_nonzero_arg
      :  (int32[@unboxed])
      -> (int32[@unboxed])
      = "caml_int32_clz" "caml_int32_clz_nonzero_unboxed_to_untagged"
    [@@noalloc] [@@no_effects] [@@no_coeffects]

    external count_trailing_zeros
      :  (int32[@unboxed])
      -> (int32[@unboxed])
      = "caml_int32_ctz" "caml_int32_ctz_unboxed_to_untagged"
    [@@noalloc] [@@no_effects] [@@no_coeffects]

    external count_trailing_zeros_nonzero_arg
      :  (int32[@unboxed])
      -> (int32[@unboxed])
      = "caml_int32_ctz" "caml_int32_ctz_nonzero_unboxed_to_untagged"
    [@@noalloc] [@@no_effects] [@@no_coeffects]

    external count_set_bits
      :  (int32[@unboxed])
      -> (int32[@unboxed])
      = "caml_int32_popcnt" "caml_int32_popcnt_unboxed_to_untagged"
    [@@noalloc] [@@no_effects] [@@no_coeffects]
  end

  let[@inline always] count_leading_zeros n =
    match Common.available with
    | true -> Stubs.count_leading_zeros n
    | false -> unbox (Emu.Int32.count_leading_zeros (box n))
  ;;

  let[@inline always] count_leading_zeros_nonzero_arg n =
    match Common.available with
    | true -> Stubs.count_leading_zeros_nonzero_arg n
    | false -> unbox (Emu.Int32.count_leading_zeros (box n))
  ;;

  let[@inline always] count_trailing_zeros n =
    match Common.available with
    | true -> Stubs.count_trailing_zeros n
    | false -> unbox (Emu.Int32.count_trailing_zeros (box n))
  ;;

  let[@inline always] count_trailing_zeros_nonzero_arg n =
    match Common.available with
    | true -> Stubs.count_trailing_zeros_nonzero_arg n
    | false -> unbox (Emu.Int32.count_trailing_zeros (box n))
  ;;

  let[@inline always] count_set_bits n =
    match Common.available with
    | true -> Stubs.count_set_bits n
    | false -> unbox (Emu.Int32.count_set_bits (box n))
  ;;
end

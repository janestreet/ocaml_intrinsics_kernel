module Stubs = struct
  external count_leading_zeros
    :  (nativeint[@unboxed] [@local_opt])
    -> (nativeint[@unboxed])
    @@ portable
    = "caml_nativeint_clz" "caml_nativeint_clz_unboxed_to_untagged"
  [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

  external count_trailing_zeros
    :  (nativeint[@unboxed] [@local_opt])
    -> (nativeint[@unboxed])
    @@ portable
    = "caml_nativeint_ctz" "caml_nativeint_ctz_unboxed_to_untagged"
  [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

  external count_set_bits
    :  (nativeint[@unboxed] [@local_opt])
    -> (nativeint[@unboxed])
    @@ portable
    = "caml_nativeint_popcnt" "caml_nativeint_popcnt_unboxed_to_untagged"
  [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

  external shift_left
    :  (nativeint[@local_opt])
    -> (nativeint[@local_opt])
    -> (nativeint[@local_opt])
    @@ portable
    = "caml_nativeint_shift_left_by_nativeint"
      "caml_nativeint_shift_left_by_nativeint_unboxed"
  [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects] [@@unboxed]

  external shift_right
    :  (nativeint[@local_opt])
    -> (nativeint[@local_opt])
    -> (nativeint[@local_opt])
    @@ portable
    = "caml_nativeint_shift_right_by_nativeint"
      "caml_nativeint_shift_right_by_nativeint_unboxed"
  [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects] [@@unboxed]

  external shift_right_logical
    :  (nativeint[@local_opt])
    -> (nativeint[@local_opt])
    -> (nativeint[@local_opt])
    @@ portable
    = "caml_nativeint_shift_right_logical_by_nativeint"
      "caml_nativeint_shift_right_logical_by_nativeint_unboxed"
  [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects] [@@unboxed]
end

let[@inline always] count_leading_zeros n =
  match Common.available with
  | true -> Stubs.count_leading_zeros n
  | false -> Emu.Nativeint.count_leading_zeros n
;;

let[@inline always] count_trailing_zeros n =
  match Common.available with
  | true -> Stubs.count_trailing_zeros n
  | false -> Emu.Nativeint.count_trailing_zeros n
;;

let[@inline always] count_set_bits n =
  match Common.available with
  | true -> Stubs.count_set_bits n
  | false -> Emu.Nativeint.count_set_bits n
;;

let[@inline always] shift_left x y =
  match Common.available with
  | true -> exclave_ Stubs.shift_left x y
  | false -> exclave_ Emu.Nativeint.shift_left x y
;;

let[@inline always] shift_right x y =
  match Common.available with
  | true -> exclave_ Stubs.shift_right x y
  | false -> exclave_ Emu.Nativeint.shift_right x y
;;

let[@inline always] shift_right_logical x y =
  match Common.available with
  | true -> exclave_ Stubs.shift_right_logical x y
  | false -> exclave_ Emu.Nativeint.shift_right_logical x y
;;

module Unboxed = struct
  external box
    :  (nativeint#[@unboxed])
    -> (nativeint[@local_opt])
    @@ portable
    = "%box_nativeint"

  external unbox
    :  (nativeint[@local_opt])
    -> (nativeint#[@unboxed])
    @@ portable
    = "%unbox_nativeint"

  module Stubs = struct
    external count_leading_zeros
      :  (nativeint#[@unboxed])
      -> (nativeint#[@unboxed])
      @@ portable
      = "caml_nativeint_clz" "caml_nativeint_clz_unboxed_to_untagged"
    [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

    external count_trailing_zeros
      :  (nativeint#[@unboxed])
      -> (nativeint#[@unboxed])
      @@ portable
      = "caml_nativeint_ctz" "caml_nativeint_ctz_unboxed_to_untagged"
    [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

    external count_set_bits
      :  (nativeint#[@unboxed])
      -> (nativeint#[@unboxed])
      @@ portable
      = "caml_nativeint_popcnt" "caml_nativeint_popcnt_unboxed_to_untagged"
    [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]
  end

  let[@inline always] count_leading_zeros n =
    match Common.available with
    | true -> Stubs.count_leading_zeros n
    | false -> unbox (Emu.Nativeint.count_leading_zeros (box n))
  ;;

  let[@inline always] count_trailing_zeros n =
    match Common.available with
    | true -> Stubs.count_trailing_zeros n
    | false -> unbox (Emu.Nativeint.count_trailing_zeros (box n))
  ;;

  let[@inline always] count_set_bits n =
    match Common.available with
    | true -> Stubs.count_set_bits n
    | false -> unbox (Emu.Nativeint.count_set_bits (box n))
  ;;
end

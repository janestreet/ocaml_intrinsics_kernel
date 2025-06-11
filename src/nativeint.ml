module Stubs = struct
  let available = Common.available

  (** [count_leading_zeros n] returns the number of most-significant zero bits before the
      most significant set bit in [n]. If [n] is 0, the result is the number of bits in
      [n], that is 32 or 64, depending on the target. *)
  external count_leading_zeros
    :  (nativeint[@unboxed] [@local_opt])
    -> (nativeint[@unboxed])
    @@ portable
    = "caml_nativeint_clz" "caml_nativeint_clz_unboxed_to_untagged"
  [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

  (** Same as [count_leading_zeros] except if the argument is zero, then the result is
      undefined. Emits more efficient code. *)
  external count_leading_zeros_nonzero_arg
    :  (nativeint[@unboxed] [@local_opt])
    -> (nativeint[@unboxed])
    @@ portable
    = "caml_nativeint_clz" "caml_nativeint_clz_nonzero_unboxed_to_untagged"
  [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

  (** [count_trailing_zeros n] returns the number of least-significant zero bits before
      the least significant set bit in [n]. If [n] is 0, the result is the number of bits
      in [n], that is 32 or 64, depending on the target. *)
  external count_trailing_zeros
    :  (nativeint[@unboxed] [@local_opt])
    -> (nativeint[@unboxed])
    @@ portable
    = "caml_nativeint_ctz" "caml_nativeint_ctz_unboxed_to_untagged"
  [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

  (** Same as [count_trailing_zeros] except if the argument is zero, then the result is
      undefined. Emits more efficient code. *)
  external count_trailing_zeros_nonzero_arg
    :  (nativeint[@unboxed] [@local_opt])
    -> (nativeint[@unboxed])
    @@ portable
    = "caml_nativeint_ctz" "caml_nativeint_ctz_nonzero_unboxed_to_untagged"
  [@@noalloc] [@@builtin] [@@no_effects] [@@no_coeffects]

  (** [count_set_bits n] returns the number of bits that are 1 in [n]. *)
  external count_set_bits
    :  (nativeint[@unboxed] [@local_opt])
    -> (nativeint[@unboxed])
    @@ portable
    = "caml_nativeint_popcnt" "caml_nativeint_popcnt_unboxed_to_untagged"
  [@@noalloc] (* [@@builtin] *) [@@no_effects] [@@no_coeffects]

  external shift_left
    :  (nativeint[@local_opt])
    -> (nativeint[@local_opt])
    -> (nativeint[@local_opt])
    @@ portable
    = "caml_nativeint_shift_left_by_nativeint"
      "caml_nativeint_shift_left_by_nativeint_unboxed"
  [@@noalloc] (* [@@builtin] *) [@@no_effects] [@@no_coeffects] [@@unboxed]

  external shift_right
    :  (nativeint[@local_opt])
    -> (nativeint[@local_opt])
    -> (nativeint[@local_opt])
    @@ portable
    = "caml_nativeint_shift_right_by_nativeint"
      "caml_nativeint_shift_right_by_nativeint_unboxed"
  [@@noalloc] (* [@@builtin] *) [@@no_effects] [@@no_coeffects] [@@unboxed]

  external shift_right_logical
    :  (nativeint[@local_opt])
    -> (nativeint[@local_opt])
    -> (nativeint[@local_opt])
    @@ portable
    = "caml_nativeint_shift_right_logical_by_nativeint"
      "caml_nativeint_shift_right_logical_by_nativeint_unboxed"
  [@@noalloc] (* [@@builtin] *) [@@no_effects] [@@no_coeffects] [@@unboxed]
end

module Naive = Naive_ints.Make (struct
    include Stdlib.Nativeint

    external compare : local_ t -> local_ t -> int @@ portable = "%compare"
    external equal : local_ t -> local_ t -> bool @@ portable = "%equal"

    let bitwidth = Sys.word_size |> of_int
  end)

let[@inline always] count_leading_zeros n =
  match Stubs.available with
  | true -> Stubs.count_leading_zeros n
  | false -> Naive.count_leading_zeros n
;;

let[@inline always] count_leading_zeros_nonzero_arg n =
  match Stubs.available with
  | true -> Stubs.count_leading_zeros_nonzero_arg n
  | false -> Naive.count_leading_zeros n
;;

let[@inline always] count_trailing_zeros n =
  match Stubs.available with
  | true -> Stubs.count_trailing_zeros n
  | false -> Naive.count_trailing_zeros n
;;

let[@inline always] count_trailing_zeros_nonzero_arg n =
  match Stubs.available with
  | true -> Stubs.count_trailing_zeros_nonzero_arg n
  | false -> Naive.count_trailing_zeros n
;;

let[@inline always] count_set_bits n =
  match Stubs.available with
  | true -> Stubs.count_set_bits n
  | false -> Naive.count_set_bits n
;;

let[@inline always] shift_left x y =
  match Stubs.available with
  | true -> exclave_ Stubs.shift_left x y
  | false -> exclave_ Naive.shift_left x y
;;

let[@inline always] shift_right x y =
  match Stubs.available with
  | true -> exclave_ Stubs.shift_right x y
  | false -> exclave_ Naive.shift_right x y
;;

let[@inline always] shift_right_logical x y =
  match Stubs.available with
  | true -> exclave_ Stubs.shift_right_logical x y
  | false -> exclave_ Naive.shift_right_logical x y
;;

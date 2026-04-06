open! Base
open! Stdio
module I = Ocaml_intrinsics_kernel.Float

let%expect_test "min and max" =
  let args =
    [ 0., 1.
    ; 1., 0.
    ; Float.neg_infinity, Float.infinity
    ; Float.infinity, Float.neg_infinity
    ; -0., 0.
    ; 0., -0.
    ; Float.nan, 0.
    ; 0., Float.nan
    ]
  in
  List.iter args ~f:(fun (x, y) -> printf "min %.19g %.19g = %.19g\n" x y (I.min x y));
  [%expect
    {|
    min 0 1 = 0
    min 1 0 = 0
    min -inf inf = -inf
    min inf -inf = -inf
    min -0 0 = 0
    min 0 -0 = -0
    min nan 0 = 0
    min 0 nan = nan
    |}];
  List.iter args ~f:(fun (x, y) -> printf "max %.19g %.19g = %.19g\n" x y (I.max x y));
  [%expect
    {|
    max 0 1 = 1
    max 1 0 = 1
    max -inf inf = inf
    max inf -inf = inf
    max -0 0 = 0
    max 0 -0 = -0
    max nan 0 = 0
    max 0 nan = nan
    |}]
;;

let%expect_test "iround_current" =
  let args =
    [ 0.
    ; -0.
    ; 0.4
    ; -0.4
    ; 0.6
    ; -0.6
    ; Float.of_int64 (Float.to_int64_preserve_order_exn Float.infinity)
    ; Float.of_int64 (Float.to_int64_preserve_order_exn Float.neg_infinity)
    ]
  in
  List.iter args ~f:(fun x ->
    printf "iround_current %.19g = %Ld\n" x (I.iround_current x));
  [%expect
    {|
    iround_current 0 = 0
    iround_current -0 = 0
    iround_current 0.4000000000000000222 = 0
    iround_current -0.4000000000000000222 = 0
    iround_current 0.5999999999999999778 = 1
    iround_current -0.5999999999999999778 = -1
    iround_current 9218868437227405312 = 9218868437227405312
    iround_current -9218868437227405312 = -9218868437227405312
    |}]
;;

let args =
  [ Float.infinity
  ; -0x1p+63
  ; -0x1p+62
  ; -3.50
  ; -3.25
  ; -3.00
  ; -2.75
  ; -2.50
  ; -2.25
  ; -2.00
  ; -1.75
  ; -1.50
  ; -1.25
  ; -1.00
  ; -0.75
  ; -0.50
  ; -0.25
  ; -0.00
  ; 0.00
  ; 0.25
  ; 0.50
  ; 0.75
  ; 1.00
  ; 1.25
  ; 1.50
  ; 1.75
  ; 2.00
  ; 2.25
  ; 2.50
  ; 2.75
  ; 3.00
  ; 3.25
  ; 3.50
  ; 0x1.fffffffffffffp+61
  ; 0x1.fffffffffffffp+62
  ; Float.neg_infinity
  ; Float.nan
  ]
;;

let%expect_test "round" =
  List.iter args ~f:(fun x -> printf "round up %.19g = %.19g\n" x (I.round_up x));
  [%expect
    {|
    round up inf = inf
    round up -9223372036854775808 = -9223372036854775808
    round up -4611686018427387904 = -4611686018427387904
    round up -3.5 = -3
    round up -3.25 = -3
    round up -3 = -3
    round up -2.75 = -2
    round up -2.5 = -2
    round up -2.25 = -2
    round up -2 = -2
    round up -1.75 = -1
    round up -1.5 = -1
    round up -1.25 = -1
    round up -1 = -1
    round up -0.75 = -0
    round up -0.5 = -0
    round up -0.25 = -0
    round up -0 = -0
    round up 0 = 0
    round up 0.25 = 1
    round up 0.5 = 1
    round up 0.75 = 1
    round up 1 = 1
    round up 1.25 = 2
    round up 1.5 = 2
    round up 1.75 = 2
    round up 2 = 2
    round up 2.25 = 3
    round up 2.5 = 3
    round up 2.75 = 3
    round up 3 = 3
    round up 3.25 = 4
    round up 3.5 = 4
    round up 4611686018427387392 = 4611686018427387392
    round up 9223372036854774784 = 9223372036854774784
    round up -inf = -inf
    round up nan = nan
    |}];
  List.iter args ~f:(fun x -> printf "round down %.19g = %.19g\n" x (I.round_down x));
  [%expect
    {|
    round down inf = inf
    round down -9223372036854775808 = -9223372036854775808
    round down -4611686018427387904 = -4611686018427387904
    round down -3.5 = -4
    round down -3.25 = -4
    round down -3 = -3
    round down -2.75 = -3
    round down -2.5 = -3
    round down -2.25 = -3
    round down -2 = -2
    round down -1.75 = -2
    round down -1.5 = -2
    round down -1.25 = -2
    round down -1 = -1
    round down -0.75 = -1
    round down -0.5 = -1
    round down -0.25 = -1
    round down -0 = -0
    round down 0 = 0
    round down 0.25 = 0
    round down 0.5 = 0
    round down 0.75 = 0
    round down 1 = 1
    round down 1.25 = 1
    round down 1.5 = 1
    round down 1.75 = 1
    round down 2 = 2
    round down 2.25 = 2
    round down 2.5 = 2
    round down 2.75 = 2
    round down 3 = 3
    round down 3.25 = 3
    round down 3.5 = 3
    round down 4611686018427387392 = 4611686018427387392
    round down 9223372036854774784 = 9223372036854774784
    round down -inf = -inf
    round down nan = nan
    |}];
  List.iter args ~f:(fun x ->
    printf "round to zero %.19g = %.19g\n" x (I.round_towards_zero x));
  [%expect
    {|
    round to zero inf = inf
    round to zero -9223372036854775808 = -9223372036854775808
    round to zero -4611686018427387904 = -4611686018427387904
    round to zero -3.5 = -3
    round to zero -3.25 = -3
    round to zero -3 = -3
    round to zero -2.75 = -2
    round to zero -2.5 = -2
    round to zero -2.25 = -2
    round to zero -2 = -2
    round to zero -1.75 = -1
    round to zero -1.5 = -1
    round to zero -1.25 = -1
    round to zero -1 = -1
    round to zero -0.75 = -0
    round to zero -0.5 = -0
    round to zero -0.25 = -0
    round to zero -0 = -0
    round to zero 0 = 0
    round to zero 0.25 = 0
    round to zero 0.5 = 0
    round to zero 0.75 = 0
    round to zero 1 = 1
    round to zero 1.25 = 1
    round to zero 1.5 = 1
    round to zero 1.75 = 1
    round to zero 2 = 2
    round to zero 2.25 = 2
    round to zero 2.5 = 2
    round to zero 2.75 = 2
    round to zero 3 = 3
    round to zero 3.25 = 3
    round to zero 3.5 = 3
    round to zero 4611686018427387392 = 4611686018427387392
    round to zero 9223372036854774784 = 9223372036854774784
    round to zero -inf = -inf
    round to zero nan = nan
    |}]
;;

(* amd64, arm64, and wasm round-to-even, javascript does not *)
let%expect_test ("round_current" [@tags "no-js"]) =
  List.iter args ~f:(fun x ->
    printf "round_current %.19g = %.19g\n" x (I.round_current x));
  [%expect
    {|
    round_current inf = inf
    round_current -9223372036854775808 = -9223372036854775808
    round_current -4611686018427387904 = -4611686018427387904
    round_current -3.5 = -4
    round_current -3.25 = -3
    round_current -3 = -3
    round_current -2.75 = -3
    round_current -2.5 = -2
    round_current -2.25 = -2
    round_current -2 = -2
    round_current -1.75 = -2
    round_current -1.5 = -2
    round_current -1.25 = -1
    round_current -1 = -1
    round_current -0.75 = -1
    round_current -0.5 = -0
    round_current -0.25 = -0
    round_current -0 = -0
    round_current 0 = 0
    round_current 0.25 = 0
    round_current 0.5 = 0
    round_current 0.75 = 1
    round_current 1 = 1
    round_current 1.25 = 1
    round_current 1.5 = 2
    round_current 1.75 = 2
    round_current 2 = 2
    round_current 2.25 = 2
    round_current 2.5 = 2
    round_current 2.75 = 3
    round_current 3 = 3
    round_current 3.25 = 3
    round_current 3.5 = 4
    round_current 4611686018427387392 = 4611686018427387392
    round_current 9223372036854774784 = 9223372036854774784
    round_current -inf = -inf
    round_current nan = nan
    |}]
;;

(* amd64, arm64, and wasm round-to-even, javascript does not *)
let%expect_test ("iround_current" [@tags "no-js"]) =
  List.iter args ~f:(fun x ->
    (* [iround_current inf] is unspecified, and differs between amd64 and arm64. *)
    if Float.is_finite x then printf "iround_current %.19g = %Ld\n" x (I.iround_current x));
  [%expect
    {|
    iround_current -9223372036854775808 = -9223372036854775808
    iround_current -4611686018427387904 = -4611686018427387904
    iround_current -3.5 = -4
    iround_current -3.25 = -3
    iround_current -3 = -3
    iround_current -2.75 = -3
    iround_current -2.5 = -2
    iround_current -2.25 = -2
    iround_current -2 = -2
    iround_current -1.75 = -2
    iround_current -1.5 = -2
    iround_current -1.25 = -1
    iround_current -1 = -1
    iround_current -0.75 = -1
    iround_current -0.5 = 0
    iround_current -0.25 = 0
    iround_current -0 = 0
    iround_current 0 = 0
    iround_current 0.25 = 0
    iround_current 0.5 = 0
    iround_current 0.75 = 1
    iround_current 1 = 1
    iround_current 1.25 = 1
    iround_current 1.5 = 2
    iround_current 1.75 = 2
    iround_current 2 = 2
    iround_current 2.25 = 2
    iround_current 2.5 = 2
    iround_current 2.75 = 3
    iround_current 3 = 3
    iround_current 3.25 = 3
    iround_current 3.5 = 4
    iround_current 4611686018427387392 = 4611686018427387392
    iround_current 9223372036854774784 = 9223372036854774784
    |}]
;;

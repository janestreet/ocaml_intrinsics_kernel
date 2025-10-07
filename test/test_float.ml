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

let%expect_test "iround" =
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
  List.iter args ~f:(fun x -> printf "iround %.19g = %Ld\n" x (I.iround_current x));
  [%expect
    {|
    iround 0 = 0
    iround -0 = 0
    iround 0.4000000000000000222 = 0
    iround -0.4000000000000000222 = 0
    iround 0.5999999999999999778 = 1
    iround -0.5999999999999999778 = -1
    iround 9218868437227405312 = 9218868437227405312
    iround -9218868437227405312 = -9218868437227405312
    |}]
;;

let%expect_test ("iround half-to-even" [@tags "no-js"]) =
  let args = [ 0.5; -0.5; 1.5; -1.5 ] in
  List.iter args ~f:(fun x -> printf "iround %.19g = %Ld\n" x (I.iround_current x));
  [%expect
    {|
    iround 0.5 = 0
    iround -0.5 = 0
    iround 1.5 = 2
    iround -1.5 = -2
    |}]
;;

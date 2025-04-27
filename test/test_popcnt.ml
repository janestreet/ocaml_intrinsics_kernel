open Base
open Import
module I = Ocaml_intrinsics_kernel

let%expect_test "popcnt int64" =
  let open Int64 in
  let numbers = [ 0L; 1L; 7L; max_value; min_value; -1L ] in
  let f = test ~op:I.Int64.count_set_bits ~name:"popcnt" (module Hex) (module Int64) in
  List.iter ~f numbers;
  [%expect
    {|
    popcnt 0x0 = 0
    popcnt 0x1 = 1
    popcnt 0x7 = 3
    popcnt 0x7fff_ffff_ffff_ffff = 63
    popcnt -0x8000_0000_0000_0000 = 1
    popcnt -0x1 = 64
    |}]
;;

let%expect_test "popcnt int32" =
  let open Int32 in
  let numbers = [ 0l; 1l; 7l; max_value; min_value; -1l ] in
  let f = test ~op:I.Int32.count_set_bits ~name:"popcnt" (module Hex) (module Int32) in
  List.iter ~f numbers;
  [%expect
    {|
    popcnt 0x0 = 0
    popcnt 0x1 = 1
    popcnt 0x7 = 3
    popcnt 0x7fff_ffff = 31
    popcnt -0x8000_0000 = 1
    popcnt -0x1 = 32
    |}]
;;

module%test [@tags "64-bits-only"] Arch64 = struct
  let%expect_test "popcnt int" =
    let open Int in
    let numbers =
      [ 0
      ; 1
      ; 7
      ; max_value (* Int.num_bits - 1 *)
      ; min_value (* 1 *)
      ; -1 (* Int.num_bits *)
      ]
    in
    let f = test (module Hex) (module Int) ~op:I.Int.count_set_bits ~name:"popcnt" in
    List.iter ~f numbers;
    [%expect
      {|
      popcnt 0x0 = 0
      popcnt 0x1 = 1
      popcnt 0x7 = 3
      popcnt 0x3fff_ffff_ffff_ffff = 62
      popcnt -0x4000_0000_0000_0000 = 1
      popcnt -0x1 = 63
      |}];
    let f = test (module Hex) (module Int) ~op:I.Int.count_set_bits2 ~name:"popcnt2" in
    List.iter ~f numbers;
    [%expect
      {|
      popcnt2 0x0 = 0
      popcnt2 0x1 = 1
      popcnt2 0x7 = 3
      popcnt2 0x3fff_ffff_ffff_ffff = 62
      popcnt2 -0x4000_0000_0000_0000 = 1
      popcnt2 -0x1 = 63
      |}]
  ;;

  let%expect_test "popcnt nativeint" =
    let open Nativeint in
    let numbers = [ 0n; 1n; 7n; max_value; min_value; -1n ] in
    let f =
      test (module Hex) (module Nativeint) ~op:I.Nativeint.count_set_bits ~name:"popcnt"
    in
    List.iter ~f numbers;
    [%expect
      {|
      popcnt 0x0 = 0
      popcnt 0x1 = 1
      popcnt 0x7 = 3
      popcnt 0x7fff_ffff_ffff_ffff = 63
      popcnt -0x8000_0000_0000_0000 = 1
      popcnt -0x1 = 64
      |}]
  ;;
end

module%test [@tags "32-bits-only", "js-only"] Arch32 = struct
  let%expect_test "popcnt int" =
    let open Int in
    let numbers =
      [ 0
      ; 1
      ; 7
      ; max_value (* Int.num_bits - 1 *)
      ; min_value (* 1 *)
      ; -1 (* Int.num_bits *)
      ]
    in
    let f = test (module Hex) (module Int) ~op:I.Int.count_set_bits ~name:"popcnt" in
    List.iter ~f numbers;
    [%expect
      {|
      popcnt 0x0 = 0
      popcnt 0x1 = 1
      popcnt 0x7 = 3
      popcnt 0x3fff_ffff = 30
      popcnt -0x4000_0000 = 1
      popcnt -0x1 = 31
      |}];
    let f = test (module Hex) (module Int) ~op:I.Int.count_set_bits2 ~name:"popcnt2" in
    List.iter ~f numbers;
    [%expect
      {|
      popcnt2 0x0 = 0
      popcnt2 0x1 = 1
      popcnt2 0x7 = 3
      popcnt2 0x3fff_ffff = 30
      popcnt2 -0x4000_0000 = 1
      popcnt2 -0x1 = 31
      |}]
  ;;

  let%expect_test "popcnt nativeint" =
    let open Nativeint in
    let numbers = [ 0n; 1n; 7n; max_value; min_value; -1n ] in
    let f =
      test (module Hex) (module Nativeint) ~op:I.Nativeint.count_set_bits ~name:"popcnt"
    in
    List.iter ~f numbers;
    [%expect
      {|
      popcnt 0x0 = 0
      popcnt 0x1 = 1
      popcnt 0x7 = 3
      popcnt 0x7fff_ffff = 31
      popcnt -0x8000_0000 = 1
      popcnt -0x1 = 32
      |}]
  ;;
end

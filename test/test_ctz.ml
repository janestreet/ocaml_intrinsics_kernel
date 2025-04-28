open Base
open Import
module I = Ocaml_intrinsics_kernel

let numbers = [ 0 (* Int.num_bits *); 1; 7; 2; 4; 12; 18; -1 ]

let%expect_test "ctz int64" =
  let open Int64 in
  let numbers = List.map numbers ~f:of_int in
  let f =
    test (module Int64.Hex) (module Int64) ~op:I.Int64.count_trailing_zeros ~name:"ctz"
  in
  List.iter ~f (max_value :: min_value :: numbers);
  [%expect
    {|
    ctz 0x7fff_ffff_ffff_ffff = 0
    ctz -0x8000_0000_0000_0000 = 63
    ctz 0x0 = 64
    ctz 0x1 = 0
    ctz 0x7 = 0
    ctz 0x2 = 1
    ctz 0x4 = 2
    ctz 0xc = 2
    ctz 0x12 = 1
    ctz -0x1 = 0
    |}]
;;

let%expect_test "ctz int32" =
  let open Int32 in
  let numbers = List.map numbers ~f:of_int_trunc in
  let f = test ~op:I.Int32.count_trailing_zeros ~name:"ctz" (module Hex) (module Int32) in
  List.iter ~f (max_value :: min_value :: numbers);
  [%expect
    {|
    ctz 0x7fff_ffff = 0
    ctz -0x8000_0000 = 31
    ctz 0x0 = 32
    ctz 0x1 = 0
    ctz 0x7 = 0
    ctz 0x2 = 1
    ctz 0x4 = 2
    ctz 0xc = 2
    ctz 0x12 = 1
    ctz -0x1 = 0
    |}]
;;

module%test [@tags "64-bits-only"] Arch64 = struct
  let%expect_test "ctz int" =
    let open Int in
    let f =
      test (module Int.Hex) (module Int) ~op:I.Int.count_trailing_zeros ~name:"ctz"
    in
    List.iter ~f (max_value :: min_value :: numbers);
    [%expect
      {|
      ctz 0x3fff_ffff_ffff_ffff = 0
      ctz -0x4000_0000_0000_0000 = 62
      ctz 0x0 = 63
      ctz 0x1 = 0
      ctz 0x7 = 0
      ctz 0x2 = 1
      ctz 0x4 = 2
      ctz 0xc = 2
      ctz 0x12 = 1
      ctz -0x1 = 0
      |}]
  ;;

  let%expect_test "ctz nativeint" =
    let open Nativeint in
    let numbers = List.map numbers ~f:of_int in
    let f =
      test
        (module Nativeint.Hex)
        (module Nativeint)
        ~op:I.Nativeint.count_trailing_zeros
        ~name:"ctz"
    in
    List.iter ~f (max_value :: min_value :: numbers);
    [%expect
      {|
      ctz 0x7fff_ffff_ffff_ffff = 0
      ctz -0x8000_0000_0000_0000 = 63
      ctz 0x0 = 64
      ctz 0x1 = 0
      ctz 0x7 = 0
      ctz 0x2 = 1
      ctz 0x4 = 2
      ctz 0xc = 2
      ctz 0x12 = 1
      ctz -0x1 = 0
      |}]
  ;;
end

module%test [@tags "32-bits-only", "js-only"] Arch32 = struct
  let%expect_test "ctz int" =
    let open Int in
    let f =
      test (module Int.Hex) (module Int) ~op:I.Int.count_trailing_zeros ~name:"ctz"
    in
    List.iter ~f (max_value :: min_value :: numbers);
    [%expect
      {|
      ctz 0x3fff_ffff = 0
      ctz -0x4000_0000 = 30
      ctz 0x0 = 31
      ctz 0x1 = 0
      ctz 0x7 = 0
      ctz 0x2 = 1
      ctz 0x4 = 2
      ctz 0xc = 2
      ctz 0x12 = 1
      ctz -0x1 = 0
      |}]
  ;;

  let%expect_test "ctz nativeint" =
    let open Nativeint in
    let numbers = List.map numbers ~f:of_int in
    let f =
      test
        (module Nativeint.Hex)
        (module Nativeint)
        ~op:I.Nativeint.count_trailing_zeros
        ~name:"ctz"
    in
    List.iter ~f (max_value :: min_value :: numbers);
    [%expect
      {|
      ctz 0x7fff_ffff = 0
      ctz -0x8000_0000 = 31
      ctz 0x0 = 32
      ctz 0x1 = 0
      ctz 0x7 = 0
      ctz 0x2 = 1
      ctz 0x4 = 2
      ctz 0xc = 2
      ctz 0x12 = 1
      ctz -0x1 = 0
      |}]
  ;;
end

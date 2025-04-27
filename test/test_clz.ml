open Base
open Import
module I = Ocaml_intrinsics_kernel

let%expect_test "clz int64" =
  let open Int64 in
  let numbers =
    [ 0L (* Int.num_bits *)
    ; 1L (* Int.num_bits - 1 *)
    ; 7L (* Int.num_bits - 3  *)
    ; max_value
    ; min_value
    ; -1L
    ]
  in
  let f =
    test (module Int64.Hex) (module Int64) ~op:I.Int64.count_leading_zeros ~name:"clz"
  in
  List.iter ~f numbers;
  [%expect
    {|
    clz 0x0 = 64
    clz 0x1 = 63
    clz 0x7 = 61
    clz 0x7fff_ffff_ffff_ffff = 1
    clz -0x8000_0000_0000_0000 = 0
    clz -0x1 = 0
    |}]
;;

let%expect_test "clz int32" =
  let open Int32 in
  let numbers =
    [ 0l (* Int.num_bits *)
    ; 1l (* Int.num_bits - 1 *)
    ; 7l (* Int.num_bits - 3  *)
    ; max_value
    ; min_value
    ; -1l
    ]
  in
  let f =
    test (module Int32.Hex) (module Int32) ~op:I.Int32.count_leading_zeros ~name:"clz"
  in
  List.iter ~f numbers;
  [%expect
    {|
    clz 0x0 = 32
    clz 0x1 = 31
    clz 0x7 = 29
    clz 0x7fff_ffff = 1
    clz -0x8000_0000 = 0
    clz -0x1 = 0
    |}]
;;

module%test [@tags "64-bits-only"] Arch64 = struct
  let%expect_test "clz int" =
    let open Int in
    let numbers =
      [ 0 (* Int.num_bits *)
      ; 1 (* Int.num_bits - 1 *)
      ; 7 (* Int.num_bits - 3  *)
      ; max_value
      ; min_value
      ; -1
      ]
    in
    let f =
      test (module Int.Hex) (module Int) ~op:I.Int.count_leading_zeros ~name:"clz"
    in
    List.iter ~f numbers;
    [%expect
      {|
      clz 0x0 = 63
      clz 0x1 = 62
      clz 0x7 = 60
      clz 0x3fff_ffff_ffff_ffff = 1
      clz -0x4000_0000_0000_0000 = 0
      clz -0x1 = 0
      |}];
    let f =
      test (module Int.Hex) (module Int) ~op:I.Int.count_leading_zeros2 ~name:"clz2"
    in
    List.iter ~f numbers;
    [%expect
      {|
      clz2 0x0 = 63
      clz2 0x1 = 62
      clz2 0x7 = 60
      clz2 0x3fff_ffff_ffff_ffff = 1
      clz2 -0x4000_0000_0000_0000 = 0
      clz2 -0x1 = 0
      |}]
  ;;

  let%expect_test "clz nativeint" =
    let open Nativeint in
    let numbers =
      [ 0n (* Int.num_bits *)
      ; 1n (* Int.num_bits - 1 *)
      ; 7n (* Int.num_bits - 3  *)
      ; max_value
      ; min_value
      ; -1n
      ]
    in
    let f =
      test
        (module Nativeint.Hex)
        (module Nativeint)
        ~op:I.Nativeint.count_leading_zeros
        ~name:"clz"
    in
    List.iter ~f numbers;
    [%expect
      {|
      clz 0x0 = 64
      clz 0x1 = 63
      clz 0x7 = 61
      clz 0x7fff_ffff_ffff_ffff = 1
      clz -0x8000_0000_0000_0000 = 0
      clz -0x1 = 0
      |}]
  ;;
end

module%test [@tags "32-bits-only", "js-only"] Arch32 = struct
  let%expect_test "clz int" =
    let open Int in
    let numbers =
      [ 0 (* Int.num_bits *)
      ; 1 (* Int.num_bits - 1 *)
      ; 7 (* Int.num_bits - 3  *)
      ; max_value
      ; min_value
      ; -1
      ]
    in
    let f =
      test (module Int.Hex) (module Int) ~op:I.Int.count_leading_zeros ~name:"clz"
    in
    List.iter ~f numbers;
    [%expect
      {|
      clz 0x0 = 31
      clz 0x1 = 30
      clz 0x7 = 28
      clz 0x3fff_ffff = 1
      clz -0x4000_0000 = 0
      clz -0x1 = 0
      |}];
    let f =
      test (module Int.Hex) (module Int) ~op:I.Int.count_leading_zeros2 ~name:"clz2"
    in
    List.iter ~f numbers;
    [%expect
      {|
      clz2 0x0 = 31
      clz2 0x1 = 30
      clz2 0x7 = 28
      clz2 0x3fff_ffff = 1
      clz2 -0x4000_0000 = 0
      clz2 -0x1 = 0
      |}]
  ;;

  let%expect_test "clz nativeint" =
    let open Nativeint in
    let numbers =
      [ 0n (* Int.num_bits *)
      ; 1n (* Int.num_bits - 1 *)
      ; 7n (* Int.num_bits - 3  *)
      ; max_value
      ; min_value
      ; -1n
      ]
    in
    let f =
      test
        (module Nativeint.Hex)
        (module Nativeint)
        ~op:I.Nativeint.count_leading_zeros
        ~name:"clz"
    in
    List.iter ~f numbers;
    [%expect
      {|
      clz 0x0 = 32
      clz 0x1 = 31
      clz 0x7 = 29
      clz 0x7fff_ffff = 1
      clz -0x8000_0000 = 0
      clz -0x1 = 0
      |}]
  ;;
end

#include <stdint.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>

#include <caml/alloc.h>
#include <caml/mlvalues.h>

intnat caml_csel_int_untagged(value v_cond, intnat ifso, intnat ifnot) {
  return (Bool_val(v_cond) ? ifso : ifnot);
}

uint64_t caml_csel_int64_unboxed(value v_cond, uint64_t ifso, uint64_t ifnot) {
  return (Bool_val(v_cond) ? ifso : ifnot);
}

uint32_t caml_csel_int32_unboxed(value v_cond, uint32_t ifso, uint32_t ifnot) {
  return (Bool_val(v_cond) ? ifso : ifnot);
}

intnat caml_csel_nativeint_unboxed(value v_cond, intnat ifso, intnat ifnot) {
  return (Bool_val(v_cond) ? ifso : ifnot);
}

value caml_csel_value(value v_cond, value v_true, value v_false) {
  return (Bool_val(v_cond) ? v_true : v_false);
}

// The following stubs are also implemented in the OxCaml runtime, so are defined as weak
// symbols here. They will only be used when building with the upstream OCaml compiler.

CAMLweakdef double caml_simd_float64_min(double x, double y) { return x < y ? x : y; }

CAMLweakdef value caml_simd_float64_min_bytecode(value x, value y) {
  return caml_copy_double(caml_simd_float64_min(Double_val(x), Double_val(y)));
}

CAMLweakdef double caml_simd_float64_max(double x, double y) { return x > y ? x : y; }

CAMLweakdef value caml_simd_float64_max_bytecode(value x, value y) {
  return caml_copy_double(caml_simd_float64_max(Double_val(x), Double_val(y)));
}

#if defined(__GNUC__) && !defined(__llvm__)
__attribute__((optimize("no-math-errno")))
#endif
CAMLweakdef int64_t
caml_simd_cast_float64_int64(double x) {
  return llrint(x);
}

CAMLweakdef value caml_simd_cast_float64_int64_bytecode(value x) {
  return caml_copy_int64(caml_simd_cast_float64_int64(Double_val(x)));
}

CAMLweakdef double caml_simd_float64_round_current(double f) { return rint(f); }

CAMLweakdef value caml_simd_float64_round_current_bytecode(value f) {
  return caml_copy_double(caml_simd_float64_round_current(Double_val(f)));
}

CAMLweakdef double caml_simd_float64_round_neg_inf(double f) { return floor(f); }

CAMLweakdef value caml_simd_float64_round_neg_inf_bytecode(value f) {
  return caml_copy_double(caml_simd_float64_round_neg_inf(Double_val(f)));
}

CAMLweakdef double caml_simd_float64_round_pos_inf(double f) { return ceil(f); }

CAMLweakdef value caml_simd_float64_round_pos_inf_bytecode(value f) {
  return caml_copy_double(caml_simd_float64_round_pos_inf(Double_val(f)));
}

CAMLweakdef double caml_simd_float64_round_towards_zero(double f) { return trunc(f); }

CAMLweakdef value caml_simd_float64_round_towards_zero_bytecode(value f) {
  return caml_copy_double(caml_simd_float64_round_towards_zero(Double_val(f)));
}

// The following stubs are never used: in OxCaml native code (both amd64 and arm64), they
// are builtins, and otherwise we use OCaml implementations.

#define BUILTIN(name)                                                                    \
  void name() {                                                                          \
    assert(!"Didn't use [@@builtin] intrinsic.");                                        \
    abort();                                                                             \
  }

BUILTIN(caml_int_clz)
BUILTIN(caml_int_clz_tagged_to_untagged)
BUILTIN(caml_int_clz_untagged_to_untagged)
BUILTIN(caml_int_ctz)
BUILTIN(caml_int_ctz_untagged_to_untagged)
BUILTIN(caml_int_popcnt)
BUILTIN(caml_int_popcnt_tagged_to_untagged)
BUILTIN(caml_int_popcnt_untagged_to_untagged)

BUILTIN(caml_int32_clz)
BUILTIN(caml_int32_clz_unboxed_to_untagged)
BUILTIN(caml_int32_clz_nonzero_unboxed_to_untagged)
BUILTIN(caml_int32_ctz)
BUILTIN(caml_int32_ctz_unboxed_to_untagged)
BUILTIN(caml_int32_ctz_nonzero_unboxed_to_untagged)
BUILTIN(caml_int32_popcnt)
BUILTIN(caml_int32_popcnt_unboxed_to_untagged)
BUILTIN(caml_int32_shift_left_by_int32)
BUILTIN(caml_int32_shift_left_by_int32_unboxed)
BUILTIN(caml_int32_shift_right_by_int32)
BUILTIN(caml_int32_shift_right_by_int32_unboxed)
BUILTIN(caml_int32_shift_right_logical_by_int32)
BUILTIN(caml_int32_shift_right_logical_by_int32_unboxed)

BUILTIN(caml_int64_clz)
BUILTIN(caml_int64_clz_unboxed_to_untagged)
BUILTIN(caml_int64_clz_nonzero_unboxed_to_untagged)
BUILTIN(caml_int64_ctz)
BUILTIN(caml_int64_ctz_unboxed_to_untagged)
BUILTIN(caml_int64_ctz_nonzero_unboxed_to_untagged)
BUILTIN(caml_int64_popcnt)
BUILTIN(caml_int64_popcnt_unboxed_to_untagged)
BUILTIN(caml_int64_shift_left_by_int64)
BUILTIN(caml_int64_shift_left_by_int64_unboxed)
BUILTIN(caml_int64_shift_right_by_int64)
BUILTIN(caml_int64_shift_right_by_int64_unboxed)
BUILTIN(caml_int64_shift_right_logical_by_int64)
BUILTIN(caml_int64_shift_right_logical_by_int64_unboxed)

BUILTIN(caml_nativeint_clz)
BUILTIN(caml_nativeint_clz_unboxed_to_untagged)
BUILTIN(caml_nativeint_clz_nonzero_unboxed_to_untagged)
BUILTIN(caml_nativeint_ctz)
BUILTIN(caml_nativeint_ctz_unboxed_to_untagged)
BUILTIN(caml_nativeint_ctz_nonzero_unboxed_to_untagged)
BUILTIN(caml_nativeint_popcnt)
BUILTIN(caml_nativeint_popcnt_unboxed_to_untagged)
BUILTIN(caml_nativeint_shift_left_by_nativeint)
BUILTIN(caml_nativeint_shift_left_by_nativeint_unboxed)
BUILTIN(caml_nativeint_shift_right_by_nativeint)
BUILTIN(caml_nativeint_shift_right_by_nativeint_unboxed)
BUILTIN(caml_nativeint_shift_right_logical_by_nativeint)
BUILTIN(caml_nativeint_shift_right_logical_by_nativeint_unboxed)

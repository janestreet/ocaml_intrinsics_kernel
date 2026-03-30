//Provides: caml_csel_value
function caml_csel_value(v_cond, v_true, v_false) {
  if (v_cond)
    return v_true;
  else
    return v_false;
}

//Provides: caml_simd_float64_min_bytecode
function caml_simd_float64_min_bytecode(x, y) {
  return x < y ? x : y;
}

//Provides: caml_simd_float64_max_bytecode
function caml_simd_float64_max_bytecode(x, y) {
  return x > y ? x : y;
}

//Provides: caml_simd_cast_float64_int64_bytecode const
//Requires: caml_int64_of_float, caml_round_float
function caml_simd_cast_float64_int64_bytecode(x) {
  return caml_int64_of_float(caml_round_float(x));
}

//Provides: caml_simd_float64_round_current_bytecode const
//Requires: caml_round_float
function caml_simd_float64_round_current_bytecode(x) {
  return caml_round_float(x);
}

//Provides: caml_simd_float64_round_neg_inf_bytecode const
function caml_simd_float64_round_neg_inf_bytecode(x) {
  return Math.floor(x);
}

//Provides: caml_simd_float64_round_pos_inf_bytecode const
function caml_simd_float64_round_pos_inf_bytecode(x) {
  return Math.ceil(x);
}

//Provides: caml_simd_float64_round_towards_zero_bytecode const
function caml_simd_float64_round_towards_zero_bytecode(x) {
  return Math.trunc(x);
}

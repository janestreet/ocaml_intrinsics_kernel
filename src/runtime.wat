(module
   (import "env" "Double_val"
      (func $Double_val (param (ref eq)) (result f64)))
   (import "env" "caml_copy_int64"
        (func $caml_copy_int64 (param i64) (result (ref eq))))

   (type $float (struct (field f64)))
   (func $unbox_float
      (param $f (ref eq)) (result f64)
      (struct.get $float 0 (ref.cast (ref $float) (local.get $f))))

   (func (export "caml_csel_value")
      (param $cond (ref eq)) (param $true (ref eq)) (param $false (ref eq))
      (result (ref eq))
      (select (local.get $true) (local.get $false)
         (i31.get_s (ref.cast (ref i31) (local.get $cond)))))

   (func (export "caml_sse2_float64_min_bytecode")
      (param $x (ref eq)) (param $y (ref eq)) (result (ref eq))
      (select (local.get $x) (local.get $y)
         (f64.lt (call $Double_val (local.get $x))
                 (call $Double_val (local.get $y)))))

   (func (export "caml_sse2_float64_max_bytecode")
      (param $x (ref eq)) (param $y (ref eq)) (result (ref eq))
      (select (local.get $x) (local.get $y)
         (f64.gt (call $Double_val (local.get $x))
                 (call $Double_val (local.get $y)))))

   (func (export "caml_sse2_cast_float64_int64_bytecode")
      (param $f (ref eq)) (result (ref eq))
      (call $caml_copy_int64
         (i64.trunc_sat_f64_s (f64.nearest (call $unbox_float (local.get $f))))))
)

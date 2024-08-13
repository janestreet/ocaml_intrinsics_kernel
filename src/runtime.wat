(module
   (import "env" "Double_val"
      (func $Double_val (param (ref eq)) (result f64)))

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
)

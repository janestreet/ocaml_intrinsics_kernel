#include <caml/mlvalues.h>

CAMLprim CAMLweakdef value caml_csel_value(value v_cond, value v_true, value v_false)
{
    return (Bool_val(v_cond) ? v_true : v_false);
}

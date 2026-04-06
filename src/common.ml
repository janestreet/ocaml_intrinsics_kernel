let available =
  match Sys.backend_type with
  | Native -> true
  | Bytecode | Other _ -> false
;;

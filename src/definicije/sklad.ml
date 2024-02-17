type t = Prazen | Sestavljen of int * t

let nov_sklad stevilo = Sestavljen (stevilo, Prazen)
let trenutni_znak = function
  | Prazen -> None
  | Sestavljen (znak, _) -> Some znak

let je_na_koncu sklad = (sklad = Prazen)

let pop = function
  | Prazen -> None
  | Sestavljen (_, sklad) -> Some sklad

let push vnos sklad = Sestavljen (vnos, sklad)


(* let b = Sestavljen (3, Sestavljen (2, Sestavljen (1,Sestavljen (0, Prazen)))) *)
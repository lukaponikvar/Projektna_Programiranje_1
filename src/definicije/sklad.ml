type t = Prazen | Sestavljen of int * t

let nov_sklad stevilo = Sestavljen (stevilo, Prazen)
let trenutni_znak = function
  | Prazen -> None
  | Sestavljen (znak, _) -> Some znak

(* let je_na_koncu sklad = (sklad = Prazen) *)

(* let pop = function
  | Prazen -> None
  | Sestavljen (_, sklad) -> Some sklad *)

let push sklad vnos = Sestavljen (vnos, sklad)

let zamenjaj_na_skladu sez = function
  | Prazen -> Prazen (* ne bo nikoli prazen, torej je vseeno *)
  | Sestavljen (_, sklad) -> List.fold_left push sklad sez 


(* let b = Sestavljen (3, Sestavljen (2, Sestavljen (1,Sestavljen (0, Prazen)))) *)
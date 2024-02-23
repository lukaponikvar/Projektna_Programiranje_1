type t = Prazen | Sestavljen of int * t

let nov_sklad stevilo = Sestavljen (stevilo, Prazen)

let trenutni_znak = function
  | Prazen -> None
  | Sestavljen (znak, _) -> Some znak

let push sklad vnos = Sestavljen (vnos, sklad)

let zamenjaj_na_skladu sez = function
  | Prazen -> Prazen (* ne bo nikoli prazen, torej je vseeno *)
  | Sestavljen (_, sklad) -> List.fold_left push sklad sez 
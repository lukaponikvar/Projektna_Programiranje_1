type stanje = Stanje.t
type sklad = Sklad.t

type t = {
  stanja : stanje list;
  zacetno_stanje : stanje;
  sprejemna_stanja : stanje list;
  prehodi : ( stanje * int * char * stanje * int list ) list;
  prazni_prehodi : ( stanje * int * stanje * int list ) list;
  sklad : sklad;
  zacetni_sklad: sklad;
}

let prazen_avtomat zacetno_stanje sklad =
  {
    stanja = [ zacetno_stanje ];
    zacetno_stanje;
    sprejemna_stanja = [];
    prehodi = [];
    prazni_prehodi = [];
    sklad = sklad;
    zacetni_sklad = sklad;
  }

let dodaj_nesprejemno_stanje stanje avtomat =
  { avtomat with stanja = stanje :: avtomat.stanja }

let dodaj_sprejemno_stanje stanje avtomat =
  {
    avtomat with
    stanja = stanje :: avtomat.stanja;
    sprejemna_stanja = stanje :: avtomat.sprejemna_stanja;
  }

let dodaj_prehod stanje1 znak_na_skladu1 znak stanje2 (znaki_na_skladu2 : int list) avtomat =
  { avtomat with prehodi = (stanje1, znak_na_skladu1, znak, stanje2, znaki_na_skladu2) :: avtomat.prehodi }

let dodaj_prazen_prehod stanje1 znak_na_skladu1 stanje2 (znaki_na_skladu2 : int list) avtomat =
  { avtomat with prazni_prehodi = (stanje1, znak_na_skladu1, stanje2, znaki_na_skladu2) :: avtomat.prazni_prehodi }

(* let prehodna_funkcija avtomat stanje znak_na_skladu znak =
  match
    List.find_opt
      (fun (stanje1, znak_na_skladu1, znak', _stanje2, _znaki_na_skladu2) -> stanje1 = stanje && znak = znak' && znak_na_skladu1 = znak_na_skladu)
      avtomat.prehodi
  with
  | Some (_, _, _, stanje2, _) -> Some stanje2
  | None -> (
    match
    List.find_opt
      (fun (stanje1, znak_na_skladu1, _stanje2, _znaki_na_skladu2) -> stanje1 = stanje && znak_na_skladu1 = znak_na_skladu)
      avtomat.prazni_prehodi
  with
  | Some (_, _, stanje2, _) -> Some stanje2
  | None -> None
  ) *)

let prehodna_funkcija avtomat stanje znak_na_skladu znak =
  match
  List.find_opt
    (fun (stanje1, znak_na_skladu1, znak', _stanje2, _znaki_na_skladu2) -> stanje1 = stanje && znak = znak' && znak_na_skladu1 = znak_na_skladu)
    avtomat.prehodi
  with
  | Some (_, _, _, stanje2, _) -> Some stanje2
  | None -> None

let prehodna_funkcija_brez_znaka avtomat stanje znak_na_skladu =
  match
  List.find_opt
      (fun (stanje1, znak_na_skladu1, _stanje2, _znaki_na_skladu2) -> stanje1 = stanje && znak_na_skladu1 = znak_na_skladu)
      avtomat.prazni_prehodi
  with
  | Some (_, _, stanje2, _) -> Some stanje2
  | None -> None

(* let prehodna_funkcija_za_sklad avtomat stanje znak_na_skladu znak =
  match
    List.find_opt
      (fun (stanje1, znak_na_skladu1, znak', _stanje2, _znaki_na_skladu2) -> stanje1 = stanje && znak = znak' && znak_na_skladu1 = znak_na_skladu)
      avtomat.prehodi
  with
  | Some (_, _, _, _, znaki_na_skladu2) -> znaki_na_skladu2
  | None -> (
    match
    List.find_opt
      (fun (stanje1, znak_na_skladu1, _stanje2, _znaki_na_skladu2) -> stanje1 = stanje && znak_na_skladu1 = znak_na_skladu)
      avtomat.prazni_prehodi
  with
  | Some (_, _, _, znaki_na_skladu2) -> znaki_na_skladu2
  | None -> []
  ) *)
let prehodna_funkcija_za_sklad avtomat stanje znak_na_skladu znak =
  match
    List.find_opt
      (fun (stanje1, znak_na_skladu1, znak', _stanje2, _znaki_na_skladu2) -> stanje1 = stanje && znak = znak' && znak_na_skladu1 = znak_na_skladu)
      avtomat.prehodi
  with
  | Some (_, _, _, _, znaki_na_skladu2) -> znaki_na_skladu2
  | None -> []


let prehodna_funkcija_za_sklad_brez_znaka avtomat stanje znak_na_skladu =
  match
    List.find_opt
      (fun (stanje1, znak_na_skladu1, _stanje2, _znaki_na_skladu2) -> stanje1 = stanje && znak_na_skladu1 = znak_na_skladu)
      avtomat.prazni_prehodi
  with
  | Some (_, _, _, znaki_na_skladu2) -> znaki_na_skladu2
  | None -> []

let zacetno_stanje avtomat = avtomat.zacetno_stanje
let seznam_stanj avtomat = avtomat.stanja
let seznam_prehodov avtomat = avtomat.prehodi
let seznam_praznih_prehodov avtomat = avtomat.prazni_prehodi
let sklad avtomat = avtomat.sklad
let zacetni_sklad avtomat = avtomat.zacetni_sklad

let je_sprejemno_stanje avtomat stanje =
  List.mem stanje avtomat.sprejemna_stanja

let enke_1mod3 =
  let q0 = Stanje.iz_niza "q0"
  and q1 = Stanje.iz_niza "q1"
  and q2 = Stanje.iz_niza "q2" in
  prazen_avtomat q0 (Sklad.nov_sklad 2)
  |> dodaj_sprejemno_stanje q1
  |> dodaj_nesprejemno_stanje q2
  |> dodaj_prehod q0 2 '0' q0 [2]
  |> dodaj_prehod q1 2 '0' q1 [2]
  |> dodaj_prehod q2 2 '0' q2 [2]
  |> dodaj_prehod q0 2 '1' q1 [2]
  |> dodaj_prehod q1 2 '1' q2 [2]
  |> dodaj_prehod q2 2 '1' q0 [2]
let dpda_enako_stevilo_nicel_in_enk =
  let q1 = Stanje.iz_niza "q1"
  and q2 = Stanje.iz_niza "q2"
  and q3 = Stanje.iz_niza "q3" 
  and q4 = Stanje.iz_niza "q4" in
  prazen_avtomat q1 (Sklad.nov_sklad 2)
  |> dodaj_nesprejemno_stanje q2
  |> dodaj_nesprejemno_stanje q3
  |> dodaj_sprejemno_stanje q4
  |> dodaj_prehod q1 2 '0' q2 [2; 0]
  |> dodaj_prehod q2 0 '0' q2 [0; 0]
  |> dodaj_prehod q2 0 '1' q3 []
  |> dodaj_prehod q3 0 '1' q3 []
  |> dodaj_prazen_prehod q3 2 q4 [2;]

let preberi_niz avtomat zacetno_stanje zacetni_sklad niz =
  let rec aux acc znak =
    match acc with 
    | None -> None 
    | Some (stanje', sklad') -> 
        let trenutni_znak_na_skladu = (Option.get (Sklad.trenutni_znak sklad')) in
        let mozno_novo_stanje = prehodna_funkcija_brez_znaka avtomat stanje' trenutni_znak_na_skladu in 
          if mozno_novo_stanje <> None then
            let znaki = prehodna_funkcija_za_sklad_brez_znaka avtomat stanje' trenutni_znak_na_skladu in
              aux (Some (Option.get mozno_novo_stanje, Sklad.zamenjaj_na_skladu znaki sklad')) znak
          else match prehodna_funkcija avtomat stanje' trenutni_znak_na_skladu znak with
            | None -> None
            | Some stanje'' -> let znaki' = prehodna_funkcija_za_sklad avtomat stanje' trenutni_znak_na_skladu znak in
              Some(stanje'', Sklad.zamenjaj_na_skladu znaki' sklad')          
  in
  let rec pred_koncem avtomat = function
    | None -> None
    | Some (stanje', sklad') -> 
      (
        let trenutni_znak_na_skladu = (Option.get (Sklad.trenutni_znak sklad')) in
        let mozno_novo_stanje = prehodna_funkcija_brez_znaka avtomat stanje' trenutni_znak_na_skladu in 
          if mozno_novo_stanje <> None 
            then let znaki = prehodna_funkcija_za_sklad_brez_znaka avtomat stanje' trenutni_znak_na_skladu in
              pred_koncem avtomat (Some (Option.get mozno_novo_stanje, Sklad.zamenjaj_na_skladu znaki sklad'))
            else Some (stanje', sklad')
      ) 
        in
  pred_koncem avtomat (niz |> String.to_seq |> Seq.fold_left aux (Some (zacetno_stanje, zacetni_sklad)))

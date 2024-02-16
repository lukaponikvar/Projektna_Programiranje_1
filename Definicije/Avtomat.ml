type stanje = Stanje.t
type sklad = Sklad.t

type t = {
  stanja : stanje list;
  zacetno_stanje : stanje;
  sprejemna_stanja : stanje list;
  prehodi : (stanje * sklad * char * stanje * sklad) list;
  sklad : sklad;
}

let prazen_avtomat zacetno_stanje =
  {
    stanja = [ zacetno_stanje ];
    zacetno_stanje;
    sprejemna_stanja = [];
    prehodi = [];
    sklad = Prazen;
  }

let dodaj_nesprejemno_stanje stanje avtomat =
  { avtomat with stanja = stanje :: avtomat.stanja }

let dodaj_sprejemno_stanje stanje avtomat =
  {
    avtomat with
    stanja = stanje :: avtomat.stanja;
    sprejemna_stanja = stanje :: avtomat.sprejemna_stanja;
  }


let dodaj_prehod stanje1 sklad1 znak stanje2 sklad2 avtomat =
  { avtomat with prehodi = (stanje1, sklad1, znak, stanje2, sklad2) :: avtomat.prehodi }
  
let prehodna_funkcija avtomat stanje sklad znak =
  match
    List.find_opt
      (fun (stanje1, sklad1, znak', _stanje2, _sklad2) -> stanje1 = stanje && znak = znak' && sklad1 = sklad)
      avtomat.prehodi
  with
  | None -> None
  | Some (_, _, _, stanje2, sklad2) -> Some (stanje2, sklad2)

let zacetno_stanje avtomat = avtomat.zacetno_stanje
let seznam_stanj avtomat = avtomat.stanja
let seznam_prehodov avtomat = avtomat.prehodi
let sklad avtomat = avtomat.sklad
  
let je_sprejemno_stanje avtomat stanje =
  List.mem stanje avtomat.sprejemna_stanja
  
(* let enke_1mod3 =
  let q0 = Stanje.iz_niza "q0"
  and q1 = Stanje.iz_niza "q1"
  and q2 = Stanje.iz_niza "q2" in
  prazen_avtomat q0 |> dodaj_sprejemno_stanje q1
  |> dodaj_nesprejemno_stanje q2
  |> dodaj_prehod q0 '0' q0 |> dodaj_prehod q1 '0' q1 |> dodaj_prehod q2 '0' q2
  |> dodaj_prehod q0 '1' q1 |> dodaj_prehod q1 '1' q2 |> dodaj_prehod q2 '1' q0 *)

let preberi_niz avtomat stanje niz =
  let aux acc znak =
    match acc with None -> None | Some stanje -> prehodna_funkcija avtomat stanje znak
  in
  niz |> String.to_seq |> Seq.fold_left aux (Some q)
  
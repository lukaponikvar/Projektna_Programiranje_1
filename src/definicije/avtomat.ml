type stanje = Stanje.t
type sklad = Sklad.t

type t = {
  stanja : stanje list;
  zacetno_stanje : stanje;
  sprejemna_stanja : stanje list;
  prehodi : (( stanje * int * char * stanje * int list ) list *
            ( stanje * int * stanje * int list ) list);
  sklad : sklad;
  zacetni_sklad: sklad;
  opis : string;
}

let prazen_avtomat zacetno_stanje sklad opis =
  {
    stanja = [ zacetno_stanje ];
    zacetno_stanje;
    sprejemna_stanja = [];
    prehodi = ([], []);
    sklad = sklad;
    zacetni_sklad = sklad;
    opis = opis;
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
  { avtomat with prehodi = ((stanje1, znak_na_skladu1, znak, stanje2, znaki_na_skladu2) :: (fst avtomat.prehodi), snd avtomat.prehodi) }

let dodaj_prazen_prehod stanje1 znak_na_skladu1 stanje2 (znaki_na_skladu2 : int list) avtomat =
  { avtomat with prehodi = (fst avtomat.prehodi, (stanje1, znak_na_skladu1, stanje2, znaki_na_skladu2) :: (snd avtomat.prehodi)) }

let prehodna_funkcija avtomat znak (stanje, sklad) =
  let znak_na_skladu = Option.get (Sklad.trenutni_znak sklad) in
  let rec pomozna acc = function
  | [] -> acc
  | (_, _, _, novo_stanje, novi_del_sklada) :: rep -> pomozna ((novo_stanje, Sklad.zamenjaj_na_skladu novi_del_sklada sklad) :: acc) rep in
  pomozna [] (
    List.filter
    (fun (stanje1, znak_na_skladu1, znak', _stanje2, _znaki_na_skladu2) -> stanje1 = stanje && znak = znak' && znak_na_skladu1 = znak_na_skladu)
    (fst avtomat.prehodi)
  )

let prazna_prehodna_funkcija avtomat (stanje, sklad) =
  let znak_na_skladu = Option.get (Sklad.trenutni_znak sklad) in
  let rec pomozna acc = function
  | [] -> acc
  | (_, _, novo_stanje, novi_del_sklada) :: rep -> pomozna ((novo_stanje, Sklad.zamenjaj_na_skladu novi_del_sklada sklad) :: acc) rep in
  pomozna [] (
    List.filter
    (fun (stanje1, znak_na_skladu1, _stanje2, _znaki_na_skladu2) -> stanje1 = stanje && znak_na_skladu1 = znak_na_skladu)
    (snd avtomat.prehodi)
  )

let zacetno_stanje avtomat = avtomat.zacetno_stanje
let seznam_stanj avtomat = avtomat.stanja
let sklad avtomat = avtomat.sklad
let zacetni_sklad avtomat = avtomat.zacetni_sklad
let opis avtomat = avtomat.opis

let je_sprejemno_stanje avtomat stanje =
  List.mem stanje avtomat.sprejemna_stanja

let npda_enako_stevilo_nicel_kot_enk_ali_dvojk = 
  let q1 = Stanje.iz_niza "q1"
  and q2 = Stanje.iz_niza "q2"
  and q3 = Stanje.iz_niza "q3"
  and q4 = Stanje.iz_niza "q4"
  and q5 = Stanje.iz_niza "q5" 
  and q6 = Stanje.iz_niza "q6" in
  let opis = "Avtomat preveri ali v danem nizu iz ničel, enk in dvojk, v danem vrstnem redu, velja enakost med številom 
  ničel in dvojk ali pa med številom ničel in enic." in
  prazen_avtomat q1 (Sklad.nov_sklad 3) opis
  |> dodaj_nesprejemno_stanje q2
  |> dodaj_sprejemno_stanje q3
  |> dodaj_nesprejemno_stanje q4
  |> dodaj_nesprejemno_stanje q5
  |> dodaj_sprejemno_stanje q6
  |> dodaj_prehod q1 3 '0' q1 [3; 0]
  |> dodaj_prehod q1 0 '0' q1 [0; 0]
  |> dodaj_prehod q1 0 '1' q2 []
  |> dodaj_prehod q2 0 '1' q2 []
  |> dodaj_prehod q2 3 '2' q3 [3]
  |> dodaj_prehod q3 3 '2' q3 [3]
  |> dodaj_prehod q1 0 '1' q4 [0]
  |> dodaj_prehod q1 0 '2' q5 []
  |> dodaj_prehod q4 0 '1' q4 [0]
  |> dodaj_prehod q4 3 '1' q4 [3]
  |> dodaj_prehod q4 0 '2' q5 []
  |> dodaj_prehod q5 0 '2' q5 []
  |> dodaj_prazen_prehod q1 3 q2 [3]
  |> dodaj_prazen_prehod q2 3 q3 [3]
  |> dodaj_prazen_prehod q1 3 q4 [3]
  |> dodaj_prazen_prehod q4 3 q5 [3]
  |> dodaj_prazen_prehod q5 3 q6 [3]



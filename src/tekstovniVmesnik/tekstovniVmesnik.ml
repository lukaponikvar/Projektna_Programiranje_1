open Definicije
open Avtomat

type stanje_vmesnika =
  | SeznamMoznosti
  | IzpisAvtomata
  | OpisAvtomata
  | BranjeNiza
  | RezultatPrebranegaNiza
  | OpozoriloONapacnemNizu
  | VrniVIzhodiscnoStanje

type model = {
  avtomat : Avtomat.t;
  stanje_avtomata : Stanje.t;
  stanje_sklada : Sklad.t;
  stanje_vmesnika : stanje_vmesnika;
}

type msg = PreberiNiz of string | ZamenjajVmesnik of stanje_vmesnika

let update model = function
  | PreberiNiz str ->
     (let seznam = Avtomat.preberi_niz model.avtomat model.stanje_avtomata model.stanje_sklada str in
     let seznamcek = List.filter (fun (stanje', _) -> (je_sprejemno_stanje model.avtomat stanje')) seznam in
      match (seznam, seznamcek) with
      | [], _ -> { model with stanje_vmesnika = OpozoriloONapacnemNizu }
      | ((stanje_avtomata, stanje_sklada) :: _, []) ->
          {
            model with
            stanje_avtomata;
            stanje_sklada;
            stanje_vmesnika = RezultatPrebranegaNiza;
          }
      | (_, (stanje_avtomata, stanje_sklada) :: _) -> 
            {
            model with
            stanje_avtomata;
            stanje_sklada;
            stanje_vmesnika = RezultatPrebranegaNiza;
          })
  | ZamenjajVmesnik stanje_vmesnika -> if stanje_vmesnika = VrniVIzhodiscnoStanje then { avtomat = model.avtomat; stanje_avtomata = zacetno_stanje model.avtomat; stanje_sklada = zacetni_sklad model.avtomat; stanje_vmesnika }
      else { model with stanje_vmesnika }

let rec izpisi_moznosti () =
  print_endline "1) Izpiši avtomat";
  print_endline "2) Opis avtomata";
  print_endline "3) Preveri niz";
  print_string "> ";
  match read_line () with
  | "1" -> ZamenjajVmesnik IzpisAvtomata
  | "2" -> ZamenjajVmesnik OpisAvtomata
  | "3" -> ZamenjajVmesnik BranjeNiza
  | _ ->
      print_endline "** VNESI 1 ALI 2 **";
      izpisi_moznosti ()

let izpisi_avtomat avtomat =
  let izpisi_stanje stanje =
    let prikaz = Stanje.v_niz stanje in
    let prikaz =
      if stanje = zacetno_stanje avtomat then "-> " ^ prikaz else "   " ^ prikaz
    in
    let prikaz =
      if je_sprejemno_stanje avtomat stanje then prikaz ^ " +" else prikaz
    in
    print_endline prikaz
  in
  print_endline "Avtomat ima naslednjo strukturo:\n- Začetno stanje: ->\n- Sprejemna stanja: + \n___________";
  List.iter izpisi_stanje (List.rev (seznam_stanj avtomat));
  print_endline "___________\n "

let opisi_avtomat avtomat = 
  print_endline (opis avtomat)

let beri_niz _model =
  print_string "Vnesi niz > ";
  let str = read_line () in
  PreberiNiz str

let izpisi_rezultat model =
  if je_sprejemno_stanje model.avtomat model.stanje_avtomata then
    print_endline "Niz je bil sprejet"
  else print_endline "Niz ni bil sprejet"

let view model =
  match model.stanje_vmesnika with
  | SeznamMoznosti -> izpisi_moznosti ()
  | IzpisAvtomata ->
      izpisi_avtomat model.avtomat;
      ZamenjajVmesnik SeznamMoznosti
  |OpisAvtomata ->
    opisi_avtomat model.avtomat;
    ZamenjajVmesnik SeznamMoznosti
  | BranjeNiza -> beri_niz model
  | RezultatPrebranegaNiza ->
      izpisi_rezultat model;
      ZamenjajVmesnik VrniVIzhodiscnoStanje
  | OpozoriloONapacnemNizu ->
      print_endline "Niz ni veljaven";
      ZamenjajVmesnik VrniVIzhodiscnoStanje
  | VrniVIzhodiscnoStanje ->
    ZamenjajVmesnik SeznamMoznosti

let init avtomat =
  {
    avtomat;
    stanje_avtomata = zacetno_stanje avtomat;
    stanje_sklada = sklad avtomat;
    stanje_vmesnika = SeznamMoznosti;
  }

let rec loop model =
  let msg = view model in
  let model' = update model msg in
  loop model'

let _ = loop (init npda_enako_stevilo_nicel_kot_enk_ali_dvojk)

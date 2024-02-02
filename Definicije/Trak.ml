type trak = {niz : string; indeks_trenutnega_znaka : int}

let trenutni_znak trak = trak.niz.[trak.indeks_trenutnega_znaka]

let je_na_koncu trak = String.length trak.niz = trak.indeks_trenutnega_znaka + 1

let premakni_naprej trak = if je_na_koncu trak then trak else {trak with indeks_trenutnega_znaka = trak.indeks_trenutnega_znaka + 1}

let iz_niza niz = { niz; indeks_trenutnega_znaka = 0 }

let prazen = iz_niza ""

let v_niz trak = trak.niz

let prebrani trak = String.sub trak.niz 0 trak.indeks_trenutnega_znaka

let neprebrani trak =
  String.sub trak.niz trak.indeks_trenutnega_znaka
    (String.length trak.niz - trak.indeks_trenutnega_znaka)

type t

val prazen_avtomat : Stanje.t -> Sklad.t -> t
val dodaj_nesprejemno_stanje : Stanje.t -> t -> t
val dodaj_sprejemno_stanje : Stanje.t -> t -> t
val dodaj_prehod : Stanje.t -> Sklad.t -> char -> Stanje.t -> Sklad.t -> t -> t
val prehodna_funkcija : t -> Stanje.t -> Sklad.t -> char -> (Stanje.t * Sklad.t) option
val zacetno_stanje : t -> Stanje.t
val seznam_stanj : t -> Stanje.t list
val seznam_prehodov : t -> (Stanje.t * char * Stanje.t) list
val sklad : t -> Sklad.t
val je_sprejemno_stanje : t -> Stanje.t -> bool
val primer : t
val preberi_niz : t -> Stanje.t -> Sklad.t -> string -> (Stanje.t * Sklad.t) option

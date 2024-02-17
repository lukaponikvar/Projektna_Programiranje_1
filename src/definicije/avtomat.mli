type t

val prazen_avtomat : Stanje.t -> Sklad.t -> t
val dodaj_nesprejemno_stanje : Stanje.t -> t -> t
val dodaj_sprejemno_stanje : Stanje.t -> t -> t
val dodaj_prehod : Stanje.t -> int -> char -> Stanje.t -> int -> t -> t
val prehodna_funkcija : t -> Stanje.t -> int -> char -> (Stanje.t) option
val prehodna_funkcija_za_sklad : t -> Stanje.t -> int -> char -> int
val zacetno_stanje : t -> Stanje.t
val seznam_stanj : t -> Stanje.t list
val seznam_prehodov : t -> (Stanje.t * int * char * Stanje.t * int ) list
val sklad : t -> Sklad.t
val je_sprejemno_stanje : t -> Stanje.t -> bool
val enke_1mod3 : t
val preberi_niz : t -> Stanje.t -> Sklad.t -> string -> (Stanje.t * Sklad.t) option

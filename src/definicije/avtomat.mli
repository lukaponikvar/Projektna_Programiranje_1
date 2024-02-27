type t

val prazen_avtomat : Stanje.t -> int Sklad.t -> string -> t
val dodaj_nesprejemno_stanje : Stanje.t -> t -> t
val dodaj_sprejemno_stanje : Stanje.t -> t -> t
val dodaj_prehod : Stanje.t -> int -> char -> Stanje.t -> int list -> t -> t
val dodaj_prazen_prehod : Stanje.t -> int -> Stanje.t -> int list -> t -> t
val prehodna_funkcija : t -> char -> (Stanje.t * int Sklad.t) -> (Stanje.t * int Sklad.t) list
val prazna_prehodna_funkcija : t -> (Stanje.t * int Sklad.t) -> (Stanje.t * int Sklad.t) list
val zacetno_stanje : t -> Stanje.t
val seznam_stanj : t -> Stanje.t list
val sklad : t -> int Sklad.t
val zacetni_sklad : t -> int Sklad.t
val opis : t -> string
val je_sprejemno_stanje : t -> Stanje.t -> bool
val npda_enako_stevilo_nicel_kot_enk_ali_dvojk : t


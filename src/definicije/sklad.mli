type t

val trenutni_znak : t -> int option
val push : t -> int -> t
val nov_sklad : int -> t
val zamenjaj_na_skladu : int list -> t -> t
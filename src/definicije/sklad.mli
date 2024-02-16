type t

val trenutni_znak : t -> int option
val je_na_koncu : t -> bool
val pop : t -> t option
val push : int -> t -> t
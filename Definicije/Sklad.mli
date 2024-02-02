type 'a t

val trenutni_znak : 'a t -> 'a option
val je_na_koncu : 'a t -> bool
val pop : 'a t -> 'a sklad -> 'a sklad option
val push : 'a -> 'a sklad -> 'a sklad
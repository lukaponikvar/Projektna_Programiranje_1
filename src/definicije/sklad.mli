type 'a t

val trenutni_znak : 'a t -> 'a option
val push : 'a t -> 'a -> 'a t
val nov_sklad : 'a -> 'a t
val zamenjaj_na_skladu : 'a list -> 'a t -> 'a t
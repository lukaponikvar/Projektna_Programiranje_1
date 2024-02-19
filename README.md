# Projektna_Programiranje_1

Osrednji del moje projektne naloge bo implementacija $\underline{\text{nedeterminističnega skladovnega avtomata}}$ (non-deterministic pushdown automaton oz. NPDA). 

## Neformalni opis


Za rezliko od standardnega končnega avtomata ima, kot je razvidno iz imena, skladovni avtomat (pushdown automaton oz. PDA) pridružen še sklad. 

Skladovni avtomat lahko sprejme niz, ki ga bere od leve proti desni. V vsakem koraku lahko prebere le en znak in se nato na podlagi tega znaka, trenutnega stanja in vrhnjega elementa sklada odloči, kakšen prehod naj izvede. V procesu izvajanja prehoda se lahko zgodi več stvari. Avtomat lahko vzame vrhnji element dol s sklada (pop) in nato na sklad položi (push) končno množico znakov iz abecede sklada.

V primeru, da je v neki situaciji možnih več prehodov, govorimo o nedeterminističnem avtomatu. Take avtomate bomo v nadaljevanju bolje spoznali in se, upajmo, z njimi spoprijateljili.

## Definicija

Formalno gledano je nedeterminističen skladovni avtomat definiran kot nabor (7-tuple) $(Q, \Sigma, \Gamma,\delta, q_0, Z_0, F )$, kjer so:

- $Q$ končna množica stanj,
- $\Sigma$ končna množica simbolov imenovana abeceda vnosov (input alphabet),
- $\Gamma$ končna množica simbolov imenovana sbeceda sklada (stack alphabet),
- $\delta : Q \times \Gamma \times (\Sigma \cup \{\varepsilon\}) \to \mathscr{P}(Q \times \Gamma^{*})$ prehodna funkcija,
- $q_0 \in Q$ začetno stanje (start state),
- $Z_0$ $\in \Gamma$ začetni simbol na skladu (initial stack symbol),
- $F \subseteq Q$ množica sprejemnih stanj (accepting states or final states).

Opombe:

- $\Gamma$ in $\Sigma$ nista nujno disjunktni množici, a tega nič ne preprečuje,
- $\varepsilon$ označuje prazen niz,
- $\Gamma^{*}$ predstavlja množico vseh končnih nizov iz črk abeceda sklada,
- $\delta$ bi lahko predstavljala tudi podmnožico $Q \times \Gamma \times (\Sigma \cup \{\varepsilon\}) \times (Q \times \Gamma^{*})$ ,
- Prehodna funkcija ni nujno enolična.

## Delovanje

Označimo naš PDA z $M$.

Denimo, da je $M$ v stanju $p$, na vrhu sklada naj bo $A \in \Gamma$. Če je $a$ prebrani simbol se lahko zgodi ena od naslednjih reči:

- Če je $\delta(p, A, a) \neq \emptyset$ potem $M$ za $(q, A_{1}A_{2}\ldots A_{n}) \in \delta(p, A, a)$
    - vzame $A$ dol s sklada,
    - da $A_{1}A_{2}\ldots A_{n}$ na sklad, začenši z $A_n$,
    - vstopi v stanje $q$,
    - se premakne naprej po vnesenem nizu.
- Če je $\delta(p, A, a) = \emptyset$ potem $M$ ne naredi ničesar.
- Če je $\delta(p,A ,\varepsilon) \neq \emptyset$ potem $M$, brez prebiranja $a$,
    - vzame $A$ dol s sklada,
    - da $A_{1}A_{2}\ldots A_{n}$ na sklad, začenši z $A_n$,
    - vstopi v stanje $q$.
- Če je $\delta(p,A ,\varepsilon) = \emptyset$ potem $M$ ne naredi ničesar.

V primeru ko je $A_{1}A_{2}\ldots A_{n}$ enako $\varepsilon$ se $A$ odstrani iz sklada in se na sklad ne da ničesar. Pozoren bralec je uvidel, da v primeru praznega sklada ne moremo spremeniti stanja. 


## Sprejemanje

Obstajata dva ekvivalentna načina sprejemanja za nedeterministične skladovne avtomate.

Prvi način je $\bf {\text {sprejemanje glede na končno stanje}}$. Niz $w$ je sprejet, če obstaja zaporedje korakov branja niza, da preidemo iz začetnega stanja do enega izmed sprejemnih stanj, pri čemer se ne ozremo na končno stanje sklada (ta je lahko prazen ali pa ne). Ta način bo uporabljen v zgledih.

Drugi način je $\bf {\text {sprejemanje s praznim skladom}}$. Tu je niz $w$ sprejet, če obstaja zaporedje korakov branja niza, da preidemo iz začetnega stanja do katerega koli stanja, a je po končanem branju sklad prezen. Taki avtomati tudi ne potrebujejo $F$ v definiciji.

Naj bo $P$ = $(Q, \Sigma, \Gamma,\delta, q_0, Z_0, F )$. Označimo z $L(M)$ vse nize, ki jih $P$ sprejme glede na končno stanje in z $N(P)$ množico nizov, ki jih $P$ sprejme glede na prazen sklad.

Zavedati se je potrebno, da v splošnem ne velja enakost $L(P) = N(P)$.

Ta načina sprejemanja sta ekvivalentna v smislu, da za vsak NPDA $P$ obstaja NPDA $P'$, da je $L(P) = N(P')$ in za vsak NPDA $M$ obstaja NPDA $M'$, da je $N(M) = L(M')$. 

### Povezava s Context-Free Languages

Vemo da končni avtomati sprejemajo natanko regularne jezike (Regular Languages). To še zdaleč niso vsi jeziki. Primer jezika, ki ni regularen je $\{a^{i}b^{i} | i \in \mathbb{N}\}$.

Izkaže se, da nedeterministični skladovni avtomati sprejemajo natanko vse Context-Free jazike (regularni jeziki so podmnožica le teh), deterministični skladovni avtomati pa sprejemajo več jezikov, kot le regularne, a hkrati manj kot vse Context-Free jezike.

Seveda obstajajo Non-Context-Free jeziki, kot je npr. jezik vseh nizov oblike $\{a^{i}b^{j}c^{k} | 0\leq i\leq j\leq k\}$.

## Primerjava s končnimi avtomati

Dve glavni razliki med končnimi in skladovnimi avtomati izhajata ravno iz sklada.

Prva razlika se nanaša na uporabo sklada pri prehajanju v nova stanja. Medtem ko končni avtomat pogleda le trenutno stanje in trenutni simbol, ima PDA na voljo še informacijo o vrhnjem elementu sklada. 

Druga razlika se skriva v zmožnosti avtomata da uredi sklad kot del prehoda v novo stanje. 

Ravno ti dve razliki povečata število jezikov, ki jih nedeterministični skladovni avtomati sprejemajo, in jih naredita zanimive za raziskovanje.

## Zgled 1

Za prvi primer sem si izbral kar najbolj osnoven in ilustrativen zgled, ki se pojavi v vsakem tekstu na temo avtomatov in jezikov. Skupaj bomo sestavili avtomat, ki sprejme jezik $\{0^{n}1^{n}|n \geq 0\}$. To je jezik, ki ga sprejme deterministični PDA, a se mi zdi pomemben za razumevanje delovanja sklada.

Naj bo $M_1 = \left( Q, \Sigma, \Gamma, \delta, q_1, \$, F \right)$, kjer so

- $Q=\{q_1, q_2, q_3, q_4\},$
- $\Sigma = \{0,1\},$
- $\Gamma = \{0,\$\},$
- $F = \{q_1, q_4\}$,

|$\delta$|
|----|
|$(q_1, {\$}, 0) \to (q_2, {\$}0)$|
|$(q_2, 0, 0) \to (q_2, 00)$|
|$(q_2, 0, 1) \to (q_3, \varepsilon)$|
|$(q_3, 0, 1) \to (q_3, \varepsilon)$|
|$(q_3, {\$}, \varepsilon) \to (q_4, {\$})$|

<!-- Sipser 113 -->

## Zgled 2

Drugi primer, pa je jezik, ki ga ne sprejme noben DPDA, ga pa sprejme sledeči NPDA.
Sestavili bomo avtomat, ki sprejme jezik $\{a^{i}b^{j}c^{k} | i=j \text{  ali  } i=k\}$.

Naj bo $M_2 = \left( Q, \Sigma, \Gamma, \delta, q_1, \$, F \right)$, kjer so

- $Q=\{q_1, q_2, q_3, q_4, q_5, q_6\},$
- $\Sigma = \{a, b, c\},$
- $\Gamma = \{a,b,\$\},$
- $F = \{q_3, q_6\}$,

|$\delta$|
|----|
|$(q_1, {\$}, a) \to (q_1, {\$}a)$|
|$(q_1, a, a) \to (q_1, aa)$|
|$(q_1, a, b) \to (q_2, \varepsilon)$|
|$(q_2, a, b) \to (q_2, \varepsilon)$|
|$(q_2, {\$}, c) \to (q_3, {\$})$|
|$(q_3, {\$}, c) \to (q_3, {\$})$|
|$(q_1, a, b) \to (q_4, a)$|
|$(q_4, a, b) \to (q_4, a)$|
|$(q_4, {\$}, b) \to (q_4,{\$})$|
|$(q_4, a, c) \to (q_5, \varepsilon)$|
|$(q_5, a, c) \to (q_5, \varepsilon)$|
|$(q_1, {\$}, \varepsilon) \to (q_2, {\$})$|
|$(q_2, {\$}, \varepsilon) \to (q_3, {\$})$|
|$(q_1, {\$}, \varepsilon) \to (q_4, {\$})$|
|$(q_4, {\$}, \varepsilon) \to (q_5, {\$})$|
|$(q_5, {\$}, \varepsilon) \to (q_6, {\$})$|

<!-- Sipser 114 -->

## Navodila za uporabo

Tekstovni vmesnik lahko prevedete tako, da v ukazno vrstico napišete ukaz `dune build`, ki zgradi datoteko tekstovniVmesnik.exe, in nato poženete še ukaz `.\tekstovniVmesnik.exe`, ki dotično datoteko požene. 

## Struktura datotek






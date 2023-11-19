# Projektna_Programiranje_1

Osrednji del moje projektne naloge bo implementacija $\underline{\text{nedeterminističnega skladovnega avtomata}}$ (non-deterministic pushdown automaton oz. NPDA). 

## Opredelitev in primerjava s končnimi avtomati



Za rezliko od standardnega končnega avtomata ima, kot je razvidno iz imena, skladovni avtomat (pushdown automaton oz. PDA) pridružen še sklad. Dve glavni razliki med končnimi in skladovnimi avtomati izhajata ravno iz sklada.
Prva razlika se nanaša na uporabo sklada pri prehajanju v nova stanja. Medtem ko končni avtomat pogleda le trenutno stanje in končni simbol, ima PDA na voljo še informacijo o vrhnjem elementu sklada. Druga razlika pa se skriva v zmožnosti avtomata da uredi sklad kot del prehoda v novo stanje.

Kot nam je že znano skladovni avtomat lahko sprejme niz, ki ga bere od leve proti desni. V vsakem koraku lahko prebere le en znak in se nato na podlagi tega znaka, trenutnega stanja in vrhnjega elementa sklada odloči, kakšen prehod naj izvede. V procesu izvajanja prehoda se lahko zgodi več stvari. Avtomat lahko vzame vrhnji element dol s sklada (pop) in nato na sklad položi (push) končno množico znakov iz abecede sklada.

V primeru, da je v neki situaciji možnih več prehodov, govorimo o nedeterminističnem avtomatu. Take avtomate bomo v nadaljevanju bolje spoznali in se, upajmo, z njimi spoprijateljili.

## Definicija

Formalno gledano je nedeterminističen skladovni avtomat definiran kot nabor (7-tuple) $(Q, \Sigma, \Gamma,\delta, q_0,Z, F )$, kjer so:

- $Q$ končna množica stanj,
- $\Sigma$ končna množica simbolov imenovana abeceda vnosov (input alphabet),
- $\Gamma$ končna množica simbolov imenovana sbeceda sklada (stack alphabet),
- $\delta : Q \times (\Sigma \cup \{\varepsilon\}) \times \Gamma \to \mathscr{P}(Q \times \Gamma^{*})$ prehodna funkcija,
- $q_0 \in Q$ začetno stanje (start state),
- Z $\in \Gamma$ začetni simbol na skladu (initial stack symbol),
- $F \subseteq Q$ množica sprejemnih stanj in

Opombe:

- $\Gamma$ in $\Sigma$ nista nujno disjunktni množici, a tega nič ne preprečuje
- $\varepsilon$ označuje prazen niz
- $\Gamma^{*}$ predstavlja množico vseh končnih nizov iz črk abeceda sklada
- $\delta$ bi lahko predstavljala tudi podmnožico $Q \times (\Sigma \cup \{\varepsilon\}) \times \Gamma \times Q \times \Gamma^{*}$ 
- Prehodna funkcija ni nujno enolična

## Delovanje

Označimo naš PDA z $M$.

Denimo, da je $M$ v stanju $p$, na vrhu sklada naj bo $A \in \Gamma$. Če je $a$ prebrani simbol se lahko zgodi ena od naslednjih reči:

- Če je $\delta(p,a,A) \neq \emptyset$ potem $M$ za $(q, A_{1}A_{2}\ldots A_{n}) \in \delta(p,a,A)$
    - vzame $A$ dol s sklada
    - da $A_{1}A_{2}\ldots A_{n}$ na sklad, začenši z $A_n$
    - vstopi v stanje $q$
    - se premakne naprej po vnesenem nizu
- Če je $\delta(p,a,A) = \emptyset$ potem $M$ ne naredi ničesar
- Če je $\delta(p,\varepsilon,A) \neq \emptyset$ potem $M$, brez prebiranja $a$,
    - vzame $A$ dol s sklada
    - da $A_{1}A_{2}\ldots A_{n}$ na sklad, začenši z $A_n$
    - vstopi v stanje $q$
- Če je $\delta(p,\varepsilon,A) = \emptyset$ potem $M$ ne naredi ničesar

V primeru ko je $A_{1}A_{2}\ldots A_{n}$ enako $\varepsilon$ se $A$ odstrani iz sklada in se na sklad ne da ničesar. Pozoren bralec je uvidel, da v primeru praznega sklada ne moremo spremeniti stanja. 
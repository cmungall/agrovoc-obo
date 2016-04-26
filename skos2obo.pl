:- module(skos2obo,
          [
           obolabel/2,
           obodef/2,

           wfile/1,
           skos2obo/2
          ]).
:- use_module(skos).
:- use_module(library(semweb/rdf_db)).
:- use_module(library(semweb/rdf_ntriples)).


obolabel(C,Label) :-
        preferred_label(C,literal(lang(en, Label))).
obosyn(C,Label) :-
        alternative_label(C,literal(lang(en, Label))).
obosingular(C,Label) :-
        rdf(C, 'http://aims.fao.org/aos/agrontology#hasSingular', literal(lang(en, Label))).

% TODO - safeify
obodef(C,Label) :-
        definition(C,D),
        rdf(D,'http://www.w3.org/1999/02/22-rdf-syntax-ns#value',literal(lang(en, Val))),
        makesafe(Val,Label).

oborel(C,R,D) :-
        rdf(C,R1,D),
        atom_concat('http://aims.fao.org/aos/agrontology#',R,R1).
oboxref(C,X) :-
        has_exact_match(C,X).

makesafe(X,Y) :-
        concat_atom(L,'\n',X),
        concat_atom(L,'\\n',Y).


wterm(C) :-
        concept(C),
        \+ \+ obolabel(C,_),
        format('[Term]~n'),
        format('id: ~w~n',[C]),
        uforall(obolabel(C,N),
                format('name: ~w~n',[N])),
        uforall((has_broader(C,D),obolabel(D,DN)),
               format('is_a: ~w ! ~w~n',[D,DN])),
        uforall(obodef(C,X),
               format('def: "~w" []~n',[X])),
        uforall(obosyn(C,X),
               format('synonym: "~w" RELATED []~n',[X])),
        uforall(obosingular(C,X),
               format('synonym: "~w" EXACT []~n',[X])),
        uforall(oboxref(C,X),
                format('xref: ~w~n',[X])),
        %uforall((oboxref(C,X),obolabel(X,XN)),
        %        format('xref: ~w ! ~w~n',[X,XN])),
        uforall((oborel(C,R,D),obolabel(D,DN)),
                format('relationship: ~w ~w ! ~w~n',[R,D,DN])),
        nl.

uforall(T,G) :-
        setof(T,T,L),
        !,
        forall(member(T,L),
               G).
uforall(_,_).

wfile(FN) :-
        tell(FN),
        forall(wterm(_),true),
        told.
        
load_agrovoc :-
        rdf_load('agrovoc_2016-01-21_lod.nt').
skos2obo(In,Out) :-
        rdf_load(In),
        wfile(Out).


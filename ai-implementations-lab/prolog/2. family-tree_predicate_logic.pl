%Step 1: Define Facts
% Individuals
individual(peter).
individual(jessica).
individual(ron).
individual(david).
individual(sheila).
individual(robert).
individual(eva).
individual(donald).
individual(cynthia).
individual(steven).
individual(sandra).
individual(francisco).
individual(amanda).
individual(mark).
individual(lula).
individual(perdo).
individual(zula).
individual(cleveland).

% Gender
male(peter).
male(ron).
male(david).
male(robert).
male(donald).
male(steven).
male(francisco).
male(mark).
male(perdo).
male(cleveland).

female(jessica).
female(sheila).
female(eva).
female(cynthia).
female(sandra).
female(amanda).
female(lula).
female(zula).

% Parent-Child Relationships
parent(peter, ron).
parent(peter, david).
parent(peter, sheila).
parent(peter, robert).
parent(peter, eva).

parent(jessica, ron).
parent(jessica, david).
parent(jessica, sheila).
parent(jessica, robert).
parent(jessica, eva).

parent(david, cynthia).
parent(david, steven).

parent(sheila, cynthia).
parent(sheila, steven).

parent(robert, francisco).
parent(eva, francisco).

parent(donald, mark).
parent(cynthia, mark).

parent(donald, lula).
parent(cynthia, lula).

parent(steven, perdo).
parent(sandra, perdo).

parent(francisco, zula).
parent(amanda, zula).

parent(francisco, cleveland).
parent(amanda, cleveland).

% Spouse Relationships
spouse(peter, jessica).
spouse(david, sheila).
spouse(robert, eva).
spouse(donald, cynthia).
spouse(stevan, sandra).
spouse(francisco, amanda).


% Derived Relationships
% 1. Grandparent Relationships
grandparent(X, Z) :- parent(X, Y), parent(Y, Z).
grandfather(X, Z) :- parent(X, Y), parent(Y, Z), male(X).
grandmother(X, Z) :- parent(X, Y), parent(Y, Z), female(X).


% 2. Sibling Relationships
sibling(X, Y) :- parent(P, X), parent(P, Y), X \= Y.
brother(X,Y):- parent(P,X), parent(P,Y), X \= Y, male(X).
sister(X,Y):- parent(P,X), parent(P,Y), X \= Y, female(X).


% 3. Cousin Relationships
cousin(X, Y) :- grandparent(Z, X), grandparent(Z, Y), X \= Y.

% Father%
father(X,Y):- parent(X,Y), male(X).

% Mother
mother(X,Y):- parent(X,Y), female(X).

% Son
son(X,Y):- parent(Y,X), male(X).

% Daughter
daughter(X,Y):- parent(Y,X), female(X).

% Base case: X is a direct parent of Y
descendant(X, Y) :- parent(X, Y).

% Recursive case: X is an ancestor of Y if X is a parent of Z, and Z is an ancestor of Y
descendant(X, Y) :- parent(X, Z), descendant(Z, Y).


% Rule for Descendant Relationship
% Base case: X is a direct child of Y
ancestor(X, Y) :- parent(Y, X).

% Recursive case: Y is a descendant of X if Z is a descendant of X,
% and Y is a child of Z
ancestor(X, Y) :- parent(Y, Z), ancestor(X, Z).




% Rule: Peter is a parent of all individuals in the list
parent_of_all(peter, []).
parent_of_all(peter, [X|Rest]) :- parent(peter, X), parent_of_all(peter, Rest).


% ?- parent_of_all(peter, [ron, david, sheila]).


% Rule: There exists a child of Peter
has_child(peter) :- parent(peter, _).

% ?- has_child(peter).

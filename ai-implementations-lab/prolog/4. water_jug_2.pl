% Define the possible moves
move((A, B), (4, B)) :- A < 4.     % Fill Jug A
move((A, B), (A, 3)) :- B < 3.     % Fill Jug B
move((A, B), (0, B)) :- A > 0.     % Empty Jug A
move((A, B), (A, 0)) :- B > 0.     % Empty Jug B


% Pour A -> B (until B is full or A is empty)
move((A, B), (A1, B1)) :-
    A > 0, B < 3, 
    Transfer is min(A, 3 - B),
    A1 is A - Transfer, 
    B1 is B + Transfer.



% Pour B -> A (until A is full or B is empty)
move((A, B), (A1, B1)) :-
    B > 0, A < 4, 
    Transfer is min(B, 4 - A),
    A1 is A + Transfer, 
    B1 is B - Transfer.





% Depth-First Search to find the solution
dfs((2,_), _, [(2,_)]) :- !.  % Goal state reached (2 liters in either jug)
dfs((_,2), _, [(_,2)]) :- !.  



dfs(State, Visited, [State | Path]) :-
    move(State, NextState),
    \+ member(NextState, Visited),  % Avoid cycles
    dfs(NextState, [NextState | Visited], Path).

% Start solving from (0,0)

water_jug_solution(Path) :-
    dfs((0,0), [(0,0)], Path).
% Define the capacity of the jugs
capacity(jug1, 4).
capacity(jug2, 3).

% Define the goal state (2 liters in any jug)
goal(state(2, _)).
goal(state(_, 2)).

% Define possible operations

% Fill a jug completely
operation(fill(jug1), state(_, J2), state(4, J2)).
operation(fill(jug2), state(J1, _), state(J1, 3)).

% Empty a jug completely
operation(empty(jug1), state(_, J2), state(0, J2)).
operation(empty(jug2), state(J1, _), state(J1, 0)).

% Transfer water from jug1 to jug2
operation(transfer(jug1_to_jug2), state(J1, J2), state(NewJ1, NewJ2)) :-
    capacity(jug2, Cap2),
    Transfer is min(J1, Cap2 - J2),
    Transfer > 0, % Prevent redundant operations
    NewJ1 is J1 - Transfer,
    NewJ2 is J2 + Transfer.

% Transfer water from jug2 to jug1
operation(transfer(jug2_to_jug1), state(J1, J2), state(NewJ1, NewJ2)) :-
    capacity(jug1, Cap1),
    Transfer is min(J2, Cap1 - J1),
    Transfer > 0, % Prevent redundant operations
    NewJ1 is J1 + Transfer,
    NewJ2 is J2 - Transfer.

% Solve the problem using breadth-first search
solve :-
    bfs([[state(0, 0)]], []).

bfs([[State|Path]|_], _) :-
    goal(State),
    write("Solution Found: "), nl,
    print_solution([State|Path]).

bfs([Path|Paths], Visited) :-
    Path = [CurrentState|_],
    findall(
        [NextState, CurrentState|Path],
        (operation(_, CurrentState, NextState),
         \+ member(NextState, Visited),
         \+ member(NextState, Path)),
        NewPaths
    ),
    append(Paths, NewPaths, UpdatedPaths),
    bfs(UpdatedPaths, [CurrentState|Visited]).

% Print the solution in a readable format
print_solution([]).
print_solution([State|Rest]) :-
    write(State), nl,
    print_solution(Rest).

% Run the query:
% ?- solve.

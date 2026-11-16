% ============================================================
% CHATBOT SISTEMA SOLAR
% Entrega 2 - Fundamentos de Inteligencia Artificial
% Grupo 8
% ============================================================

:- consult('conocimiento.pl').


% ------------------------------------------------------------
% INICIO
% ------------------------------------------------------------

inicio :-
    nl,
    writeln('=== CHATBOT SISTEMA SOLAR ==='),
    writeln('Bienvenido al chatbot del Sistema Solar.'),
    writeln('Puedes consultar datos sobre planetas,'),
    writeln('lunas, misiones espaciales y mas.'),
    nl,
    menu.


% ------------------------------------------------------------
% MENU PRINCIPAL
% ------------------------------------------------------------

menu :-
    writeln('Que deseas consultar?'),
    nl,
    writeln(' 1. Informacion general de un planeta'),
    writeln(' 2. Tipo de planeta (rocoso/gaseoso/helado/enano)'),
    writeln(' 3. Distancia al Sol'),
    writeln(' 4. Temperatura media'),
    writeln(' 5. Lunas de un planeta'),
    writeln(' 6. Composicion atmosferica'),
    writeln(' 7. Planetas con anillos'),
    writeln(' 8. Planetas interiores y exteriores'),
    writeln(' 9. Planetas por tipo'),
    writeln('10. Misiones espaciales a un planeta'),
    writeln('11. Caracteristicas especiales'),
    writeln('12. Descubrimiento de un planeta'),
    writeln('13. Comparar dos planetas'),
    writeln('14. Vecinos orbitales'),
    writeln('15. Datos del Sistema Solar'),
    writeln(' 0. Salir'),
    nl,
    write('Opcion: '),
    read_line_to_string(user_input, Opcion),
    string_codes(Opcion, Codes),
    (   limpiar_espacios(Codes, CodesLimpio),
        string_codes(OpcionLimpia, CodesLimpio)
    ->  procesar_opcion(OpcionLimpia)
    ;   procesar_opcion(Opcion)
    ).


% ------------------------------------------------------------
% LIMPIAR ESPACIOS
% ------------------------------------------------------------

limpiar_espacios([], []).
limpiar_espacios(Codes, Limpio) :-
    quitar_espacios_inicio(Codes, SinInicio),
    reverse(SinInicio, Rev),
    quitar_espacios_inicio(Rev, RevLimpio),
    reverse(RevLimpio, Limpio).

quitar_espacios_inicio([], []).
quitar_espacios_inicio([32|Resto], Resultado) :-
    !,
    quitar_espacios_inicio(Resto, Resultado).
quitar_espacios_inicio(Lista, Lista).


% ------------------------------------------------------------
% LECTURA Y NORMALIZACION
% ------------------------------------------------------------

leer_planeta(Planeta) :-
    write('Ingresa el nombre del planeta: '),
    read_line_to_string(user_input, Texto),
    string_lower(Texto, Minuscula),
    normalize_space(string(Limpio), Minuscula),
    atom_string(Planeta, Limpio).

leer_tipo(Tipo) :-
    write('Ingresa el tipo (rocoso, gaseoso, helado, enano): '),
    read_line_to_string(user_input, Texto),
    string_lower(Texto, Minuscula),
    normalize_space(string(Limpio), Minuscula),
    atom_string(Tipo, Limpio).


% ------------------------------------------------------------
% OPCIONES DEL MENU
% ------------------------------------------------------------

procesar_opcion("1") :- !, nl, consultar_info, nl, menu.
procesar_opcion("2") :- !, nl, consultar_tipo, nl, menu.
procesar_opcion("3") :- !, nl, consultar_distancia, nl, menu.
procesar_opcion("4") :- !, nl, consultar_temperatura, nl, menu.
procesar_opcion("5") :- !, nl, consultar_lunas, nl, menu.
procesar_opcion("6") :- !, nl, consultar_atmosfera, nl, menu.
procesar_opcion("7") :- !, nl, consultar_anillos, nl, menu.
procesar_opcion("8") :- !, nl, consultar_interiores_exteriores, nl, menu.
procesar_opcion("9") :- !, nl, consultar_por_tipo, nl, menu.
procesar_opcion("10") :- !, nl, consultar_misiones, nl, menu.
procesar_opcion("11") :- !, nl, consultar_caracteristicas, nl, menu.
procesar_opcion("12") :- !, nl, consultar_descubrimiento, nl, menu.
procesar_opcion("13") :- !, nl, consultar_comparar, nl, menu.
procesar_opcion("14") :- !, nl, consultar_vecinos, nl, menu.
procesar_opcion("15") :- !, nl, consultar_sistema, nl, menu.
procesar_opcion("0") :- !, nl, writeln('Gracias por usar el chatbot del Sistema Solar.').
procesar_opcion(_) :- nl, writeln('Opcion invalida. Ingresa un numero entre 0 y 15.'), nl, menu.


% ============================================================
% FUNCIONES DE CONSULTA
% ============================================================


% 1. INFORMACION GENERAL
consultar_info :-
    leer_planeta(P),
    (   \+ cuerpo_valido(P)
    ->  format('El cuerpo "~w" no esta registrado en la base de conocimiento.~n', [P])
    ;   tipo_planeta(P, Tipo),
        posicion_orbital(P, Pos),
        distancia_sol(P, Dist),
        radio_km(P, Radio),
        masa_terrestre(P, Masa),
        temperatura_media(P, Temp),
        gravedad_superficie(P, Grav),
        cantidad_lunas(P, Lunas),
        periodo_orbital(P, POrb),
        periodo_anios(P, Anios),
        format('~n=== ~w ===~n', [P]),
        format('  Tipo: ~w~n', [Tipo]),
        format('  Posicion orbital: ~w~n', [Pos]),
        format('  Distancia al Sol: ~w UA~n', [Dist]),
        format('  Radio: ~w km~n', [Radio]),
        format('  Masa: ~w masas terrestres~n', [Masa]),
        format('  Temperatura media: ~w °C~n', [Temp]),
        format('  Gravedad: ~w m/s^2~n', [Grav]),
        format('  Lunas conocidas: ~w~n', [Lunas]),
        format('  Periodo orbital: ~w dias (~2f anios)~n', [POrb, Anios])
    ).


% 2. TIPO DE PLANETA
consultar_tipo :-
    leer_planeta(P),
    (   \+ cuerpo_valido(P)
    ->  format('El cuerpo "~w" no esta registrado.~n', [P])
    ;   tipo_planeta(P, Tipo),
        format('~w es un planeta ~w.~n', [P, Tipo])
    ).


% 3. DISTANCIA AL SOL
consultar_distancia :-
    leer_planeta(P),
    (   \+ cuerpo_valido(P)
    ->  format('El cuerpo "~w" no esta registrado.~n', [P])
    ;   distancia_sol(P, Dist),
        DistKm is Dist * 149597870.7,
        format('~w esta a ~w UA del Sol (~1f km).~n', [P, Dist, DistKm])
    ).


% 4. TEMPERATURA MEDIA
consultar_temperatura :-
    leer_planeta(P),
    (   \+ cuerpo_valido(P)
    ->  format('El cuerpo "~w" no esta registrado.~n', [P])
    ;   temperatura_media(P, Temp),
        format('La temperatura media de ~w es ~w °C.~n', [P, Temp])
    ).


% 5. LUNAS
consultar_lunas :-
    leer_planeta(P),
    (   \+ cuerpo_valido(P)
    ->  format('El cuerpo "~w" no esta registrado.~n', [P])
    ;   cantidad_lunas(P, Cant),
        format('~w tiene ~w luna(s) conocida(s).~n', [P, Cant]),
        findall(L, luna(L, P), Lunas),
        (   Lunas \= []
        ->  writeln('Lunas notables:'),
            mostrar_lunas(Lunas)
        ;   true
        )
    ).


% 6. COMPOSICION ATMOSFERICA
consultar_atmosfera :-
    leer_planeta(P),
    (   \+ cuerpo_valido(P)
    ->  format('El cuerpo "~w" no esta registrado.~n', [P])
    ;   (   tiene_atmosfera(P)
        ->  findall(G, gas_atmosfera(P, G), Gases),
            format('Composicion atmosferica de ~w:~n', [P]),
            mostrar_lista(Gases)
        ;   format('~w no tiene una atmosfera significativa.~n', [P])
        )
    ).


% 7. PLANETAS CON ANILLOS
consultar_anillos :-
    findall(P, tiene_anillos(P), Lista),
    writeln('Planetas con anillos:'),
    mostrar_lista(Lista).


% 8. INTERIORES Y EXTERIORES
consultar_interiores_exteriores :-
    findall(P, planeta_interior(P), Int),
    findall(P, planeta_exterior(P), Ext),
    writeln('Planetas interiores (rocosos):'),
    mostrar_lista(Int),
    nl,
    writeln('Planetas exteriores (gigantes):'),
    mostrar_lista(Ext).


% 9. PLANETAS POR TIPO
consultar_por_tipo :-
    leer_tipo(Tipo),
    findall(P, tipo_planeta(P, Tipo), Lista),
    (   Lista = []
    ->  format('No se encontraron planetas de tipo "~w".~n', [Tipo]),
        writeln('Tipos validos: rocoso, gaseoso, helado, enano')
    ;   format('Planetas de tipo ~w:~n', [Tipo]),
        mostrar_lista(Lista)
    ).


% 10. MISIONES ESPACIALES
consultar_misiones :-
    leer_planeta(P),
    (   \+ cuerpo_valido(P)
    ->  format('El cuerpo "~w" no esta registrado.~n', [P])
    ;   findall(
            M-Anio-Agencia,
            mision(M, P, Anio, Agencia),
            Misiones
        ),
        (   Misiones = []
        ->  format('No se registran misiones a ~w.~n', [P])
        ;   format('Misiones espaciales a ~w:~n', [P]),
            mostrar_misiones(Misiones)
        )
    ).


% 11. CARACTERISTICAS ESPECIALES
consultar_caracteristicas :-
    leer_planeta(P),
    (   \+ cuerpo_valido(P)
    ->  format('El cuerpo "~w" no esta registrado.~n', [P])
    ;   findall(Desc, caracteristica(P, Desc), Caracs),
        (   Caracs = []
        ->  format('No se registran caracteristicas especiales para ~w.~n', [P])
        ;   format('Caracteristicas especiales de ~w:~n', [P]),
            mostrar_lista(Caracs)
        )
    ).


% 12. DESCUBRIMIENTO
consultar_descubrimiento :-
    leer_planeta(P),
    (   \+ cuerpo_valido(P)
    ->  format('El cuerpo "~w" no esta registrado.~n', [P])
    ;   descubierto_por(P, Desc, Anio),
        (   Desc = antiguedad
        ->  format('~w es conocido desde la antiguedad (visible a simple vista).~n', [P])
        ;   format('~w fue descubierto por ~w en el anio ~w.~n', [P, Desc, Anio])
        )
    ).


% 13. COMPARAR DOS PLANETAS
consultar_comparar :-
    write('Ingresa el primer planeta: '),
    read_line_to_string(user_input, T1),
    string_lower(T1, M1), normalize_space(string(L1), M1), atom_string(P1, L1),
    write('Ingresa el segundo planeta: '),
    read_line_to_string(user_input, T2),
    string_lower(T2, M2), normalize_space(string(L2), M2), atom_string(P2, L2),
    (   (\+ cuerpo_valido(P1) ; \+ cuerpo_valido(P2))
    ->  writeln('Uno o ambos cuerpos no estan registrados.')
    ;   P1 = P2
    ->  writeln('Debes ingresar dos planetas diferentes.')
    ;   radio_km(P1, R1), radio_km(P2, R2),
        masa_terrestre(P1, M1b), masa_terrestre(P2, M2b),
        distancia_sol(P1, D1), distancia_sol(P2, D2),
        temperatura_media(P1, Temp1), temperatura_media(P2, Temp2),
        cantidad_lunas(P1, Lu1), cantidad_lunas(P2, Lu2),
        format('~n  Comparacion entre ~w y ~w:~n', [P1, P2]),
        format('  ~30|~w~50|~w~n', [P1, P2]),
        format('  Radio (km):~30|~w~50|~w~n', [R1, R2]),
        format('  Masa (M.T.):~30|~w~50|~w~n', [M1b, M2b]),
        format('  Dist. Sol (UA):~30|~w~50|~w~n', [D1, D2]),
        format('  Temp. media (C):~30|~w~50|~w~n', [Temp1, Temp2]),
        format('  Lunas:~30|~w~50|~w~n', [Lu1, Lu2]),
        nl,
        (   mas_grande(P1, P2) -> format('  ~w es mas grande que ~w.~n', [P1, P2])
        ;   format('  ~w es mas grande que ~w.~n', [P2, P1])
        ),
        (   mas_cercano_sol(P1, P2) -> format('  ~w esta mas cerca del Sol.~n', [P1])
        ;   format('  ~w esta mas cerca del Sol.~n', [P2])
        )
    ).


% 14. VECINOS ORBITALES
consultar_vecinos :-
    leer_planeta(P),
    (   \+ cuerpo_valido(P)
    ->  format('El cuerpo "~w" no esta registrado.~n', [P])
    ;   findall(V, vecino(P, V), Vecinos),
        (   Vecinos = []
        ->  format('~w no tiene vecinos registrados.~n', [P])
        ;   format('Vecinos orbitales de ~w:~n', [P]),
            mostrar_lista(Vecinos)
        )
    ).


% 15. DATOS DEL SISTEMA SOLAR
consultar_sistema :-
    writeln('Datos del Sistema Solar:'),
    findall(A-V, dato_sistema(A, V), Datos),
    mostrar_pares(Datos).


% ============================================================
% FUNCIONES AUXILIARES
% ============================================================

mostrar_lista([]).
mostrar_lista([E|R]) :-
    format('  - ~w~n', [E]),
    mostrar_lista(R).

mostrar_pares([]).
mostrar_pares([N-D|R]) :-
    format('  - ~w: ~w~n', [N, D]),
    mostrar_pares(R).

mostrar_misiones([]).
mostrar_misiones([M-A-Ag|R]) :-
    format('  - ~w (~w, ~w)~n', [M, A, Ag]),
    mostrar_misiones(R).

mostrar_lunas([]).
mostrar_lunas([L|R]) :-
    (   descripcion_luna(L, Desc)
    ->  format('  - ~w: ~w~n', [L, Desc])
    ;   format('  - ~w~n', [L])
    ),
    mostrar_lunas(R).

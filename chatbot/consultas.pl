% ============================================================
% INTERFAZ PROLOG PARA CONSULTAS JSON
% Lee una consulta JSON desde stdin, ejecuta la consulta
% sobre la base de conocimiento y escribe el resultado
% como JSON en stdout.
% ============================================================

:- use_module(library(http/json)).
:- discontiguous resolver/3.
:- consult('../conocimiento.pl').


% Punto de entrada
main :-
    catch(
        (
            json_read_dict(current_input, Consulta),
            get_dict(operacion, Consulta, Op),
            resolver(Op, Consulta, Resultado),
            json_write_dict(current_output, Resultado, [width(0)]),
            nl
        ),
        Error,
        (
            format(current_output, '{"error": "~w"}~n', [Error])
        )
    ),
    halt(0).

main :-
    write('{"error": "Consulta no reconocida"}'), nl,
    halt(1).

:- initialization(main, main).


% ============================================================
% RESOLVEDORES POR OPERACION
% ============================================================

% --- info: Informacion general de un cuerpo celeste ---
resolver("info", Consulta, Resultado) :-
    get_dict(planeta, Consulta, NombreStr),
    atom_string(Nombre, NombreStr),
    cuerpo_celeste(Nombre), !,
    tipo_planeta(Nombre, Tipo),
    posicion_orbital(Nombre, Pos),
    distancia_sol(Nombre, Dist),
    radio_km(Nombre, Radio),
    masa_terrestre(Nombre, Masa),
    temperatura_media(Nombre, Temp),
    gravedad_superficie(Nombre, Grav),
    cantidad_lunas(Nombre, Lunas),
    periodo_orbital(Nombre, POrb),
    findall(S, (luna(L, Nombre), atom_string(L, S)), LunasLista),
    findall(S, (gas_atmosfera(Nombre, G), atom_string(G, S)), Gases),
    findall(S, caracteristica(Nombre, S), Caracs),
    atom_string(Tipo, TipoStr),
    atom_string(Nombre, NStr),
    Resultado = _{
        nombre: NStr, tipo: TipoStr, posicion: Pos,
        distancia_ua: Dist, radio_km: Radio, masa_terrestre: Masa,
        temperatura_celsius: Temp, gravedad_ms2: Grav,
        cantidad_lunas: Lunas, periodo_orbital_dias: POrb,
        lunas_notables: LunasLista, gases_atmosfera: Gases,
        caracteristicas: Caracs
    }.

resolver("info", _, _{error: "Planeta no encontrado"}).


% --- tipo: Tipo de un planeta ---
resolver("tipo", Consulta, Resultado) :-
    get_dict(planeta, Consulta, NombreStr),
    atom_string(Nombre, NombreStr),
    tipo_planeta(Nombre, Tipo), !,
    atom_string(Nombre, NStr),
    atom_string(Tipo, TStr),
    Resultado = _{nombre: NStr, tipo: TStr}.

resolver("tipo", _, _{error: "Planeta no encontrado"}).


% --- distancia: Distancia al Sol ---
resolver("distancia", Consulta, Resultado) :-
    get_dict(planeta, Consulta, NombreStr),
    atom_string(Nombre, NombreStr),
    distancia_sol(Nombre, Dist), !,
    DistKm is Dist * 149597870.7,
    atom_string(Nombre, NStr),
    Resultado = _{nombre: NStr, distancia_ua: Dist, distancia_km: DistKm}.

resolver("distancia", _, _{error: "Planeta no encontrado"}).


% --- temperatura: Temperatura media ---
resolver("temperatura", Consulta, Resultado) :-
    get_dict(planeta, Consulta, NombreStr),
    atom_string(Nombre, NombreStr),
    temperatura_media(Nombre, Temp), !,
    atom_string(Nombre, NStr),
    Resultado = _{nombre: NStr, temperatura_celsius: Temp}.

resolver("temperatura", _, _{error: "Planeta no encontrado"}).


% --- lunas: Lunas de un planeta ---
resolver("lunas", Consulta, Resultado) :-
    get_dict(planeta, Consulta, NombreStr),
    atom_string(Nombre, NombreStr),
    cuerpo_celeste(Nombre), !,
    cantidad_lunas(Nombre, Cant),
    findall(
        _{nombre: LS, descripcion: DS},
        (luna(L, Nombre), atom_string(L, LS),
         (descripcion_luna(L, D) -> atom_string(D, DS) ; DS = "")),
        LunasLista
    ),
    atom_string(Nombre, NStr),
    Resultado = _{nombre: NStr, cantidad: Cant, lunas: LunasLista}.

resolver("lunas", _, _{error: "Planeta no encontrado"}).


% --- atmosfera: Composicion atmosferica ---
resolver("atmosfera", Consulta, Resultado) :-
    get_dict(planeta, Consulta, NombreStr),
    atom_string(Nombre, NombreStr),
    cuerpo_celeste(Nombre), !,
    (tiene_atmosfera(Nombre) -> TieneAtm = true ; TieneAtm = false),
    findall(S, (gas_atmosfera(Nombre, G), atom_string(G, S)), Gases),
    atom_string(Nombre, NStr),
    Resultado = _{nombre: NStr, tiene_atmosfera: TieneAtm, gases: Gases}.

resolver("atmosfera", _, _{error: "Planeta no encontrado"}).


% --- anillos: Planetas con anillos ---
resolver("anillos", _, Resultado) :-
    findall(S, (tiene_anillos(P), atom_string(P, S)), Lista),
    Resultado = _{planetas_con_anillos: Lista}.


% --- planetas_tipo: Planetas por tipo ---
resolver("planetas_tipo", Consulta, Resultado) :-
    get_dict(tipo, Consulta, TipoStr),
    atom_string(Tipo, TipoStr),
    findall(S, (tipo_planeta(P, Tipo), atom_string(P, S)), Lista),
    Resultado = _{tipo: TipoStr, planetas: Lista}.


% --- planetas_interiores: Planetas interiores ---
resolver("planetas_interiores", _, Resultado) :-
    findall(S, (planeta_interior(P), atom_string(P, S)), Lista),
    Resultado = _{planetas_interiores: Lista}.


% --- planetas_exteriores: Planetas exteriores ---
resolver("planetas_exteriores", _, Resultado) :-
    findall(S, (planeta_exterior(P), atom_string(P, S)), Lista),
    Resultado = _{planetas_exteriores: Lista}.


% --- misiones: Misiones espaciales a un planeta ---
resolver("misiones", Consulta, Resultado) :-
    get_dict(planeta, Consulta, NombreStr),
    atom_string(Nombre, NombreStr),
    cuerpo_celeste(Nombre), !,
    findall(
        _{mision: MS, anio: A, agencia: AgS},
        (mision(M, Nombre, A, Ag), atom_string(M, MS), atom_string(Ag, AgS)),
        Misiones
    ),
    atom_string(Nombre, NStr),
    Resultado = _{nombre: NStr, misiones: Misiones}.

resolver("misiones", _, _{error: "Planeta no encontrado"}).


% --- caracteristicas: Caracteristicas especiales ---
resolver("caracteristicas", Consulta, Resultado) :-
    get_dict(planeta, Consulta, NombreStr),
    atom_string(Nombre, NombreStr),
    cuerpo_celeste(Nombre), !,
    findall(S, caracteristica(Nombre, S), Caracs),
    atom_string(Nombre, NStr),
    Resultado = _{nombre: NStr, caracteristicas: Caracs}.

resolver("caracteristicas", _, _{error: "Planeta no encontrado"}).


% --- descubrimiento: Descubrimiento de un planeta ---
resolver("descubrimiento", Consulta, Resultado) :-
    get_dict(planeta, Consulta, NombreStr),
    atom_string(Nombre, NombreStr),
    descubierto_por(Nombre, Desc, Anio), !,
    atom_string(Nombre, NStr),
    atom_string(Desc, DStr),
    Resultado = _{nombre: NStr, descubridor: DStr, anio: Anio}.

resolver("descubrimiento", _, _{error: "Planeta no encontrado"}).


% --- comparar: Comparar dos planetas ---
resolver("comparar", Consulta, Resultado) :-
    get_dict(planeta1, Consulta, P1Str),
    get_dict(planeta2, Consulta, P2Str),
    atom_string(P1, P1Str),
    atom_string(P2, P2Str),
    cuerpo_celeste(P1), cuerpo_celeste(P2), P1 \= P2, !,
    radio_km(P1, R1), radio_km(P2, R2),
    masa_terrestre(P1, M1), masa_terrestre(P2, M2),
    distancia_sol(P1, D1), distancia_sol(P2, D2),
    temperatura_media(P1, T1), temperatura_media(P2, T2),
    cantidad_lunas(P1, L1), cantidad_lunas(P2, L2),
    Resultado = _{
        planeta1: _{nombre: P1Str, radio_km: R1, masa: M1, distancia_ua: D1, temperatura: T1, lunas: L1},
        planeta2: _{nombre: P2Str, radio_km: R2, masa: M2, distancia_ua: D2, temperatura: T2, lunas: L2}
    }.

resolver("comparar", _, _{error: "Uno o ambos planetas no encontrados"}).


% --- vecinos: Vecinos orbitales ---
resolver("vecinos", Consulta, Resultado) :-
    get_dict(planeta, Consulta, NombreStr),
    atom_string(Nombre, NombreStr),
    cuerpo_celeste(Nombre), !,
    findall(S, (vecino(Nombre, V), atom_string(V, S)), Vecinos),
    atom_string(Nombre, NStr),
    Resultado = _{nombre: NStr, vecinos: Vecinos}.

resolver("vecinos", _, _{error: "Planeta no encontrado"}).


% --- sistema: Datos del sistema solar ---
resolver("sistema", _, Resultado) :-
    findall(
        _{clave: K, valor: V},
        (dato_sistema(A, Val), atom_string(A, K), format(atom(V), "~w", [Val])),
        Datos
    ),
    Resultado = _{datos: Datos}.


% --- mayor: Planeta mas grande ---
resolver("mayor", _, Resultado) :-
    planeta_mayor_radio(P),
    radio_km(P, R),
    atom_string(P, PStr),
    Resultado = _{planeta: PStr, radio_km: R}.


% --- menor: Planeta mas pequeno ---
resolver("menor", _, Resultado) :-
    planeta_menor_radio(P),
    radio_km(P, R),
    atom_string(P, PStr),
    Resultado = _{planeta: PStr, radio_km: R}.


% --- mas_caliente: Planeta mas caliente ---
resolver("mas_caliente", _, Resultado) :-
    planeta_mas_caliente(P),
    temperatura_media(P, T),
    atom_string(P, PStr),
    Resultado = _{planeta: PStr, temperatura_celsius: T}.


% --- mas_frio: Planeta mas frio ---
resolver("mas_frio", _, Resultado) :-
    planeta_mas_frio(P),
    temperatura_media(P, T),
    atom_string(P, PStr),
    Resultado = _{planeta: PStr, temperatura_celsius: T}.


% --- Operacion desconocida ---
resolver(_, _, _{error: "Operacion no reconocida"}).

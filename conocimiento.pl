% ============================================================
% BASE DE CONOCIMIENTO - SISTEMA SOLAR
% Entrega 2 - Fundamentos de Inteligencia Artificial
% Grupo 8
% ============================================================


% ------------------------------------------------------------
% PLANETAS
% planeta(Nombre).
% ------------------------------------------------------------

planeta(mercurio).
planeta(venus).
planeta(tierra).
planeta(marte).
planeta(jupiter).
planeta(saturno).
planeta(urano).
planeta(neptuno).


% ------------------------------------------------------------
% PLANETA ENANO
% planeta_enano_hecho(Nombre).
% ------------------------------------------------------------

planeta_enano_hecho(pluton).


% ------------------------------------------------------------
% TIPO DE PLANETA
% tipo_planeta(Nombre, Tipo).
%   Tipo: rocoso | gaseoso | helado | enano
% ------------------------------------------------------------

tipo_planeta(mercurio, rocoso).
tipo_planeta(venus, rocoso).
tipo_planeta(tierra, rocoso).
tipo_planeta(marte, rocoso).
tipo_planeta(jupiter, gaseoso).
tipo_planeta(saturno, gaseoso).
tipo_planeta(urano, helado).
tipo_planeta(neptuno, helado).
tipo_planeta(pluton, enano).


% ------------------------------------------------------------
% POSICION ORBITAL
% posicion_orbital(Nombre, Numero).
% ------------------------------------------------------------

posicion_orbital(mercurio, 1).
posicion_orbital(venus, 2).
posicion_orbital(tierra, 3).
posicion_orbital(marte, 4).
posicion_orbital(jupiter, 5).
posicion_orbital(saturno, 6).
posicion_orbital(urano, 7).
posicion_orbital(neptuno, 8).
posicion_orbital(pluton, 9).


% ------------------------------------------------------------
% DISTANCIA AL SOL (en Unidades Astronomicas)
% distancia_sol(Nombre, UA).
% ------------------------------------------------------------

distancia_sol(mercurio, 0.39).
distancia_sol(venus, 0.72).
distancia_sol(tierra, 1.0).
distancia_sol(marte, 1.52).
distancia_sol(jupiter, 5.20).
distancia_sol(saturno, 9.58).
distancia_sol(urano, 19.22).
distancia_sol(neptuno, 30.05).
distancia_sol(pluton, 39.48).


% ------------------------------------------------------------
% RADIO (en kilometros)
% radio_km(Nombre, Radio).
% ------------------------------------------------------------

radio_km(mercurio, 2440).
radio_km(venus, 6052).
radio_km(tierra, 6371).
radio_km(marte, 3390).
radio_km(jupiter, 69911).
radio_km(saturno, 58232).
radio_km(urano, 25362).
radio_km(neptuno, 24622).
radio_km(pluton, 1188).


% ------------------------------------------------------------
% MASA (en masas terrestres)
% masa_terrestre(Nombre, Masa).
% ------------------------------------------------------------

masa_terrestre(mercurio, 0.055).
masa_terrestre(venus, 0.815).
masa_terrestre(tierra, 1.0).
masa_terrestre(marte, 0.107).
masa_terrestre(jupiter, 317.8).
masa_terrestre(saturno, 95.2).
masa_terrestre(urano, 14.5).
masa_terrestre(neptuno, 17.1).
masa_terrestre(pluton, 0.002).


% ------------------------------------------------------------
% PERIODO ORBITAL (en dias terrestres)
% periodo_orbital(Nombre, Dias).
% ------------------------------------------------------------

periodo_orbital(mercurio, 88.0).
periodo_orbital(venus, 224.7).
periodo_orbital(tierra, 365.25).
periodo_orbital(marte, 687.0).
periodo_orbital(jupiter, 4333.0).
periodo_orbital(saturno, 10759.0).
periodo_orbital(urano, 30687.0).
periodo_orbital(neptuno, 60190.0).
periodo_orbital(pluton, 90560.0).


% ------------------------------------------------------------
% PERIODO DE ROTACION (en horas terrestres)
% periodo_rotacion(Nombre, Horas).
%   Valores negativos indican rotacion retrograda.
% ------------------------------------------------------------

periodo_rotacion(mercurio, 1407.6).
periodo_rotacion(venus, -5832.5).
periodo_rotacion(tierra, 23.93).
periodo_rotacion(marte, 24.62).
periodo_rotacion(jupiter, 9.93).
periodo_rotacion(saturno, 10.66).
periodo_rotacion(urano, -17.24).
periodo_rotacion(neptuno, 16.11).
periodo_rotacion(pluton, -153.3).


% ------------------------------------------------------------
% TEMPERATURA MEDIA (en grados Celsius)
% temperatura_media(Nombre, Celsius).
% ------------------------------------------------------------

temperatura_media(mercurio, 167).
temperatura_media(venus, 464).
temperatura_media(tierra, 15).
temperatura_media(marte, -62).
temperatura_media(jupiter, -110).
temperatura_media(saturno, -140).
temperatura_media(urano, -195).
temperatura_media(neptuno, -200).
temperatura_media(pluton, -230).


% ------------------------------------------------------------
% GRAVEDAD EN SUPERFICIE (en m/s^2)
% gravedad_superficie(Nombre, Gravedad).
% ------------------------------------------------------------

gravedad_superficie(mercurio, 3.7).
gravedad_superficie(venus, 8.87).
gravedad_superficie(tierra, 9.81).
gravedad_superficie(marte, 3.72).
gravedad_superficie(jupiter, 24.79).
gravedad_superficie(saturno, 10.44).
gravedad_superficie(urano, 8.87).
gravedad_superficie(neptuno, 11.15).
gravedad_superficie(pluton, 0.62).


% ------------------------------------------------------------
% ANILLOS
% tiene_anillos(Nombre).
% ------------------------------------------------------------

tiene_anillos(jupiter).
tiene_anillos(saturno).
tiene_anillos(urano).
tiene_anillos(neptuno).


% ------------------------------------------------------------
% ATMOSFERA
% tiene_atmosfera(Nombre).
% ------------------------------------------------------------

tiene_atmosfera(venus).
tiene_atmosfera(tierra).
tiene_atmosfera(marte).
tiene_atmosfera(jupiter).
tiene_atmosfera(saturno).
tiene_atmosfera(urano).
tiene_atmosfera(neptuno).
tiene_atmosfera(pluton).


% ------------------------------------------------------------
% COMPOSICION ATMOSFERICA
% gas_atmosfera(Nombre, Gas).
% ------------------------------------------------------------

gas_atmosfera(venus, dioxido_de_carbono).
gas_atmosfera(venus, nitrogeno).

gas_atmosfera(tierra, nitrogeno).
gas_atmosfera(tierra, oxigeno).
gas_atmosfera(tierra, argon).
gas_atmosfera(tierra, dioxido_de_carbono).

gas_atmosfera(marte, dioxido_de_carbono).
gas_atmosfera(marte, nitrogeno).
gas_atmosfera(marte, argon).

gas_atmosfera(jupiter, hidrogeno).
gas_atmosfera(jupiter, helio).

gas_atmosfera(saturno, hidrogeno).
gas_atmosfera(saturno, helio).

gas_atmosfera(urano, hidrogeno).
gas_atmosfera(urano, helio).
gas_atmosfera(urano, metano).

gas_atmosfera(neptuno, hidrogeno).
gas_atmosfera(neptuno, helio).
gas_atmosfera(neptuno, metano).

gas_atmosfera(pluton, nitrogeno).
gas_atmosfera(pluton, metano).
gas_atmosfera(pluton, monoxido_de_carbono).


% ------------------------------------------------------------
% CANTIDAD DE LUNAS
% cantidad_lunas(Nombre, Cantidad).
% ------------------------------------------------------------

cantidad_lunas(mercurio, 0).
cantidad_lunas(venus, 0).
cantidad_lunas(tierra, 1).
cantidad_lunas(marte, 2).
cantidad_lunas(jupiter, 95).
cantidad_lunas(saturno, 146).
cantidad_lunas(urano, 28).
cantidad_lunas(neptuno, 16).
cantidad_lunas(pluton, 5).


% ------------------------------------------------------------
% LUNAS NOTABLES
% luna(NombreLuna, Planeta).
% ------------------------------------------------------------

luna(la_luna, tierra).
luna(fobos, marte).
luna(deimos, marte).
luna(io, jupiter).
luna(europa, jupiter).
luna(ganimedes, jupiter).
luna(calisto, jupiter).
luna(titan, saturno).
luna(encelado, saturno).
luna(mimas, saturno).
luna(rea, saturno).
luna(dione, saturno).
luna(titania, urano).
luna(oberon, urano).
luna(miranda, urano).
luna(ariel, urano).
luna(triton, neptuno).
luna(nereida, neptuno).
luna(caronte, pluton).
luna(nix, pluton).
luna(hidra, pluton).


% ------------------------------------------------------------
% DESCRIPCION DE LUNAS NOTABLES
% descripcion_luna(NombreLuna, Descripcion).
% ------------------------------------------------------------

descripcion_luna(la_luna, 'Unico satelite natural de la Tierra, 5ta luna mas grande del sistema solar').
descripcion_luna(fobos, 'Luna mas grande de Marte, forma irregular, orbita muy cercana al planeta').
descripcion_luna(deimos, 'Luna mas pequena de Marte, forma irregular').
descripcion_luna(io, 'Cuerpo mas volcanicamente activo del sistema solar').
descripcion_luna(europa, 'Posible oceano subterraneo bajo su corteza de hielo, candidata para buscar vida').
descripcion_luna(ganimedes, 'Luna mas grande del sistema solar, mas grande que Mercurio').
descripcion_luna(calisto, 'Uno de los cuerpos mas craterizados del sistema solar').
descripcion_luna(titan, 'Segunda luna mas grande, unica luna con atmosfera densa, tiene lagos de metano').
descripcion_luna(encelado, 'Geiseres de agua en su polo sur, posible oceano subterraneo').
descripcion_luna(mimas, 'Conocida como la Estrella de la Muerte por su gran crater Herschel').
descripcion_luna(triton, 'Luna mas grande de Neptuno, orbita retrograda, posiblemente capturada del cinturon de Kuiper').
descripcion_luna(caronte, 'Luna mas grande de Pluton, forma un sistema binario con el').


% ------------------------------------------------------------
% DESCUBRIMIENTO
% descubierto_por(Nombre, Descubridor, Anio).
% Los planetas visibles a simple vista se marcan como 'antiguedad'.
% ------------------------------------------------------------

descubierto_por(mercurio, antiguedad, 0).
descubierto_por(venus, antiguedad, 0).
descubierto_por(marte, antiguedad, 0).
descubierto_por(jupiter, antiguedad, 0).
descubierto_por(saturno, antiguedad, 0).
descubierto_por(urano, 'William Herschel', 1781).
descubierto_por(neptuno, 'Johann Galle', 1846).
descubierto_por(pluton, 'Clyde Tombaugh', 1930).


% ------------------------------------------------------------
% MISIONES ESPACIALES
% mision(NombreMision, Destino, AnioLanzamiento, Agencia).
% ------------------------------------------------------------

mision(mariner_10, mercurio, 1973, 'NASA').
mision(messenger, mercurio, 2004, 'NASA').
mision(bepicolombo, mercurio, 2018, 'ESA/JAXA').
mision(mariner_2, venus, 1962, 'NASA').
mision(venera_7, venus, 1970, 'URSS').
mision(magellan, venus, 1989, 'NASA').
mision(apolo_11, tierra, 1969, 'NASA').
mision(mariner_4, marte, 1964, 'NASA').
mision(viking_1, marte, 1975, 'NASA').
mision(viking_2, marte, 1975, 'NASA').
mision(spirit, marte, 2003, 'NASA').
mision(opportunity, marte, 2003, 'NASA').
mision(curiosity, marte, 2011, 'NASA').
mision(perseverance, marte, 2020, 'NASA').
mision(insight, marte, 2018, 'NASA').
mision(pioneer_10, jupiter, 1972, 'NASA').
mision(pioneer_11, jupiter, 1973, 'NASA').
mision(voyager_1, jupiter, 1977, 'NASA').
mision(voyager_2, jupiter, 1977, 'NASA').
mision(galileo, jupiter, 1989, 'NASA').
mision(juno, jupiter, 2011, 'NASA').
mision(voyager_1, saturno, 1977, 'NASA').
mision(voyager_2, saturno, 1977, 'NASA').
mision(cassini_huygens, saturno, 1997, 'NASA/ESA').
mision(voyager_2, urano, 1977, 'NASA').
mision(voyager_2, neptuno, 1977, 'NASA').
mision(new_horizons, pluton, 2006, 'NASA').


% ------------------------------------------------------------
% CARACTERISTICAS ESPECIALES
% caracteristica(Nombre, Descripcion).
% ------------------------------------------------------------

caracteristica(mercurio, 'Planeta con mayor variacion de temperatura entre dia y noche').
caracteristica(mercurio, 'Superficie muy craterizada similar a la Luna').
caracteristica(mercurio, 'Planeta mas pequeno del sistema solar').
caracteristica(venus, 'Planeta mas caliente del sistema solar debido al efecto invernadero').
caracteristica(venus, 'Rota en sentido retrogrado (contrario a la mayoria)').
caracteristica(venus, 'Conocido como la estrella del alba o del atardecer').
caracteristica(venus, 'Un dia en Venus es mas largo que su anio').
caracteristica(tierra, 'Unico planeta conocido con vida').
caracteristica(tierra, 'Unico planeta con agua liquida en su superficie').
caracteristica(tierra, 'Tiene un campo magnetico que protege de la radiacion solar').
caracteristica(marte, 'Conocido como el Planeta Rojo por el oxido de hierro en su superficie').
caracteristica(marte, 'Tiene el volcan mas alto del sistema solar: Olympus Mons (21.9 km)').
caracteristica(marte, 'Tiene el canon mas largo del sistema solar: Valles Marineris (4000 km)').
caracteristica(jupiter, 'Planeta mas grande del sistema solar').
caracteristica(jupiter, 'Tiene la Gran Mancha Roja, una tormenta que dura siglos').
caracteristica(jupiter, 'Campo magnetico mas fuerte de todos los planetas').
caracteristica(jupiter, 'Tiene mas de 95 lunas conocidas').
caracteristica(saturno, 'Famoso por sus espectaculares anillos de hielo y roca').
caracteristica(saturno, 'Planeta menos denso del sistema solar, flotaria en agua').
caracteristica(saturno, 'Tiene mas lunas conocidas que cualquier otro planeta (146)').
caracteristica(urano, 'Rota inclinado casi 98 grados sobre su lado').
caracteristica(urano, 'Tiene la atmosfera planetaria mas fria (-224 grados C minimo)').
caracteristica(urano, 'Fue el primer planeta descubierto con telescopio').
caracteristica(neptuno, 'Tiene los vientos mas fuertes del sistema solar (hasta 2100 km/h)').
caracteristica(neptuno, 'Planeta mas distante del Sol').
caracteristica(neptuno, 'Su existencia fue predicha matematicamente antes de ser observado').
caracteristica(pluton, 'Reclasificado como planeta enano en 2006 por la UAI').
caracteristica(pluton, 'Tiene una formacion de hielo en forma de corazon llamada Tombaugh Regio').
caracteristica(pluton, 'Su orbita es mas eliptica e inclinada que la de los planetas').


% ------------------------------------------------------------
% DATOS DEL SISTEMA SOLAR
% dato_sistema(Atributo, Valor).
% ------------------------------------------------------------

dato_sistema(edad, '4600 millones de anios').
dato_sistema(estrella, 'Sol (tipo G2V, enana amarilla)').
dato_sistema(ubicacion, 'Via Lactea, brazo de Orion').
dato_sistema(numero_planetas, 8).
dato_sistema(numero_planetas_enanos, 5).
dato_sistema(planetas_enanos, 'Pluton, Eris, Haumea, Makemake, Ceres').
dato_sistema(cinturon_asteroides, 'Entre Marte y Jupiter').
dato_sistema(cinturon_kuiper, 'Mas alla de Neptuno').
dato_sistema(nube_oort, 'Limite exterior del sistema solar').


% ============================================================
% REGLAS (INFERENCIA)
% ============================================================


% ------------------------------------------------------------
% CUERPO CELESTE
% Un cuerpo celeste es un planeta o un planeta enano.
% cuerpo_celeste(Nombre).
% ------------------------------------------------------------

cuerpo_celeste(Nombre) :- planeta(Nombre).
cuerpo_celeste(Nombre) :- planeta_enano_hecho(Nombre).


% ------------------------------------------------------------
% PLANETA INTERIOR
% Los planetas con posicion orbital <= 4.
% planeta_interior(Nombre).
% ------------------------------------------------------------

planeta_interior(Nombre) :-
    planeta(Nombre),
    posicion_orbital(Nombre, Pos),
    Pos =< 4.


% ------------------------------------------------------------
% PLANETA EXTERIOR
% Los planetas con posicion orbital > 4.
% planeta_exterior(Nombre).
% ------------------------------------------------------------

planeta_exterior(Nombre) :-
    planeta(Nombre),
    posicion_orbital(Nombre, Pos),
    Pos > 4.


% ------------------------------------------------------------
% CLASIFICACIONES POR TIPO
% gigante_gaseoso(Nombre).
% gigante_helado(Nombre).
% planeta_rocoso(Nombre).
% planeta_enano(Nombre).
% ------------------------------------------------------------

gigante_gaseoso(Nombre) :-
    tipo_planeta(Nombre, gaseoso).

gigante_helado(Nombre) :-
    tipo_planeta(Nombre, helado).

planeta_rocoso(Nombre) :-
    tipo_planeta(Nombre, rocoso).

planeta_enano(Nombre) :-
    tipo_planeta(Nombre, enano).


% ------------------------------------------------------------
% TIENE LUNAS / SIN LUNAS
% con_lunas(Nombre).
% sin_lunas(Nombre).
% ------------------------------------------------------------

con_lunas(Nombre) :-
    cuerpo_celeste(Nombre),
    cantidad_lunas(Nombre, C),
    C > 0.

sin_lunas(Nombre) :-
    cuerpo_celeste(Nombre),
    cantidad_lunas(Nombre, 0).


% ------------------------------------------------------------
% ROTACION RETROGRADA
% rotacion_retrograda(Nombre).
% ------------------------------------------------------------

rotacion_retrograda(Nombre) :-
    periodo_rotacion(Nombre, Horas),
    Horas < 0.


% ------------------------------------------------------------
% COMPARACIONES
% mas_grande(P1, P2).
% mas_cercano_sol(P1, P2).
% mas_caliente(P1, P2).
% mas_masivo(P1, P2).
% ------------------------------------------------------------

mas_grande(P1, P2) :-
    cuerpo_celeste(P1),
    cuerpo_celeste(P2),
    P1 \= P2,
    radio_km(P1, R1),
    radio_km(P2, R2),
    R1 > R2.

mas_cercano_sol(P1, P2) :-
    cuerpo_celeste(P1),
    cuerpo_celeste(P2),
    P1 \= P2,
    distancia_sol(P1, D1),
    distancia_sol(P2, D2),
    D1 < D2.

mas_caliente(P1, P2) :-
    cuerpo_celeste(P1),
    cuerpo_celeste(P2),
    P1 \= P2,
    temperatura_media(P1, T1),
    temperatura_media(P2, T2),
    T1 > T2.

mas_masivo(P1, P2) :-
    cuerpo_celeste(P1),
    cuerpo_celeste(P2),
    P1 \= P2,
    masa_terrestre(P1, M1),
    masa_terrestre(P2, M2),
    M1 > M2.


% ------------------------------------------------------------
% PLANETA CON MAYOR/MENOR RADIO
% planeta_mayor_radio(Nombre).
% planeta_menor_radio(Nombre).
% ------------------------------------------------------------

planeta_mayor_radio(P) :-
    planeta(P),
    radio_km(P, R),
    \+ (planeta(Otro), Otro \= P, radio_km(Otro, R2), R2 > R).

planeta_menor_radio(P) :-
    planeta(P),
    radio_km(P, R),
    \+ (planeta(Otro), Otro \= P, radio_km(Otro, R2), R2 < R).


% ------------------------------------------------------------
% PLANETA MAS CALIENTE / MAS FRIO
% planeta_mas_caliente(Nombre).
% planeta_mas_frio(Nombre).
% ------------------------------------------------------------

planeta_mas_caliente(P) :-
    planeta(P),
    temperatura_media(P, T),
    \+ (planeta(Otro), Otro \= P, temperatura_media(Otro, T2), T2 > T).

planeta_mas_frio(P) :-
    planeta(P),
    temperatura_media(P, T),
    \+ (planeta(Otro), Otro \= P, temperatura_media(Otro, T2), T2 < T).


% ------------------------------------------------------------
% VECINOS ORBITALES
% vecino(P1, P2).
% Dos cuerpos son vecinos si sus posiciones difieren en 1.
% ------------------------------------------------------------

vecino(P1, P2) :-
    cuerpo_celeste(P1),
    cuerpo_celeste(P2),
    P1 \= P2,
    posicion_orbital(P1, N1),
    posicion_orbital(P2, N2),
    Diff is abs(N1 - N2),
    Diff =:= 1.


% ------------------------------------------------------------
% EXPLORADO POR
% explorado_por(Planeta, Agencia).
% Un planeta fue explorado por una agencia si hay una mision.
% ------------------------------------------------------------

explorado_por(Planeta, Agencia) :-
    mision(_, Planeta, _, Agencia).


% ------------------------------------------------------------
% PERIODO ORBITAL EN ANIOS TERRESTRES
% periodo_anios(Nombre, Anios).
% ------------------------------------------------------------

periodo_anios(Nombre, Anios) :-
    periodo_orbital(Nombre, Dias),
    Anios is Dias / 365.25.


% ------------------------------------------------------------
% DURACION DE UN DIA EN HORAS (valor absoluto)
% duracion_dia(Nombre, Horas).
% ------------------------------------------------------------

duracion_dia(Nombre, Horas) :-
    periodo_rotacion(Nombre, H),
    Horas is abs(H).


% ------------------------------------------------------------
% VALIDACIONES
% ------------------------------------------------------------

cuerpo_valido(Nombre) :- cuerpo_celeste(Nombre).
tipo_valido(Tipo) :- tipo_planeta(_, Tipo).

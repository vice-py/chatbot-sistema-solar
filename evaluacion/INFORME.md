# Informe de Evaluacion - Chatbot del Sistema Solar

**Asignatura:** Fundamentos de Inteligencia Artificial
**Entrega:** Proyecto 2 - Chatbot basado en Logica de Primer Orden
**Grupo:** 8
**Fecha:** Noviembre 2026

---

## 1. Dominio seleccionado y justificacion

El dominio seleccionado para este proyecto es el **Sistema Solar**. Esta eleccion se fundamenta en los siguientes criterios:

- **Dominio no informatico:** El Sistema Solar pertenece al campo de la astronomia y las ciencias naturales, cumpliendo con el requisito de que el dominio no sea de naturaleza informatica. Es un tema accesible y de interes general que permite demostrar la aplicabilidad de la logica de primer orden fuera del ambito computacional.

- **Hechos y reglas bien definidos:** El Sistema Solar cuenta con informacion factual precisa y verificable: distancias, masas, temperaturas, cantidad de lunas, composiciones atmosfericas, fechas de descubrimiento, misiones espaciales, entre otros. Estos datos se prestan naturalmente a ser representados como hechos en Prolog (por ejemplo, `temperatura_media(venus, 464)` o `tipo_planeta(jupiter, gaseoso)`).

- **Riqueza de conocimiento:** El dominio es lo suficientemente amplio para modelar relaciones complejas y reglas de inferencia. Se incluyen 9 cuerpos celestes (8 planetas y Pluton como planeta enano), 21 lunas notables, mas de 25 misiones espaciales, composiciones atmosfericas, caracteristicas especiales, y datos generales del sistema. En total, la base de conocimiento contiene mas de 400 hechos y 20 reglas de inferencia.

- **Idoneidad para logica de primer orden:** Las relaciones entre entidades del Sistema Solar se expresan naturalmente mediante predicados y reglas. Por ejemplo, la regla `planeta_interior(Nombre) :- planeta(Nombre), posicion_orbital(Nombre, Pos), Pos =< 4` permite inferir que un planeta es interior si su posicion orbital es menor o igual a 4. De manera similar, reglas como `vecino/2`, `mas_grande/2`, `mas_caliente/2` y `planeta_mayor_radio/1` demuestran inferencia logica sobre los hechos almacenados.

- **Interes pedagogico:** El Sistema Solar es un tema que genera curiosidad y permite formular preguntas variadas: desde consultas simples ("Que tipo de planeta es Jupiter?") hasta comparaciones complejas ("Comparar Marte y Jupiter"), lo cual facilita la evaluacion del chatbot con distintos niveles de complejidad.

---

## 2. Descripcion del chatbot

El chatbot del Sistema Solar implementa dos modos de operacion independientes que comparten la misma base de conocimiento en Prolog pero difieren en como interpretan las preguntas del usuario y como formulan las respuestas.

### 2.1 Arquitectura general

```
Usuario (interfaz web)
       |
       v
  Servidor WSGI (Python)
       |
       +-- Modo Prolog -----> Interprete por palabras clave --> Consulta Prolog --> Formateador de texto
       |
       +-- Modo LLM --------> Gemini (interpretacion) --> Consulta Prolog --> Gemini (redaccion)
```

El sistema se compone de los siguientes modulos:

| Modulo | Archivo | Funcion |
|---|---|---|
| Base de conocimiento | `conocimiento.pl` | Hechos y reglas en Prolog sobre el Sistema Solar |
| Interfaz de consultas | `chatbot/consultas.pl` | Lee JSON desde stdin, ejecuta consulta en Prolog, escribe JSON en stdout |
| Servicio principal | `chatbot/servicio.py` | Logica de ambos modos: interpretacion, consulta a Prolog, redaccion |
| API REST | `chatbot/wsgi.py` | Endpoints HTTP para la interfaz web |
| Servidor | `chatbot/servidor.py` | Servidor WSGI local con threading |
| Interfaz web | `chatbot/web/` | Frontend HTML/CSS/JS con selector de modo |
| Evaluacion | `chatbot/evaluar.py` | Script que ejecuta las 20 preguntas contra ambos motores |

### 2.2 Modo Prolog

El flujo del modo Prolog consta de tres etapas:

1. **Interpretacion por palabras clave:** La funcion `interpretar_simple()` analiza la pregunta del usuario mediante reglas de coincidencia de patrones. Busca palabras clave como "luna", "temperatura", "distancia", "mision", "anillos", "tipo", "comparar", entre otras, y detecta nombres de planetas en el texto. El resultado es un "plan" en formato JSON (por ejemplo, `{"operacion": "lunas", "planeta": "saturno"}`).

2. **Consulta a Prolog:** El plan se envia como JSON al proceso SWI-Prolog a traves de `subprocess`. El archivo `consultas.pl` parsea el JSON, ejecuta la consulta correspondiente contra la base de conocimiento (`conocimiento.pl`), y devuelve los datos encontrados como JSON por stdout.

3. **Formateado de respuesta:** La funcion `redactar_prolog()` toma el plan y los datos crudos, y genera una respuesta formateada con negritas en Markdown, tablas (para comparaciones) y listas (para misiones, lunas, etc.).

### 2.3 Modo LLM

El flujo del modo LLM consta de tres etapas:

1. **Interpretacion por Gemini:** La funcion `interpretar_llm()` envia la pregunta del usuario a la API de Google Gemini junto con un prompt estructurado que describe las operaciones validas, los planetas y los tipos. Gemini devuelve un JSON con el plan de consulta. El plan es validado y sanitizado por `validar_plan()`.

2. **Consulta a Prolog:** Identico al modo Prolog. Se utiliza el mismo motor Prolog y la misma base de conocimiento para recuperar los datos factuales. Esto garantiza que ambos modos trabajan sobre la misma informacion y evita alucinaciones del LLM.

3. **Redaccion por Gemini:** Los datos obtenidos de Prolog se envian a Gemini con un prompt que le pide redactar una respuesta conversacional, amigable y en espanol, usando unicamente la informacion proporcionada. Gemini agrega contexto, comparaciones y un tono natural a la respuesta.

Esta arquitectura hibrida (LLM + Prolog) combina la capacidad de comprension de lenguaje natural del LLM con la precision y confiabilidad de los datos almacenados en la base de conocimiento Prolog.

---

## 3. Resultados de la evaluacion

Se diseñaron 20 preguntas de evaluacion que cubren todas las operaciones soportadas por el chatbot. Cada pregunta fue ejecutada contra ambos motores (Prolog y LLM) de forma automatizada mediante el script `evaluar.py`. Los resultados completos se almacenaron en `evaluacion/resultados.json`.

### 3.1 Tabla de resultados

| # | Pregunta | Respuesta Prolog (resumen) | Tiempo Prolog (ms) | Respuesta LLM (resumen) | Tiempo LLM (ms) |
|---|---|---|---|---|---|
| 1 | Que tipo de planeta es Jupiter? | Jupiter es un planeta de tipo **gaseoso**. | 157 | Jupiter es un planeta de tipo gaseoso. A diferencia de la Tierra... | 3728 |
| 2 | Cuantas lunas tiene Saturno? | Saturno tiene **146** luna(s) conocida(s). titan, encelado, mimas... | 255 | Saturno cuenta con un total de 146 lunas. Entre ellas destaca Titan... | 3828 |
| 3 | Cuales son los planetas rocosos? | Planetas: **Mercurio, Venus, Tierra, Marte**. | 165 | Los planetas rocosos son Mercurio, Venus, la Tierra y Marte... | 3518 |
| 4 | Cual es la temperatura media de Venus? | La temperatura media de Venus es **464 C**. | 328 | La temperatura media de Venus es de 464 grados Celsius... | 3759 |
| 5 | Que misiones se han enviado a Marte? | 8 misiones listadas: mariner_4, viking_1, viking_2, spirit... | 268 | La exploracion comenzo en 1964 con Mariner 4... 8 misiones detalladas. | 3977 |
| 6 | A que distancia esta la Tierra del Sol? | Tierra esta a **1.0 UA** del Sol (149,597,871 km). | 353 | La Tierra se encuentra a 149,597,870.7 km del Sol, equivalente a 1 UA... | 3272 |
| 7 | Cuales son los planetas con anillos? | Los planetas con anillos son: **Jupiter, Saturno, Urano, Neptuno**. | 150 | Jupiter, Saturno, Urano y Neptuno tienen anillos... | 3835 |
| 8 | Cual es el planeta mas grande? | El planeta mas grande es **Jupiter** con un radio de 69911 km. | 153 | Jupiter, con un radio de 69,911 km... | 3217 |
| 9 | Quien descubrio Urano? | Urano fue descubierto por **William Herschel** en **1781**. | 145 | Urano fue descubierto en 1781 por William Herschel... | 3563 |
| 10 | Composicion atmosferica de Marte? | Atmosfera: **dioxido de carbono, nitrogeno, argon**. | 287 | Compuesta por dioxido de carbono, nitrogeno y argon... | 3772 |
| 11 | Cuales son los planetas exteriores? | Planetas exteriores: **Jupiter, Saturno, Urano, Neptuno**. | 319 | Los planetas exteriores son Jupiter, Saturno, Urano y Neptuno... | 3974 |
| 12 | Caracteristicas especiales de Saturno? | 3 caracteristicas: anillos de hielo, menos denso, 146 lunas. | 180 | Famoso por sus anillos de hielo y roca, el menos denso, 146 lunas... | 3775 |
| 13 | Cuales son los vecinos de la Tierra? | Los vecinos orbitales de Tierra son: **Venus, Marte**. | 335 | Los vecinos directos de la Tierra son Venus y Marte... | 4323 |
| 14 | Cual es el planeta mas frio? | El planeta mas frio es **Neptuno** con -200 C. | 315 | Neptuno, con una temperatura de -200 grados Celsius... | 3576 |
| 15 | Comparar Marte y Jupiter | Tabla comparativa: radio, masa, distancia, temperatura, lunas. | 396 | Comparacion detallada en parrafos: tamano, ubicacion, lunas, temperatura... | 3746 |
| 16 | Cuantas lunas tiene Pluton? | Pluton tiene **5** luna(s) conocida(s). caronte, nix, hidra. | 168 | Pluton cuenta con 5 lunas. Destaca Caronte, Nix e Hidra... | 3422 |
| 17 | Cuales son los planetas gaseosos? | Planetas: **Jupiter, Saturno**. | 298 | Los planetas gaseosos son Jupiter y Saturno... | 3585 |
| 18 | Cual es el planeta mas caliente? | El planeta mas caliente es **Venus** con 464 C. | 431 | Venus, con 464 grados Celsius... | 4374 |
| 19 | Cuentame sobre Neptuno | Ficha completa: tipo, posicion, distancia, radio, masa, etc. | 202 | Descripcion extensa y conversacional de Neptuno con todos los datos... | 11564 |
| 20 | Datos generales del sistema solar? | Datos del Sistema Solar: edad, estrella, ubicacion, planetas, etc. | 260 | Descripcion conversacional del Sistema Solar con todos los datos... | 6589 |

### 3.2 Estadisticas generales

| Metrica | Modo Prolog | Modo LLM |
|---|---|---|
| Preguntas respondidas correctamente | **20 / 20** (100%) | **20 / 20** (100%) |
| Plan generado correctamente | **20 / 20** (100%) | **20 / 20** (100%)\* |
| Tiempo promedio de respuesta | **258.2 ms** | **4,269.9 ms** |
| Tiempo minimo | 145 ms (P9: descubrimiento Urano) | 3,217 ms (P8: planeta mas grande) |
| Tiempo maximo | 431 ms (P18: planeta mas caliente) | 11,564 ms (P19: info Neptuno) |
| Desviacion estandar (tiempo) | ~88.8 ms | ~1,854.1 ms |
| Factor de velocidad (Prolog vs LLM) | **~16.5x mas rapido** | referencia |

\* *En la pregunta 15 (comparar), ambos modos identificaron correctamente la operacion y los dos planetas. La unica diferencia es el orden: Prolog detecto `planeta1=jupiter, planeta2=marte` mientras que LLM detecto `planeta1=marte, planeta2=jupiter`. El resultado factual es identico.*

### 3.3 Desglose de tiempos por pregunta

| # | Operacion | Prolog (ms) | LLM (ms) | Factor |
|---|---|---|---|---|
| 1 | tipo | 157 | 3,728 | 23.7x |
| 2 | lunas | 255 | 3,828 | 15.0x |
| 3 | planetas_tipo | 165 | 3,518 | 21.3x |
| 4 | temperatura | 328 | 3,759 | 11.5x |
| 5 | misiones | 268 | 3,977 | 14.8x |
| 6 | distancia | 353 | 3,272 | 9.3x |
| 7 | anillos | 150 | 3,835 | 25.6x |
| 8 | mayor | 153 | 3,217 | 21.0x |
| 9 | descubrimiento | 145 | 3,563 | 24.6x |
| 10 | atmosfera | 287 | 3,772 | 13.1x |
| 11 | planetas_exteriores | 319 | 3,974 | 12.5x |
| 12 | caracteristicas | 180 | 3,775 | 21.0x |
| 13 | vecinos | 335 | 4,323 | 12.9x |
| 14 | mas_frio | 315 | 3,576 | 11.4x |
| 15 | comparar | 396 | 3,746 | 9.5x |
| 16 | lunas | 168 | 3,422 | 20.4x |
| 17 | planetas_tipo | 298 | 3,585 | 12.0x |
| 18 | mas_caliente | 431 | 4,374 | 10.1x |
| 19 | info | 202 | 11,564 | 57.2x |
| 20 | sistema | 260 | 6,589 | 25.3x |

**Nota:** Las preguntas 19 y 20 presentan tiempos LLM significativamente mayores porque involucran grandes volumenes de datos (ficha completa de un planeta e informacion general del sistema solar), lo cual requiere que Gemini genere respuestas mas extensas.

---

## 4. Analisis del desempeno

### 4.1 Velocidad de respuesta

El modo Prolog es, en promedio, aproximadamente **16.5 veces mas rapido** que el modo LLM. Los tiempos del modo Prolog se mantienen consistentemente por debajo de los 500 ms (rango: 145-431 ms), mientras que el modo LLM oscila entre 3.2 y 11.6 segundos. Esta diferencia se debe fundamentalmente a que el modo LLM requiere dos llamadas a la API de Gemini (interpretacion + redaccion) ademas de la consulta a Prolog, mientras que el modo Prolog solo requiere procesamiento local.

El factor de velocidad varia considerablemente segun la pregunta: para consultas simples como "tipo de planeta" o "descubrimiento", el factor supera 20x, mientras que para consultas complejas como "comparar" o "distancia", el factor se reduce a ~10x porque el propio Prolog tarda un poco mas en el procesamiento.

### 4.2 Precision en la interpretacion

Ambos modos lograron un **100% de precision** en la interpretacion de las 20 preguntas de evaluacion. En todos los casos, el plan generado (operacion + parametros) coincidio con el plan esperado. Esto demuestra que:

- El interprete de palabras clave del modo Prolog esta bien calibrado para las preguntas tipicas sobre el Sistema Solar.
- Gemini (en el modo LLM) interpreta correctamente las preguntas en lenguaje natural y las traduce fielmente al formato de plan JSON requerido.

### 4.3 Calidad de las respuestas

**Modo Prolog:** Las respuestas son **estructuradas y formateadas** con Markdown. Utilizan negritas para datos clave, listas con vinetas para enumerar elementos (misiones, lunas, caracteristicas), y tablas para comparaciones. Son concisas, van directo al dato solicitado y siguen un formato predecible.

*Ejemplo (Pregunta 15 - Comparar Marte y Jupiter):*
```
**Comparacion entre Jupiter y Marte:**
| | Jupiter | Marte |
|---|---|---|
| Radio (km) | 69911 | 3390 |
| Masa (M.T.) | 317.8 | 0.107 |
...
```

**Modo LLM:** Las respuestas son **conversacionales y en lenguaje natural**. Gemini redacta parrafos fluidos, agrega saludos y frases de cortesia, y enriquece la informacion con contexto y comparaciones. Por ejemplo, ante la pregunta sobre la temperatura de Venus, no solo dice "464 C" sino que agrega "lo que lo convierte en el planeta mas caliente de todo el Sistema Solar".

*Ejemplo (Pregunta 15 - Comparar Marte y Jupiter):*
```
Para empezar hablemos de su ubicacion y tamano. Marte se encuentra a
1.52 unidades astronomicas del Sol, mientras que Jupiter esta mucho
mas lejos, a 5.2 unidades astronomicas...
```

### 4.4 Valor agregado del LLM

El modo LLM agrega automaticamente:

- **Contexto adicional:** Explica por que un dato es relevante (e.g., "Neptuno... Es un lugar realmente congelado!").
- **Comparaciones utiles:** Pone los datos en perspectiva (e.g., "su masa es 17.1 veces la de la Tierra").
- **Narrativa coherente:** Organiza multiples datos en una historia comprensible en lugar de una lista.
- **Lenguaje accesible:** Usa un tono amigable y didactico, adecuado para usuarios no expertos.

---

## 5. Fortalezas y debilidades de cada implementacion

### 5.1 Modo Prolog

| Fortalezas | Debilidades |
|---|---|
| **Velocidad:** Respuestas en menos de 500 ms, adecuado para uso interactivo en tiempo real. | **Interpretacion rigida:** Depende de un conjunto fijo de palabras clave. Preguntas formuladas de manera inusual pueden no ser comprendidas. |
| **Determinismo:** La misma pregunta siempre produce la misma respuesta. Comportamiento predecible y reproducible. | **Sin lenguaje natural:** Las respuestas son formateadas pero no conversacionales. Carecen de la naturalidad de una explicacion humana. |
| **Funcionamiento offline:** No requiere conexion a internet ni acceso a APIs externas. | **Mantenimiento del interprete:** Agregar nuevas formas de preguntar requiere modificar manualmente las reglas de palabras clave en Python. |
| **Sin costo operativo:** No consume tokens de API ni genera gastos por uso. | **Sin capacidad de desambiguacion:** Si la pregunta es ambigua, no puede solicitar aclaracion al usuario. |
| **Respuestas estructuradas:** El formato con Markdown (negritas, tablas, listas) facilita la lectura rapida de datos. | **Sin contexto entre preguntas:** Cada pregunta se procesa de forma aislada, sin memoria de la conversacion. |
| **Transparencia:** El plan de consulta es completamente auditable y trazable. | **Vocabulario limitado:** Solo reconoce sinonimos y variantes previamente programados. |

### 5.2 Modo LLM

| Fortalezas | Debilidades |
|---|---|
| **Comprension de lenguaje natural:** Gemini puede interpretar preguntas formuladas de multiples formas, incluyendo jerga, ambiguedades y variaciones sintacticas. | **Lentitud:** Tiempos de respuesta de 3-12 segundos debido a las dos llamadas a la API. |
| **Respuestas conversacionales:** Genera texto natural, amigable y didactico que enriquece la experiencia del usuario. | **Requiere internet:** Depende de la disponibilidad de la API de Google Gemini. Si la API no responde o esta caida, el modo falla. |
| **Contexto automatico:** Agrega comparaciones, explicaciones y datos complementarios sin necesidad de programarlo explicitamente. | **No determinismo:** La misma pregunta puede generar respuestas ligeramente diferentes en cada ejecucion. |
| **Manejo de ambiguedad:** Puede interpretar correctamente preguntas vagas o mal formuladas. | **Costo economico:** Cada pregunta consume tokens de la API de Gemini, lo que genera costos a escala. |
| **Escalabilidad linguistica:** No requiere modificaciones en el codigo para soportar nuevas formas de preguntar. | **Riesgo de alucinacion mitigado:** Aunque la arquitectura usa datos de Prolog, en la redaccion Gemini podria agregar informacion no contenida en los datos (mitigado por el prompt). |
| **Fallback integrado:** Si Gemini falla en la interpretacion, recurre al interprete de palabras clave como respaldo. | **Dependencia de terceros:** Cambios en la API de Gemini, modelos o politicas de uso pueden afectar el funcionamiento. |

---

## 6. Propuestas de mejora

### 6.1 Preguntas complejas de multiples pasos (multi-hop)

Actualmente, cada pregunta se resuelve con una unica consulta a Prolog. Se propone agregar soporte para preguntas que requieran encadenar multiples consultas, como:

- *"Cual de los planetas gaseosos tiene mas lunas?"* (requiere: filtrar por tipo + comparar cantidad de lunas)
- *"Que misiones han visitado planetas con anillos?"* (requiere: identificar planetas con anillos + listar misiones de cada uno)
- *"Que planetas rocosos tienen atmosfera?"* (requiere: filtrar por tipo + verificar atmosfera)

Esto implicaria extender el formato de plan para soportar operaciones compuestas y agregar reglas Prolog que combinen multiples predicados.

### 6.2 Contexto conversacional (memoria)

Implementar un sistema de memoria de conversacion para que el chatbot pueda resolver referencias anaforicas:

- *"Cuentame sobre Jupiter"* -> respuesta completa
- *"Y cuantas lunas tiene?"* -> el chatbot recuerda que se esta hablando de Jupiter

Esto podria implementarse manteniendo un historial de los ultimos N planes ejecutados y utilizando el ultimo planeta mencionado como parametro por defecto cuando no se detecte uno nuevo.

### 6.3 Modo hibrido

Crear un tercer modo que combine las ventajas de ambos motores:

- Usar el interprete de palabras clave (rapido) como primera opcion.
- Si no logra interpretar la pregunta, recurrir a Gemini para la interpretacion.
- Siempre usar Prolog para la recuperacion de datos (precision).
- Opcionalmente usar Gemini para la redaccion solo cuando el usuario lo solicite.

Esto permitiria obtener respuestas rapidas para preguntas comunes y recurrir al LLM solo cuando sea necesario.

### 6.4 Expansion de la base de conocimiento

Ampliar el dominio para incluir:

- **Mas cuerpos celestes:** Asteroides notables (Ceres, Vesta), cometas (Halley, Hale-Bopp), objetos del cinturon de Kuiper (Eris, Haumea, Makemake ya mencionados como planetas enanos pero sin datos detallados).
- **Datos de las lunas:** Radio, masa, distancia al planeta, periodo orbital de las lunas notables.
- **Estrellas cercanas:** Proxima Centauri, Alpha Centauri, Sirio.
- **Exoplanetas notables:** Proxima b, TRAPPIST-1, Kepler-452b.
- **Fenomenos astronomicos:** Eclipses, conjunciones, lluvias de meteoros.

### 6.5 Soporte de imagenes y diagramas

Integrar la capacidad de mostrar imagenes o diagramas generados dinamicamente:

- Diagrama de posiciones orbitales de los planetas.
- Graficos comparativos de tamano, masa o temperatura.
- Imagenes reales de los planetas obtenidas de APIs publicas (por ejemplo, NASA Open APIs).
- Representacion visual de las orbitas y distancias al Sol.

### 6.6 Otras mejoras potenciales

- **Internacionalizacion:** Soporte para preguntas y respuestas en ingles u otros idiomas.
- **Evaluacion automatizada con metricas NLP:** Incorporar metricas como BLEU, ROUGE o BERTScore para evaluar la calidad de las respuestas del LLM de forma cuantitativa.
- **Cache de respuestas LLM:** Almacenar respuestas previas del LLM para evitar llamadas repetidas a la API ante preguntas identicas o similares.
- **Interfaz de voz:** Integrar reconocimiento y sintesis de voz para interaccion oral con el chatbot.

---

## 7. Conclusiones

El desarrollo de este chatbot del Sistema Solar permitio explorar y comparar dos enfoques fundamentalmente distintos para la construccion de sistemas de pregunta-respuesta basados en logica de primer orden.

**Sobre la representacion del conocimiento:** La base de conocimiento en Prolog demostro ser una forma efectiva y natural de representar el dominio del Sistema Solar. Los hechos (como `temperatura_media(venus, 464)`) y las reglas de inferencia (como `planeta_interior/1` o `vecino/2`) permiten codificar tanto datos concretos como relaciones logicas derivadas. La separacion entre la base de conocimiento (`conocimiento.pl`) y la interfaz de consultas (`consultas.pl`) facilita la mantenibilidad y extension del sistema.

**Sobre los dos modos de operacion:** La evaluacion con 20 preguntas demostro que ambos modos son igualmente **precisos** en la interpretacion (100% de acierto) y en la recuperacion de informacion factual. Sin embargo, difieren significativamente en **velocidad** (Prolog es ~16.5x mas rapido) y en **calidad comunicativa** (el LLM genera respuestas mas naturales y contextualizadas). Esto sugiere que la eleccion entre uno y otro depende del caso de uso: si se prioriza la velocidad y el determinismo, el modo Prolog es superior; si se prioriza la experiencia del usuario y la naturalidad de la interaccion, el modo LLM es preferible.

**Sobre la arquitectura hibrida:** La decision de diseño mas relevante fue utilizar Prolog como fuente unica de datos en ambos modos. En el modo LLM, Gemini solo interpreta y redacta, pero nunca "inventa" datos: toda la informacion factual proviene de la base de conocimiento. Esta arquitectura mitiga el problema de alucinacion propio de los modelos de lenguaje y garantiza que las respuestas sean fieles a los hechos codificados.

**Sobre la logica de primer orden en la practica:** Este proyecto demuestra que la logica de primer orden, implementada mediante Prolog, sigue siendo una herramienta poderosa para dominios con conocimiento estructurado y reglas bien definidas. Su complementacion con modelos de lenguaje modernos (como Gemini) permite ofrecer interfaces mas humanas sin sacrificar la precision del razonamiento logico, abriendo camino hacia sistemas inteligentes hibridos que combinan lo mejor de ambos paradigmas.

---

*Informe generado a partir de la evaluacion automatizada de 20 preguntas ejecutadas contra ambos motores del chatbot. Los datos completos se encuentran en `evaluacion/resultados.json`.*

# Chatbot Sistema Solar

Chatbot sobre el Sistema Solar desarrollado para la asignatura Fundamentos de Inteligencia Artificial (CINF103), Universidad Andres Bello.

**Grupo 8** - Entrega 2

## Descripcion

El chatbot responde preguntas sobre el Sistema Solar utilizando dos motores:

- **Prolog**: Interpreta la pregunta mediante palabras clave, consulta la base de conocimiento en SWI-Prolog y formatea la respuesta.
- **LLM (Gemini)**: Utiliza Google Gemini para interpretar la pregunta en un plan estructurado, consulta Prolog para obtener los datos, y luego Gemini redacta una respuesta en lenguaje natural.

## Estructura del proyecto

| Carpeta/Archivo | Descripcion |
|---|---|
| `conocimiento.pl` | Base de conocimiento en Prolog (hechos y reglas) |
| `main.pl` | Chatbot interactivo en Prolog (menu por consola) |
| `chatbot/` | Modulo Python: servicio, servidor web, interfaz Prolog |
| `chatbot/web/` | Frontend web (HTML, CSS, JS) |
| `evaluacion/` | 20 preguntas de prueba, script de evaluacion, informe |

## Requisitos

- Python 3.8+
- SWI-Prolog (`swipl`)
- API Key de Google Gemini (solo para modo LLM)

## Instalacion y uso

1. Copiar `.env.example` a `.env` y configurar la API key:
   ```
   cp .env.example .env
   ```

2. Iniciar el servidor web:
   ```
   python -m chatbot.servidor
   ```

3. Abrir en el navegador: `http://127.0.0.1:8000`

### Chatbot por consola (solo Prolog)

```
swipl -f main.pl -g inicio
```

### Evaluacion

```
python -m chatbot.evaluar          # solo Prolog
python -m chatbot.evaluar --llm    # Prolog + LLM
```

## Dominio

El dominio escogido es el **Sistema Solar**. La base de conocimiento incluye:
- 8 planetas + 1 planeta enano (Pluton)
- Datos fisicos: radio, masa, temperatura, gravedad, distancia al Sol
- 21 lunas notables con descripciones
- 27 misiones espaciales historicas
- Caracteristicas especiales de cada cuerpo celeste
- Datos de descubrimiento
- Composicion atmosferica
- Reglas de inferencia: planetas interiores/exteriores, comparaciones, vecinos orbitales, clasificaciones

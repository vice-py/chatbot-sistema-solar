"""
Script de evaluacion del chatbot.

Ejecuta las 20 preguntas contra ambos motores (Prolog y LLM)
y guarda los resultados en un archivo JSON.

Uso:
    python -m chatbot.evaluar            (solo Prolog)
    python -m chatbot.evaluar --llm      (Prolog + LLM)
"""

import json
import os
import sys
import time

from chatbot import servicio

_BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def main():
    usar_llm = "--llm" in sys.argv

    ruta_preguntas = os.path.join(_BASE, "evaluacion", "preguntas.json")
    with open(ruta_preguntas, encoding="utf-8") as f:
        preguntas = json.load(f)

    resultados = []
    total = len(preguntas)

    for i, item in enumerate(preguntas, 1):
        pregunta = item["pregunta"]
        print(f"[{i}/{total}] {pregunta}")

        # Prolog
        r_prolog = servicio.responder(pregunta, "prolog")
        entrada = {
            "id": item["id"],
            "pregunta": pregunta,
            "prolog": {
                "respuesta": r_prolog["respuesta"],
                "plan": r_prolog["plan"],
                "tiempo_ms": r_prolog["tiempo_ms"],
            },
        }

        # LLM
        if usar_llm:
            time.sleep(4)  # Evitar cuota
            r_llm = servicio.responder(pregunta, "llm")
            entrada["llm"] = {
                "respuesta": r_llm["respuesta"],
                "plan": r_llm["plan"],
                "tiempo_ms": r_llm["tiempo_ms"],
            }

        resultados.append(entrada)

    ruta_salida = os.path.join(_BASE, "evaluacion", "resultados.json")
    with open(ruta_salida, "w", encoding="utf-8") as f:
        json.dump(resultados, f, indent=2, ensure_ascii=False)

    print(f"\nResultados guardados en {ruta_salida}")


if __name__ == "__main__":
    main()

/* Chatbot Sistema Solar - Frontend */

const mensajesEl = document.getElementById("mensajes");
const formEl = document.getElementById("form-chat");
const inputEl = document.getElementById("pregunta");
const modoEl = document.getElementById("modo");
const estadoEl = document.getElementById("estado");
const btnNueva = document.getElementById("btn-nueva");
const btnEnviar = document.getElementById("btn-enviar");

let disponible = { prolog: false, llm: false };

/* --- Estado inicial --- */
fetch("/api/estado")
  .then((r) => r.json())
  .then((d) => {
    disponible = d;
    actualizarEstado();
  })
  .catch(() => {
    estadoEl.textContent = "Sin conexion";
    estadoEl.className = "estado offline";
  });

modoEl.addEventListener("change", actualizarEstado);

function actualizarEstado() {
  const modo = modoEl.value;
  if (modo === "prolog" && disponible.prolog) {
    estadoEl.textContent = "Prolog disponible";
    estadoEl.className = "estado online";
  } else if (modo === "llm" && disponible.llm) {
    estadoEl.textContent = "LLM disponible";
    estadoEl.className = "estado online";
  } else if (modo === "prolog" && !disponible.prolog) {
    estadoEl.textContent = "Prolog no disponible";
    estadoEl.className = "estado offline";
  } else {
    estadoEl.textContent = "LLM no configurado";
    estadoEl.className = "estado offline";
  }
}

/* --- Enviar pregunta --- */
formEl.addEventListener("submit", (e) => {
  e.preventDefault();
  const pregunta = inputEl.value.trim();
  if (!pregunta) return;
  enviarPregunta(pregunta);
});

async function enviarPregunta(pregunta) {
  /* Limpiar bienvenida */
  const bienvenida = mensajesEl.querySelector(".bienvenida");
  if (bienvenida) bienvenida.remove();

  agregarMensaje(pregunta, "usuario");
  inputEl.value = "";
  inputEl.disabled = true;
  btnEnviar.disabled = true;

  const cargando = agregarMensaje("Pensando...", "bot cargando");

  try {
    const resp = await fetch("/api/chat", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ pregunta, modo: modoEl.value }),
    });
    const datos = await resp.json();
    cargando.remove();

    if (datos.error) {
      agregarMensaje("Error: " + datos.error, "bot error");
    } else {
      const el = agregarMensaje(datos.respuesta, "bot");
      if (datos.plan || datos.tiempo_ms) {
        const detalles = document.createElement("details");
        detalles.className = "meta";
        const resumen = document.createElement("summary");
        resumen.textContent = `Detalles (${datos.tiempo_ms || 0} ms)`;
        detalles.appendChild(resumen);

        if (datos.plan) {
          const pre = document.createElement("pre");
          pre.textContent = "Plan: " + JSON.stringify(datos.plan, null, 2);
          detalles.appendChild(pre);
        }
        el.appendChild(detalles);
      }
    }
  } catch (err) {
    cargando.remove();
    agregarMensaje("Error de conexion: " + err.message, "bot error");
  } finally {
    inputEl.disabled = false;
    btnEnviar.disabled = false;
    inputEl.focus();
  }
}

/* --- Crear mensaje --- */
function agregarMensaje(texto, clase) {
  const div = document.createElement("div");
  div.className = "mensaje " + clase;

  if (clase.startsWith("bot")) {
    const avatar = document.createElement("span");
    avatar.className = "avatar";
    avatar.textContent = "\u{1FA90}"; /* Saturn emoji */
    div.appendChild(avatar);
  }

  const contenido = document.createElement("div");
  contenido.className = "contenido";
  contenido.innerHTML = formatear(texto);
  div.appendChild(contenido);

  mensajesEl.appendChild(div);
  mensajesEl.scrollTop = mensajesEl.scrollHeight;
  return div;
}

/* --- Formateo basico de markdown --- */
function formatear(texto) {
  return texto
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/\*\*(.+?)\*\*/g, "<strong>$1</strong>")
    .replace(/\n/g, "<br>")
    .replace(/\|(.+)\|/g, function (match) {
      /* Tablas simples */
      const celdas = match.split("|").filter((c) => c.trim());
      if (celdas.every((c) => c.trim() === "---")) return "";
      return (
        "<tr>" +
        celdas.map((c) => "<td>" + c.trim() + "</td>").join("") +
        "</tr>"
      );
    });
}

/* --- Sugerencias --- */
document.querySelectorAll(".sugerencia").forEach((btn) => {
  btn.addEventListener("click", () => {
    inputEl.value = btn.textContent;
    enviarPregunta(btn.textContent);
  });
});

/* --- Nueva conversacion --- */
btnNueva.addEventListener("click", () => {
  mensajesEl.innerHTML = `
    <div class="bienvenida">
      <p>Hola! Soy el chatbot del Sistema Solar. Preguntame sobre planetas, lunas, misiones espaciales, temperaturas y mas.</p>
      <div class="sugerencias">
        <button class="sugerencia" type="button">Que tipo de planeta es Jupiter?</button>
        <button class="sugerencia" type="button">Cuantas lunas tiene Saturno?</button>
        <button class="sugerencia" type="button">Que misiones se han enviado a Marte?</button>
        <button class="sugerencia" type="button">Cuales son los planetas rocosos?</button>
      </div>
    </div>`;
  document.querySelectorAll(".sugerencia").forEach((btn) => {
    btn.addEventListener("click", () => {
      inputEl.value = btn.textContent;
      enviarPregunta(btn.textContent);
    });
  });
  inputEl.focus();
});

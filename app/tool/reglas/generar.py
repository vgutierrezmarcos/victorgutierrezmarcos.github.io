#!/usr/bin/env python3
"""Genera firestore.rules (en la raíz del repositorio).

Cada oposición tiene su red de preparadores y los datos de sus alumnos, con las
mismas reglas: TCEE en la raíz (admins/, preparadoresVerificados/…,
users/{uid}/…) y las demás en oposiciones/{op}/… y users/{uid}/oposiciones/{op}/….
Como Firestore no permite reutilizar un bloque `match`, las reglas de un alumno
(USUARIO) y de la red (RED) se escriben una vez aquí y se copian para cada caso.

Uso, desde la raíz del repositorio:
    python3 app/tool/reglas/generar.py
Después, probarlas (ver README.md) y publicarlas en la consola de Firebase.
"""
from pathlib import Path

# Oposiciones que pueden tener datos (la primera, TCEE, vive en la raíz).
OPOSICIONES = ['tcee', 'dce']

CABECERA = """rules_version = '2';
// GENERADO por app/tool/reglas/generar.py: no editar a mano (cambiar el script y volver a generarlo).
// Reglas de seguridad de Firestore para el proyecto web-vgm.
// Compartidas por la web (auth.js, simulator-history.js) y la app móvil.
// Aplicar desde la consola de Firebase (Firestore Database → Reglas) o con `firebase deploy --only firestore:rules`.
//
// Cada oposición tiene su red de preparadores y los datos de sus alumnos, con
// sus propios administradores: TCEE en la raíz (admins/, preparadoresVerificados/,
// users/{uid}/…) y las demás en oposiciones/{op}/… y users/{uid}/oposiciones/{op}/….
// El administrador general (admins/… de la raíz con general: true) lo es de todas.
// Un preparador de las dos tiene que estar verificado en cada una.
service cloud.firestore {
  match /databases/{database}/documents {
    function conSesion() {
      return request.auth != null;
    }

    // Con sesión y en una oposición que existe.
    function conSesionEn(op) {
      return conSesion() && op in %OPOSICIONES%;
    }

    // Correo de Google (verificado) de quien hace la petición.
    function correo() {
      return request.auth.token.get('email_verified', false) == true ? request.auth.token.get('email', '') : '';
    }

    // Documento de la red de una oposición: enRed('tcee', 'admins/x') es admins/x;
    // enRed('dce', 'admins/x'), oposiciones/dce/admins/x.
    function enRed(op, resto) {
      return path('/databases/' + database + '/documents/' + (op == 'tcee' ? '' : 'oposiciones/' + op + '/') + resto);
    }

    // Documento de los datos de un usuario en una oposición.
    function deUsuario(op, uid, resto) {
      return path('/databases/' + database + '/documents/users/' + uid + '/' + (op == 'tcee' ? '' : 'oposiciones/' + op + '/') + resto);
    }

    // Administradores de la red de una oposición: documentos creados a mano en
    // la consola (admins/… en TCEE, oposiciones/{op}/admins/… en las demás),
    // cuyo ID es el uid o el correo de Google (verificado) del administrador.
    function esAdmin(op) {
      return conSesionEn(op)
        && (exists(enRed(op, 'admins/' + request.auth.uid))
          || (correo() != '' && exists(enRed(op, 'admins/' + correo())))
          || esAdminGeneral());
    }

    // Administrador general: lo es de todas las oposiciones. Es un
    // administrador de TCEE (admins/… de la raíz) con el campo general: true.
    function esAdminGeneral() {
      return conSesion()
        && ((exists(enRed('tcee', 'admins/' + request.auth.uid)) && get(enRed('tcee', 'admins/' + request.auth.uid)).data.get('general', false) == true)
          || (correo() != '' && exists(enRed('tcee', 'admins/' + correo())) && get(enRed('tcee', 'admins/' + correo())).data.get('general', false) == true));
    }

    // Preparador verificado y en activo en esa oposición (lo da de alta su
    // administrador u otro verificado; el administrador puede retirarlo
    // poniendo activo = false).
    function esVerificado(op) {
      return conSesionEn(op)
        && exists(enRed(op, 'preparadoresVerificados/' + request.auth.uid))
        && get(enRed(op, 'preparadoresVerificados/' + request.auth.uid)).data.activo == true;
    }

    // Un preparador lo es de un alumno cuando el alumno ha creado, en sus datos
    // de esa oposición, el documento preparadores/{preparador}, y sigue
    // verificado en ella: si se le retira la verificación, pierde el acceso.
    function esPreparadorDe(op, uid) {
      return esVerificado(op) && exists(deUsuario(op, uid, 'preparadores/' + request.auth.uid));
    }

    // El usuario ha enlazado su app con ese preparador en esa oposición.
    function tengoDePreparador(op, preparador) {
      return conSesionEn(op) && exists(deUsuario(op, request.auth.uid, 'preparadores/' + preparador));
    }

    // Perfil de LinkedIn: vacío o https://www.linkedin.com/in/… (lo ven todos los usuarios con cuenta).
    function linkedinValido() {
      let l = request.resource.data.get('linkedin', '');
      return l == '' || l.matches('https://www[.]linkedin[.]com/in/[^/?#]+');
    }

    // Ficha del directorio: LinkedIn como arriba, modalidad conocida y ciudad corta.
    function fichaValida() {
      let m = request.resource.data.get('modalidad', '');
      let c = request.resource.data.get('ciudad', '');
      return linkedinValido() && m in ['', 'online', 'presencial', 'ambas'] && c is string && c.size() <= 60;
    }

    // El preparador que ha cogido la clase suelta sust_{id} del alumno (la
    // petición sustituciones/{id} está cogida por él): puede escribir esa clase
    // en la agenda del alumno y usar su cronómetro y su pizarra.
    function esSustitutoDe(op, idCante) {
      return conSesionEn(op) && idCante.matches('sust_.*')
        && get(enRed(op, 'sustituciones/' + idCante[5:])).data.get('cogidaPor', '') == request.auth.uid;
    }

    // Material (enlace) que un preparador comparte con sus alumnos: campos
    // conocidos, título corto, enlace http(s) y destinatarios bien formados.
    function materialValido() {
      let d = request.resource.data;
      return d.keys().hasOnly(['id', 'preparador', 'preparadorNombre', 'titulo', 'url', 'texto', 'tema', 'paraTodos', 'alumnos', 'creado', 'updatedAt'])
        && d.titulo is string && d.titulo.size() > 0 && d.titulo.size() <= 120
        && d.url is string && d.url.matches('https?://[^ ]+')
        && d.get('texto', '') is string && d.get('texto', '').size() <= 2000
        && d.paraTodos is bool && d.alumnos is list && d.alumnos.size() <= 200;
    }

    // Búsqueda de preparador: campos conocidos, sin nombre ni teléfono.
    function busquedaValida() {
      let d = request.resource.data;
      return d.keys().hasOnly(['id', 'alumno', 'ejercicios', 'modalidad', 'ciudad', 'disponibilidad', 'clasesPorSemana', 'temas', 'desde', 'nota', 'estado', 'creada', 'updatedAt'])
        && d.estado in ['abierta', 'cerrada']
        && d.get('nota', '') is string && d.get('nota', '').size() <= 1000
        && d.get('ciudad', '') is string && d.get('ciudad', '').size() <= 60;
    }

    function soloCambia(campos) {
      return request.resource.data.diff(resource.data).affectedKeys().hasOnly(campos);
    }

    // La hora que elige quien coge una sustitución cae dentro de la franja del
    // alumno (las fechas son textos ISO del mismo formato, que se comparan bien).
    function horaEnLaFranja() {
      let hora = request.resource.data.get('hora', resource.data.fecha);
      let hasta = resource.data.get('hasta', null);
      return (hasta == null && hora == resource.data.fecha)
        || (hasta != null && hora >= resource.data.fecha && hora <= hasta);
    }

    // Peticiones de verificación que puede ver un verificado: las abiertas a
    // todos y las que le piden a él.
    function solicitudParaMi(op) {
      return esVerificado(op) && (resource.data.paraTodos == true || resource.data.destinatario == request.auth.uid);
    }

    // Cada usuario solo puede leer y escribir su propio subárbol (en TCEE, en la
    // raíz; en las demás oposiciones, en users/{uid}/oposiciones/{op}/):
    //   exam_results/{id}        resultados de test (web y app)
    //   progress/spaced_repetition   repaso Leitner
    //   progress/settings        temas estudiados, oposición elegida
    //   progress/plan            fechas de los ejercicios, hitos y horario
    //   progress/preparador      perfil de preparador (código para alumnos)
    //   notes/{codigoTema}       notas propias por tema
    //   cantes/{id}              cantes programados y diario
    //   cronogramas/{id}         cronogramas de estudio
    //   alumnos/{id}             alumnos de un preparador
    //   sesiones/{id}            sesiones de un preparador con sus alumnos
    //   preparadores/{prep}      preparadores a los que el usuario da acceso
    //   cantes/{id}/reloj/estado cronómetro compartido con el preparador
    //   cantes/{id}/pizarra/{p}  pizarra compartida con el preparador
    match /users/{uid}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == uid;
    }
"""

# Lo que el preparador enlazado ve de su alumno, relativo a sus datos de la oposición.
USUARIO = """
      // El preparador enlazado ve los temas que marca su alumno y sus cantes.
      // No ve tests (exam_results), notas ni el resto del progreso.
      match /progress/settings {
        allow get: if esPreparadorDe(%OP%, uid);
      }
      match /cantes/{id} {
        allow read: if esPreparadorDe(%OP%, uid) || esSustitutoDe(%OP%, id);
        // Solo puede crear y cambiar los cantes que firma con su uid: los que el
        // alumno programa por su cuenta no los puede tocar. El preparador que
        // coge una clase suelta (sust_…) escribe esa clase, aunque no esté enlazado.
        allow create: if (esPreparadorDe(%OP%, uid) || esSustitutoDe(%OP%, id)) && request.resource.data.preparador == request.auth.uid;
        allow update: if ((esPreparadorDe(%OP%, uid) && resource.data.preparador == request.auth.uid) || esSustitutoDe(%OP%, id))
          && request.resource.data.preparador == request.auth.uid;

        // Cronómetro y pizarra compartidos de una clase: los manejan el alumno
        // (dueño de todo su subárbol) y el preparador que firma esa clase.
        match /{compartido}/{doc} {
          allow read, write: if compartido in ['reloj', 'pizarra']
            && (esPreparadorDe(%OP%, uid) || esSustitutoDe(%OP%, id))
            && get(deUsuario(%OP%, uid, 'cantes/' + id)).data.get('preparador', '') == request.auth.uid;
        }
      }
      // Cronograma: el preparador enlazado lo ve solo si el alumno lo comparte,
      // y solo puede escribir una propuesta firmada por él, que el alumno
      // acepta o rechaza.
      match /cronogramas/{id} {
        allow read: if esPreparadorDe(%OP%, uid) && resource.data.compartir == true;
        allow update: if esPreparadorDe(%OP%, uid)
          && resource.data.compartir == true
          && soloCambia(['propuesta', 'updatedAt'])
          && request.resource.data.propuesta.de == request.auth.uid;
      }
      // El preparador puede leer su propio permiso y renunciar a él.
      match /preparadores/{preparador} {
        allow get, delete: if conSesionEn(%OP%) && request.auth.uid == preparador;
      }
"""

# La red de preparadores de una oposición.
RED = """
      // Código que el preparador da a sus alumnos: codigos/{codigo} → { uid, nombre }.
      // Se consulta de uno en uno (no se pueden listar), solo lo reserva un
      // preparador verificado en la oposición y solo lo cambia su dueño.
      match /codigos/{codigo} {
        allow get: if conSesionEn(%OP%);
        allow create: if esVerificado(%OP%) && request.resource.data.uid == request.auth.uid;
        allow update: if conSesionEn(%OP%)
          && resource.data.uid == request.auth.uid
          && request.resource.data.uid == request.auth.uid;
        allow delete: if conSesionEn(%OP%) && resource.data.uid == request.auth.uid;
      }

      // Alumnos enlazados con un preparador: los escribe el alumno al enlazar y
      // los lee el preparador para saber quién se ha enlazado. Cualquiera de los
      // dos puede romper el enlace.
      match /preparadores/{preparador}/alumnos/{alumno} {
        allow read: if conSesionEn(%OP%) && (request.auth.uid == preparador || request.auth.uid == alumno);
        allow create, update: if conSesionEn(%OP%) && request.auth.uid == alumno && request.resource.data.uid == alumno;
        allow delete: if conSesionEn(%OP%) && (request.auth.uid == preparador || request.auth.uid == alumno);
      }

      // Lo lee cada uno el suyo (para saber si es administrador).
      match /admins/{id} {
        allow get: if conSesionEn(%OP%) && (request.auth.uid == id || (correo() != '' && correo() == id));
      }

      // Cuentas que pueden conectar Google Calendar mientras Google no
      // verifica ese permiso (las da de alta el administrador en la consola).
      // Cada uno lee solo la suya.
      match /pruebasCalendario/{id} {
        allow get: if conSesionEn(%OP%) && (request.auth.uid == id || (correo() != '' && correo() == id));
      }

      // Lista de preparadores verificados: la ve cualquiera con cuenta (para
      // elegir a quién pedir una sustitución). Da de alta el administrador o un
      // verificado, nunca uno mismo; el interesado solo cambia su ficha (nombre,
      // ejercicios, LinkedIn, modalidad y ciudad); retirar (activo = false) o
      // borrar, solo el administrador.
      match /preparadoresVerificados/{uid} {
        allow read: if conSesionEn(%OP%);
        allow create: if (esAdmin(%OP%) || (esVerificado(%OP%) && uid != request.auth.uid))
          && request.resource.data.uid == uid
          && request.resource.data.avaladoPor == request.auth.uid
          && request.resource.data.activo == true
          && fichaValida();
        allow update: if esAdmin(%OP%)
          || (conSesionEn(%OP%) && request.auth.uid == uid && resource.data.activo == true
            && soloCambia(['nombre', 'ejercicios', 'linkedin', 'modalidad', 'ciudad']) && fichaValida());
        allow delete: if esAdmin(%OP%);
      }

      // Peticiones de verificación: las crea el interesado y las leen él, el
      // administrador y los verificados: todos si va abierta (paraTodos) o solo
      // el preparador al que se la pide (destinatario). Se borran al resolverlas.
      match /solicitudesPreparador/{uid} {
        allow read: if (conSesionEn(%OP%) && request.auth.uid == uid) || esAdmin(%OP%) || solicitudParaMi(%OP%);
        allow create, update: if conSesionEn(%OP%) && request.auth.uid == uid && request.resource.data.uid == uid;
        allow delete: if (conSesionEn(%OP%) && request.auth.uid == uid) || esAdmin(%OP%) || solicitudParaMi(%OP%);
      }

      // Sustituciones: el alumno publica un cante para que se lo coja otro
      // preparador. La ven el alumno, los verificados a los que va dirigida y
      // quien la coge. Coger = pasar de abierta a cogida firmando con su uid.
      match /sustituciones/{id} {
        allow read: if (conSesionEn(%OP%) && (resource.data.alumno == request.auth.uid || resource.data.cogidaPor == request.auth.uid))
          || (esVerificado(%OP%) && (resource.data.paraTodos == true || request.auth.uid in resource.data.destinatarios));
        allow create: if conSesionEn(%OP%) && request.resource.data.alumno == request.auth.uid && request.resource.data.estado == 'abierta';
        allow update: if (conSesionEn(%OP%) && resource.data.alumno == request.auth.uid && request.resource.data.alumno == request.auth.uid)
          || (esVerificado(%OP%)
            && resource.data.estado == 'abierta'
            && resource.data.alumno != request.auth.uid
            && (resource.data.paraTodos == true || request.auth.uid in resource.data.destinatarios)
            && request.resource.data.estado == 'cogida'
            && request.resource.data.cogidaPor == request.auth.uid
            && soloCambia(['estado', 'cogidaPor', 'cogidaPorNombre', 'hora', 'updatedAt'])
            && horaEnLaFranja());
        allow delete: if conSesionEn(%OP%) && resource.data.alumno == request.auth.uid;

        // Contactos: privado/alumno (lo escribe el alumno) y privado/preparador
        // (lo escribe quien la coge). Solo los leen ellos dos. getAfter:
        // privado/alumno se escribe en el mismo lote que crea la petición, y la
        // regla tiene que verla ya creada.
        match /privado/{quien} {
          allow read: if conSesionEn(%OP%)
            && (get(enRed(%OP%, 'sustituciones/' + id)).data.alumno == request.auth.uid
              || get(enRed(%OP%, 'sustituciones/' + id)).data.cogidaPor == request.auth.uid);
          allow write: if conSesionEn(%OP%)
            && ((quien == 'alumno' && getAfter(enRed(%OP%, 'sustituciones/' + id)).data.alumno == request.auth.uid)
              || (quien == 'preparador' && getAfter(enRed(%OP%, 'sustituciones/' + id)).data.cogidaPor == request.auth.uid));
        }
      }

      // Tema que el preparador manda a su alumno antes de una clase. Está fuera
      // de los datos del alumno a propósito: el alumno solo puede leerlo a
      // partir de la hora elegida (visibleDesde), lo comprueba el servidor.
      // Solo se lee de uno en uno, nunca en listas.
      match /temasAnticipados/{id} {
        allow get: if conSesionEn(%OP%)
          && (resource.data.preparador == request.auth.uid
            || (resource.data.alumno == request.auth.uid && request.time >= resource.data.visibleDesde));
        allow create: if (esPreparadorDe(%OP%, request.resource.data.alumno) || esSustitutoDe(%OP%, id))
          && request.resource.data.preparador == request.auth.uid
          && request.resource.data.visibleDesde is timestamp
          && request.resource.data.keys().hasOnly(['alumno', 'preparador', 'preparadorNombre', 'tema', 'titulo', 'temas', 'titulos', 'sorteado', 'visibleDesde', 'updatedAt']);
        allow update: if resource.data.preparador == request.auth.uid
          && (esPreparadorDe(%OP%, resource.data.alumno) || esSustitutoDe(%OP%, id))
          && request.resource.data.preparador == request.auth.uid
          && request.resource.data.alumno == resource.data.alumno
          && request.resource.data.visibleDesde is timestamp
          && request.resource.data.keys().hasOnly(['alumno', 'preparador', 'preparadorNombre', 'tema', 'titulo', 'temas', 'titulos', 'sorteado', 'visibleDesde', 'updatedAt']);
        allow delete: if conSesionEn(%OP%) && resource.data.preparador == request.auth.uid;
      }

      // Materiales (enlaces) que un preparador comparte con todos sus alumnos
      // enlazados o con algunos. Los escribe solo él, verificado y firmando con
      // su uid (borrar, también si le han retirado la verificación, para poder
      // eliminar la cuenta); los lee el alumno enlazado al que van dirigidos.
      // El alumno los lista con dos consultas: preparador == X y paraTodos, o
      // preparador == X y alumnos contiene su uid.
      match /materiales/{id} {
        allow read: if (conSesionEn(%OP%) && resource.data.preparador == request.auth.uid)
          || (tengoDePreparador(%OP%, resource.data.preparador)
            && (resource.data.paraTodos == true || request.auth.uid in resource.data.alumnos));
        allow create: if esVerificado(%OP%) && request.resource.data.preparador == request.auth.uid && materialValido();
        allow update: if esVerificado(%OP%)
          && resource.data.preparador == request.auth.uid
          && request.resource.data.preparador == request.auth.uid
          && materialValido();
        allow delete: if conSesionEn(%OP%) && resource.data.preparador == request.auth.uid;
      }

      // Búsqueda de preparador. El opositor publica lo que busca (ejercicio,
      // modalidad, ciudad, disponibilidad, cuándo empieza, nota), sin nombre
      // ni teléfono: la ven los preparadores verificados. Un preparador puede
      // decir que le interesa (interesados/{uid}, con su contacto), y solo el
      // opositor lo lee y es él quien le escribe. No crea ninguna relación:
      // esa la hace el opositor después, con el código, si se entienden.
      match /busquedas/{id} {
        allow read: if (conSesionEn(%OP%) && resource.data.alumno == request.auth.uid) || esVerificado(%OP%);
        allow create: if conSesionEn(%OP%) && request.resource.data.alumno == request.auth.uid && busquedaValida();
        allow update: if conSesionEn(%OP%) && resource.data.alumno == request.auth.uid && request.resource.data.alumno == request.auth.uid && busquedaValida();
        allow delete: if conSesionEn(%OP%) && resource.data.alumno == request.auth.uid;

        match /interesados/{preparador} {
          allow read: if conSesionEn(%OP%)
            && (request.auth.uid == preparador || get(enRed(%OP%, 'busquedas/' + id)).data.alumno == request.auth.uid);
          allow create, update: if esVerificado(%OP%) && request.auth.uid == preparador && request.resource.data.uid == preparador;
          allow delete: if conSesionEn(%OP%)
            && (request.auth.uid == preparador || get(enRed(%OP%, 'busquedas/' + id)).data.alumno == request.auth.uid);
        }
      }

      // Plazas de un preparador: si admite alumnos nuevos, desde cuándo, su
      // disponibilidad y cómo contactarle. Las ven los opositores (quien no
      // es preparador verificado), nunca los demás preparadores.
      match /plazas/{preparador} {
        allow read: if conSesionEn(%OP%) && (request.auth.uid == preparador || !esVerificado(%OP%));
        allow write: if esVerificado(%OP%) && request.auth.uid == preparador && request.resource.data.preparador == preparador;
      }

      // Huecos libres de un preparador: los ve él y sus alumnos enlazados.
      match /huecos/{preparador} {
        allow read: if (conSesionEn(%OP%) && request.auth.uid == preparador) || tengoDePreparador(%OP%, preparador);
        allow write: if esVerificado(%OP%) && request.auth.uid == preparador;
      }

      // Reservas de un alumno en los huecos de su preparador.
      match /reservas/{id} {
        allow read: if conSesionEn(%OP%) && (resource.data.alumno == request.auth.uid || resource.data.preparador == request.auth.uid);
        allow create: if conSesionEn(%OP%)
          && request.resource.data.alumno == request.auth.uid
          && request.resource.data.estado == 'pedida'
          && tengoDePreparador(%OP%, request.resource.data.preparador);
        allow update: if conSesionEn(%OP%)
          && ((resource.data.preparador == request.auth.uid && request.resource.data.estado in ['aceptada', 'rechazada'] && soloCambia(['estado', 'updatedAt']))
            || (resource.data.alumno == request.auth.uid && request.resource.data.estado == 'cancelada' && soloCambia(['estado', 'updatedAt'])));
        allow delete: if conSesionEn(%OP%) && (resource.data.alumno == request.auth.uid || resource.data.preparador == request.auth.uid);
      }
"""

PIE = """
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
"""


def bloque(plantilla: str, op: str, sangria: str = '') -> str:
    texto = plantilla.replace('%OP%', op)
    if not sangria:
        return texto
    return '\n'.join(sangria + l if l.strip() else l for l in texto.split('\n'))


def generar() -> str:
    lista = '[' + ', '.join(f"'{o}'" for o in OPOSICIONES) + ']'
    partes = [CABECERA.replace('%OPOSICIONES%', lista)]
    partes.append("""
    // ------------------------------------------------------------------ TCEE
    // (en la raíz, como antes de que hubiera varias oposiciones)

    match /users/{uid} {""")
    partes.append(bloque(USUARIO, "'tcee'").rstrip('\n'))
    partes.append('    }')
    # La red de TCEE está en la raíz: sus bloques van un nivel menos sangrados.
    partes.append('\n'.join(l[2:] if l.startswith('  ') else l for l in bloque(RED, "'tcee'").split('\n')).rstrip('\n'))
    partes.append("""
    // ------------------------------------------------- Las demás oposiciones
    // Las mismas reglas, en users/{uid}/oposiciones/{op}/… y oposiciones/{op}/….

    match /users/{uid}/oposiciones/{op} {""")
    partes.append(bloque(USUARIO, 'op').rstrip('\n'))
    partes.append("""    }

    match /oposiciones/{op} {""")
    partes.append(bloque(RED, 'op').rstrip('\n'))
    partes.append('    }')
    partes.append(PIE)
    return '\n'.join(partes)


if __name__ == '__main__':
    destino = Path(__file__).resolve().parents[3] / 'firestore.rules'
    destino.write_text(generar(), encoding='utf-8')
    print(f'Escrito {destino}')

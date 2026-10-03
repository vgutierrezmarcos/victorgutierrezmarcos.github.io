// Prueba de firestore.rules con el emulador: node prueba.mjs (dentro de emulators:exec)
import { initializeTestEnvironment, assertSucceeds, assertFails } from '@firebase/rules-unit-testing';
import { doc, getDoc, setDoc, updateDoc, deleteDoc, collection, getDocs, query, where, writeBatch, runTransaction } from 'firebase/firestore';
import { readFileSync } from 'node:fs';

const env = await initializeTestEnvironment({ projectId: 'demo-tcee', firestore: { rules: readFileSync(process.argv[2], 'utf8'), host: '127.0.0.1', port: 8080 } });
const db = (uid) => (uid ? env.authenticatedContext(uid).firestore() : env.unauthenticatedContext().firestore());
let ok = 0, mal = 0;
async function caso(nombre, f) {
  try { await f(); ok++; console.log('  ✓', nombre); } catch (e) { mal++; console.log('  ✗', nombre, '→', e.message?.split('\n')[0]); }
}
const futuro = new Date(Date.now() + 2 * 86400e3).toISOString();

await env.clearFirestore();
// Datos de partida (sin reglas).
await env.withSecurityRulesDisabled(async (c) => {
  const d = c.firestore();
  await setDoc(doc(d, 'admins/admin'), { desde: 'consola' });
  await setDoc(doc(d, 'preparadoresVerificados/admin'), { uid: 'admin', nombre: 'Víctor', avaladoPor: 'admin', activo: true });
  await setDoc(doc(d, 'preparadoresVerificados/paula'), { uid: 'paula', nombre: 'Paula', avaladoPor: 'admin', activo: true });
  await setDoc(doc(d, 'preparadoresVerificados/retirado'), { uid: 'retirado', nombre: 'Retirado', avaladoPor: 'admin', activo: false });
  await setDoc(doc(d, 'users/alu/progress/settings'), { temasEstudiados: ['3.A.1'] });
  await setDoc(doc(d, 'users/alu/exam_results/r1'), { nota: 7 });
  await setDoc(doc(d, 'users/alu/notes/3_A_1'), { texto: 'privado' });
  await setDoc(doc(d, 'users/alu/cantes/propio'), { id: 'propio', estado: 'pendiente' });
  await setDoc(doc(d, 'users/alu/preparadores/paula'), { uid: 'paula' });
  await setDoc(doc(d, 'users/alu/preparadores/retirado'), { uid: 'retirado' });
  await setDoc(doc(d, 'solicitudesPreparador/nuevo'), { uid: 'nuevo', nombre: 'Nuevo', paraTodos: true, destinatario: null });
  await setDoc(doc(d, 'solicitudesPreparador/dirigida'), { uid: 'dirigida', nombre: 'Para Paula', paraTodos: false, destinatario: 'paula' });
  await setDoc(doc(d, 'preparadoresVerificados/olga'), { uid: 'olga', nombre: 'Olga', avaladoPor: 'admin', activo: true });
});

console.log('Datos de cada usuario');
await caso('otro opositor no lee los ajustes de un alumno', () => assertFails(getDoc(doc(db('pepe'), 'users/alu/progress/settings'))));
await caso('sin sesión no se lee nada', () => assertFails(getDoc(doc(db(null), 'users/alu/progress/settings'))));
await caso('el alumno lee lo suyo', () => assertSucceeds(getDoc(doc(db('alu'), 'users/alu/notes/3_A_1'))));
await caso('su preparador verificado lee sus temas', () => assertSucceeds(getDoc(doc(db('paula'), 'users/alu/progress/settings'))));
await caso('su preparador no lee sus tests', () => assertFails(getDoc(doc(db('paula'), 'users/alu/exam_results/r1'))));
await caso('su preparador no lee sus notas', () => assertFails(getDoc(doc(db('paula'), 'users/alu/notes/3_A_1'))));
await caso('un preparador retirado pierde el acceso', () => assertFails(getDoc(doc(db('retirado'), 'users/alu/progress/settings'))));
await caso('el preparador no toca los cantes propios del alumno', () => assertFails(updateDoc(doc(db('paula'), 'users/alu/cantes/propio'), { estado: 'cancelado' })));
await caso('el preparador crea un cante firmado por él', () => assertSucceeds(setDoc(doc(db('paula'), 'users/alu/cantes/s1'), { id: 's1', preparador: 'paula', estado: 'pendiente' })));

console.log('Verificación');
await caso('nadie se verifica a sí mismo', () => assertFails(setDoc(doc(db('pepe'), 'preparadoresVerificados/pepe'), { uid: 'pepe', avaladoPor: 'pepe', activo: true })));
await caso('un no verificado no verifica a otro', () => assertFails(setDoc(doc(db('pepe'), 'preparadoresVerificados/juan'), { uid: 'juan', avaladoPor: 'pepe', activo: true })));
await caso('un verificado verifica a otro firmando', () => assertSucceeds(setDoc(doc(db('paula'), 'preparadoresVerificados/nuevo'), { uid: 'nuevo', nombre: 'Nuevo', avaladoPor: 'paula', activo: true })));
await caso('…pero no firmando como otro', () => assertFails(setDoc(doc(db('paula'), 'preparadoresVerificados/otro'), { uid: 'otro', avaladoPor: 'admin', activo: true })));
await caso('un retirado no verifica a nadie', () => assertFails(setDoc(doc(db('retirado'), 'preparadoresVerificados/x'), { uid: 'x', avaladoPor: 'retirado', activo: true })));
await caso('el verificado cambia su nombre', () => assertSucceeds(updateDoc(doc(db('paula'), 'preparadoresVerificados/paula'), { nombre: 'Paula P.' })));
await caso('…pero no su aval', () => assertFails(updateDoc(doc(db('paula'), 'preparadoresVerificados/paula'), { avaladoPor: 'admin2' })));
await caso('el retirado no se reactiva', () => assertFails(updateDoc(doc(db('retirado'), 'preparadoresVerificados/retirado'), { activo: true })));
await caso('un verificado no retira a otro', () => assertFails(updateDoc(doc(db('paula'), 'preparadoresVerificados/admin'), { activo: false })));
await caso('el administrador retira a cualquiera', () => assertSucceeds(updateDoc(doc(db('admin'), 'preparadoresVerificados/nuevo'), { activo: false })));
await caso('la lista de verificados la ve quien tenga cuenta', () => assertSucceeds(getDocs(collection(db('pepe'), 'preparadoresVerificados'))));
await caso('…y no sin cuenta', () => assertFails(getDocs(collection(db(null), 'preparadoresVerificados'))));
await caso('el interesado pide su verificación', () => assertSucceeds(setDoc(doc(db('pepe'), 'solicitudesPreparador/pepe'), { uid: 'pepe', nombre: 'Pepe' })));
await caso('…pero no en nombre de otro', () => assertFails(setDoc(doc(db('pepe'), 'solicitudesPreparador/juan'), { uid: 'juan' })));
await caso('un opositor no ve las solicitudes de otros', () => assertFails(getDocs(collection(db('pepe'), 'solicitudesPreparador'))));
await caso('un verificado ve las solicitudes abiertas', () => assertSucceeds(getDocs(query(collection(db('olga'), 'solicitudesPreparador'), where('paraTodos', '==', true)))));
await caso('…y las que le piden a él', () => assertSucceeds(getDocs(query(collection(db('paula'), 'solicitudesPreparador'), where('destinatario', '==', 'paula')))));
await caso('otro verificado no ve una dirigida a Paula', () => assertFails(getDoc(doc(db('olga'), 'solicitudesPreparador/dirigida'))));
await caso('…ni puede rechazarla', () => assertFails(deleteDoc(doc(db('olga'), 'solicitudesPreparador/dirigida'))));
await caso('Paula sí la ve', () => assertSucceeds(getDoc(doc(db('paula'), 'solicitudesPreparador/dirigida'))));
await caso('el administrador ve todas', () => assertSucceeds(getDocs(collection(db('admin'), 'solicitudesPreparador'))));
await caso('un verificado no puede listarlas todas sin filtrar', () => assertFails(getDocs(collection(db('olga'), 'solicitudesPreparador'))));
await caso('saber si soy administrador', () => assertSucceeds(getDoc(doc(db('admin'), 'admins/admin'))));
await caso('nadie se hace administrador', () => assertFails(setDoc(doc(db('pepe'), 'admins/pepe'), { x: 1 })));

console.log('Códigos');
await caso('un no verificado no reserva código', () => assertFails(setDoc(doc(db('pepe'), 'codigos/AAAAAA'), { uid: 'pepe' })));
await caso('un verificado reserva su código', () => assertSucceeds(setDoc(doc(db('paula'), 'codigos/BBBBBB'), { uid: 'paula' })));

console.log('Sustituciones');
const s1 = { id: 's1', alumno: 'alu', fecha: futuro, estado: 'abierta', paraTodos: true, destinatarios: [], temas: ['3.A.1'] };
await caso('el alumno publica con su contacto (en un lote)', async () => {
  const d = db('alu'); const b = writeBatch(d);
  b.set(doc(d, 'sustituciones/s1'), s1); b.set(doc(d, 'sustituciones/s1/privado/alumno'), { nombre: 'Álex', telefono: '600123456' });
  await assertSucceeds(b.commit());
});
await caso('no se publica en nombre de otro', () => assertFails(setDoc(doc(db('pepe'), 'sustituciones/s9'), { ...s1, id: 's9' })));
await caso('un opositor no la ve', () => assertFails(getDoc(doc(db('pepe'), 'sustituciones/s1'))));
await caso('un retirado no la ve', () => assertFails(getDoc(doc(db('retirado'), 'sustituciones/s1'))));
await caso('un verificado la ve en el tablón', () => assertSucceeds(getDocs(query(collection(db('paula'), 'sustituciones'), where('paraTodos', '==', true)))));
await caso('el verificado no ve el contacto antes de cogerla', () => assertFails(getDoc(doc(db('paula'), 'sustituciones/s1/privado/alumno'))));
await caso('no se coge firmando como otro', () => assertFails(updateDoc(doc(db('paula'), 'sustituciones/s1'), { estado: 'cogida', cogidaPor: 'admin', cogidaPorNombre: 'x', updatedAt: 'x' })));
await caso('no se cambian los temas al cogerla', () => assertFails(updateDoc(doc(db('paula'), 'sustituciones/s1'), { estado: 'cogida', cogidaPor: 'paula', temas: [] })));
await caso('Paula la coge (transacción)', () => { const d = db('paula'); return assertSucceeds(runTransaction(d, async (t) => {
  const r = doc(d, 'sustituciones/s1'); await t.get(r);
  t.update(r, { estado: 'cogida', cogidaPor: 'paula', cogidaPorNombre: 'Paula', updatedAt: 'ahora' });
})); });
await caso('el administrador ya no puede cogerla', () => assertFails(updateDoc(doc(db('admin'), 'sustituciones/s1'), { estado: 'cogida', cogidaPor: 'admin', cogidaPorNombre: 'V', updatedAt: 'x' })));
await caso('Paula deja su contacto', () => assertSucceeds(setDoc(doc(db('paula'), 'sustituciones/s1/privado/preparador'), { nombre: 'Paula', telefono: '611222333' })));
await caso('…y no puede tocar el del alumno', () => assertFails(setDoc(doc(db('paula'), 'sustituciones/s1/privado/alumno'), { nombre: 'x', telefono: '1' })));
await caso('Paula lee el contacto del alumno', () => assertSucceeds(getDoc(doc(db('paula'), 'sustituciones/s1/privado/alumno'))));
await caso('el alumno lee el de Paula', () => assertSucceeds(getDoc(doc(db('alu'), 'sustituciones/s1/privado/preparador'))));
await caso('el administrador (que no la cogió) no ve ningún contacto', () => assertFails(getDoc(doc(db('admin'), 'sustituciones/s1/privado/alumno'))));
await caso('otro verificado sigue viendo la petición cogida, pero no los contactos', () => assertSucceeds(getDoc(doc(db('admin'), 'sustituciones/s1'))));
const s2 = { ...s1, id: 's2', paraTodos: false, destinatarios: ['admin'] };
await caso('petición solo para un preparador', () => assertSucceeds(setDoc(doc(db('alu'), 'sustituciones/s2'), s2)));
await caso('…otro verificado no la ve', () => assertFails(getDoc(doc(db('paula'), 'sustituciones/s2'))));
await caso('…ni puede cogerla', () => assertFails(updateDoc(doc(db('paula'), 'sustituciones/s2'), { estado: 'cogida', cogidaPor: 'paula', cogidaPorNombre: 'P', updatedAt: 'x' })));
await caso('…el elegido sí la ve', () => assertSucceeds(getDocs(query(collection(db('admin'), 'sustituciones'), where('destinatarios', 'array-contains', 'admin')))));
await caso('el alumno la retira', () => assertSucceeds(updateDoc(doc(db('alu'), 'sustituciones/s2'), { estado: 'cancelada' })));
await caso('el alumno ve sus peticiones', () => assertSucceeds(getDocs(query(collection(db('alu'), 'sustituciones'), where('alumno', '==', 'alu')))));

const s3 = { ...s1, id: 's3', fecha: '2030-01-08T16:00:00.000', hasta: '2030-01-08T21:00:00.000' };
await caso('petición con franja de horas', () => assertSucceeds(setDoc(doc(db('alu'), 'sustituciones/s3'), s3)));
await caso('…no se coge a una hora fuera de la franja', () => assertFails(updateDoc(doc(db('paula'), 'sustituciones/s3'), { estado: 'cogida', cogidaPor: 'paula', cogidaPorNombre: 'P', hora: '2030-01-08T22:00:00.000', updatedAt: 'x' })));
await caso('…sí a una hora dentro', () => assertSucceeds(updateDoc(doc(db('paula'), 'sustituciones/s3'), { estado: 'cogida', cogidaPor: 'paula', cogidaPorNombre: 'P', hora: '2030-01-08T18:30:00.000', updatedAt: 'x' })));

console.log('Huecos y reservas');
await caso('el preparador publica sus huecos', () => assertSucceeds(setDoc(doc(db('paula'), 'huecos/paula'), { activo: true, huecos: [] })));
await caso('un no verificado no publica huecos', () => assertFails(setDoc(doc(db('pepe'), 'huecos/pepe'), { activo: true })));
await caso('su alumno enlazado ve los huecos', () => assertSucceeds(getDoc(doc(db('alu'), 'huecos/paula'))));
await caso('otro opositor no los ve', () => assertFails(getDoc(doc(db('pepe'), 'huecos/paula'))));
const r1 = { id: 'r1', preparador: 'paula', alumno: 'alu', fecha: futuro, estado: 'pedida' };
await caso('el alumno enlazado pide reserva', () => assertSucceeds(setDoc(doc(db('alu'), 'reservas/r1'), r1)));
await caso('uno no enlazado no puede', () => assertFails(setDoc(doc(db('pepe'), 'reservas/r2'), { ...r1, id: 'r2', alumno: 'pepe' })));
await caso('no se pide ya aceptada', () => assertFails(setDoc(doc(db('alu'), 'reservas/r3'), { ...r1, id: 'r3', estado: 'aceptada' })));
await caso('el alumno no se la acepta él mismo', () => assertFails(updateDoc(doc(db('alu'), 'reservas/r1'), { estado: 'aceptada' })));
await caso('el preparador la acepta', () => assertSucceeds(updateDoc(doc(db('paula'), 'reservas/r1'), { estado: 'aceptada', updatedAt: 'x' })));
await caso('otro no ve la reserva', () => assertFails(getDoc(doc(db('pepe'), 'reservas/r1'))));
await caso('el preparador ve las suyas', () => assertSucceeds(getDocs(query(collection(db('paula'), 'reservas'), where('preparador', '==', 'paula')))));

console.log(`\n${ok} correctas, ${mal} fallidas`);
await env.cleanup();
process.exit(mal ? 1 : 0);

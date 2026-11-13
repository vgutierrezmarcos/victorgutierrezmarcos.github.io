// Firebase Auth por REST, con la clave pública del proyecto: renovar el ID token con
// el refresh token del opositor (Secure Token API) y comprobar un ID token recién
// emitido por la página de login (Identity Toolkit, accounts:lookup).

export type Renovacion =
  | { ok: true; idToken: string; refreshToken: string; uid: string; expiraEn: number }
  | { ok: false; motivo: 'invalido' | 'temporal'; detalle: string };

/** Errores de Secure Token que significan que el refresh token ya no sirve (hay que volver a conectar). */
const errorsDefinitivos = ['TOKEN_EXPIRED', 'USER_DISABLED', 'USER_NOT_FOUND', 'INVALID_REFRESH_TOKEN', 'INVALID_GRANT_TYPE', 'MISSING_REFRESH_TOKEN'];

export async function renovarIdToken(apiKey: string, refreshToken: string, fetchFn: typeof fetch = fetch): Promise<Renovacion> {
  let r: Response;
  try {
    r = await fetchFn(`https://securetoken.googleapis.com/v1/token?key=${encodeURIComponent(apiKey)}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: new URLSearchParams({ grant_type: 'refresh_token', refresh_token: refreshToken }).toString(),
    });
  } catch (e) {
    return { ok: false, motivo: 'temporal', detalle: `sin conexión con Firebase: ${(e as Error).message}` };
  }
  const cuerpo = (await r.json().catch(() => ({}))) as {
    id_token?: string;
    refresh_token?: string;
    user_id?: string;
    expires_in?: string;
    error?: { message?: string; status?: string };
  };
  if (r.ok && cuerpo.id_token && cuerpo.user_id) {
    return { ok: true, idToken: cuerpo.id_token, refreshToken: cuerpo.refresh_token ?? refreshToken, uid: cuerpo.user_id, expiraEn: Number(cuerpo.expires_in ?? 3600) };
  }
  const mensaje = cuerpo.error?.message ?? `HTTP ${r.status}`;
  const definitivo = r.status === 400 && errorsDefinitivos.some((e) => mensaje.startsWith(e));
  return { ok: false, motivo: definitivo ? 'invalido' : 'temporal', detalle: mensaje };
}

/** uid y correo del dueño de un ID token (Identity Toolkit comprueba la firma y la caducidad). */
export async function datosDelIdToken(apiKey: string, idToken: string, fetchFn: typeof fetch = fetch): Promise<{ uid: string; email: string } | null> {
  const r = await fetchFn(`https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=${encodeURIComponent(apiKey)}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ idToken }),
  });
  if (!r.ok) return null;
  const cuerpo = (await r.json().catch(() => ({}))) as { users?: Array<{ localId?: string; email?: string }> };
  const u = cuerpo.users?.[0];
  return u?.localId ? { uid: u.localId, email: u.email ?? '' } : null;
}

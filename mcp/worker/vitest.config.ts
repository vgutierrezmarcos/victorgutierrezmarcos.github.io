// Pruebas de las partes puras del Worker (conversión de Firestore, datos, cronograma,
// cifrado y herramientas con un Firestore simulado) sobre workerd, con los KV de wrangler.toml.
// API de @cloudflare/vitest-pool-workers 0.23 (vitest 4): el plugin cloudflareTest.
import { cloudflareTest } from '@cloudflare/vitest-pool-workers';
import { defineConfig } from 'vitest/config';

export default defineConfig({
  plugins: [
    cloudflareTest({
      wrangler: { configPath: './wrangler.toml' },
      miniflare: { bindings: { CLAVE_CIFRADO: 'MDEyMzQ1Njc4OWFiY2RlZjAxMjM0NTY3ODlhYmNkZWY=' } },
    }),
  ],
  // En serie: en /mnt/c (disco de Windows desde WSL) los seis ficheros en paralelo agotan el tiempo de arranque de workerd.
  test: { include: ['test/**/*.test.ts'], fileParallelism: false },
});

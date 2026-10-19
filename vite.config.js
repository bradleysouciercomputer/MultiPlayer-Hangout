import { defineConfig } from 'vite';

export default defineConfig({
  base: process.env.GITHUB_ACTIONS ? '/MultiPlayer-Hangout/' : '/',
  server: { host: '0.0.0.0' },
});

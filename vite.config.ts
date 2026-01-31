import { defineConfig } from 'vite'

export default defineConfig({
  base: '/tdf-web-viewer/',
  server: {
    port: 3000,
  },
  build: {
    outDir: 'dist',
  },
})

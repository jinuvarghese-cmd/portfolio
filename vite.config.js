import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';
import vue from '@vitejs/plugin-vue';

export default defineConfig({
    plugins: [
        laravel({
            input: 'resources/js/app.js',
            refresh: true,
        }),
        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
    ],
    base: '/',  // Ensures assets are referenced relative to the root in production
    build: {
        // Ensure all assets are named appropriately and do not break relative URLs
        rollupOptions: {
            output: {
                assetFileNames: 'assets/[name]-[hash].css',
                chunkFileNames: 'assets/[name]-[hash].js',
                entryFileNames: 'assets/[name]-[hash].js',
            },
        },
    }
});

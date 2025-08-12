# syntax=docker/dockerfile:1.7-labs

# --------- Etapa de dependencias ---------
FROM node:22-alpine AS deps
WORKDIR /app
COPY package*.json ./
# cache de npm para builds más rápidos
RUN --mount=type=cache,target=/root/.npm npm ci

# --------- Etapa de build ---------
FROM deps AS builder
WORKDIR /app
COPY . .
ENV NODE_ENV=production
# En Vite NO usar --prod
RUN npm run build

# --------- Etapa de producción ---------
FROM nginx:1.27-alpine AS runner

# Copiar archivo de config (ver abajo)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copiar el build (ajusta si tu outDir es distinto)
COPY --from=builder /app/dist/ /usr/share/nginx/html

# Permisos y usuario no root
RUN chown -R nginx:nginx /usr/share/nginx/html /var/cache/nginx /var/run
USER nginx

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]

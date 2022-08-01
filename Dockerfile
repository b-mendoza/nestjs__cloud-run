FROM node:lts-alpine AS build
WORKDIR /app
COPY package*.json ./
COPY prisma ./prisma
RUN npm ci --quiet
COPY . ./
RUN npm run build

FROM node:lts-alpine AS production
WORKDIR /app
COPY package*.json ./
COPY prisma ./prisma
RUN npm ci --only=production --quiet
COPY --from=build /app/dist ./dist
CMD npm run start:prod

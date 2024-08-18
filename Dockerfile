FROM node:lts-alpine AS builder

#Odredjujemo work dir u kome cemo sve raditi
WORKDIR /app

#Kopiramo sve sa lokalnog repo-a na kontenjer u fajl /usr/src/app
COPY . .

RUN npm install --only-production && \
    npm cache clean --force && \
    npm run build

FROM alpine:3.20.2

RUN apk add --no-cache nginx && \
    touch /run/nginx/nginx.pid && \
    chown -R 1001:0 /run/nginx/nginx.pid /var/lib/nginx/ /var/log/nginx /var/run /usr/share/nginx /etc/nginx  && \
    chmod -R 777 /usr/share/nginx/ /var/lib/nginx/ /etc/nginx/* /var/log/nginx  && \
    chmod 666 /run/nginx/nginx.pid && \
    rm -rf /usr/share/nginx/html/* 

COPY --from=builder /app/build /usr/share/nginx/html/

COPY nginx/nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]

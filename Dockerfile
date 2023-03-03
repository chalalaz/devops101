FROM klakegg/hugo:latest AS builder
WORKDIR /myblog
COPY /myblog ./
RUN hugo

FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html
COPY --from=builder /myblog/public/ ./
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
FROM nginx:alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy presentation web application assets
COPY . /usr/share/nginx/html

# Expose standard HTTP port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

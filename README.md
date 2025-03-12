# Next.js + PNPM + Docker

A lightweight, production-ready Docker setup for Next.js using PNPM and standalone mode.

## 🚀 Features

- ✅ Uses **Next.js** in standalone mode for optimized builds
- ✅ **PNPM** for fast and efficient dependency management
- ✅ **Multi-stage Docker build** for minimal image size
- ✅ **Alpine-based** lightweight Node.js image
- ✅ Runs as a **non-root user** for better security
- ✅ **Environment variables** support
- ✅ Exposes **port 3000** for easy deployment

## 📦 Installation & Usage

### 1️⃣ Build the Docker Image
```sh
docker build -t nextjs-pnpm-app .
```

### 2️⃣ Run the Container
```sh
docker run -p 3000:3000 nextjs-pnpm-app
```

### 3️⃣ Access the Application
Open your browser and go to:  
👉 `http://localhost:3000`

## 🛠 Environment Variables

You can configure the app using environment variables:

| Variable               | Description                       | Default                 |
|------------------------|---------------------------------|-------------------------|
| `NODE_ENV`            | Runtime environment              | `production`           |
| `NEXT_PUBLIC_API_URL` | API URL for frontend requests    | `https://api.app.example` |
| `PORT`                | Port the app runs on             | `3000`                  |

## 🐳 Docker Compose (Optional)

To run with **Docker Compose**, create a `docker-compose.yml`:

```yaml
version: '3.8'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      NODE_ENV: production
      NEXT_PUBLIC_API_URL: https://api.solvario.app
```

Run it with:
```sh
docker-compose up -d
```

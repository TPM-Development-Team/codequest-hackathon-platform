# CodeQuest Hackathon Backend

Backend service for the CodeQuest Hackathon Platform, built with Node.js, Express, and Prisma.

## Tech Stack

- **Runtime:** Node.js
- **Framework:** Express.js
- **Database:** PostgreSQL
- **ORM:** Prisma
- **Authentication:** JWT & bcryptjs

## Prerequisites

- Node.js (v18 or higher)
- PostgreSQL database
- npm or yarn

## Installation

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd codequest-hackathon-platform/backend
    ```

2.  **Install dependencies:**
    ```bash
    npm install
    ```

3.  **Environment Setup:**
    Create a `.env` file in the `backend` directory:
    ```env
    DATABASE_URL="postgresql://user:password@localhost:5432/codequest?schema=public"
    JWT_SECRET="your_jwt_secret_key"
    PORT=3000
    ```

4.  **Database Setup:**
    Run migrations and seed the database with initial data (including admin account).
    ```bash
    npx prisma migrate dev
    npx prisma db seed
    ```

## Running the Server

- **Development Mode:**
    ```bash
    npm run dev
    ```
    Server will start at `http://localhost:3000`.

- **Production Mode:**
    ```bash
    npm start
    ```

## Default Admin Credentials

After running the seed command, an admin account is created:

- **Username (Group Name):** `Admin`
- **Password:** `Admin123!`

## API Endpoints

- **Auth:** `/api/auth/register`, `/api/auth/login`, `/api/auth/me`
- **Dashboard:** `/api/dashboard` (Protected)
- **Admin:** `/api/admin` (Admin only)

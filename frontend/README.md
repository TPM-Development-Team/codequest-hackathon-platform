# CodeQuest Hackathon Frontend

The user-facing platform for the CodeQuest Hackathon, featuring a pixel-art themed landing page and a comprehensive dashboard for participants and admins. Built with Astro.

## Tech Stack

- **Framework:** Astro
- **Styling:** TailwindCSS, Custom CSS (Pixel Art & Glassmorphism)
- **Deployment:** Vercel (Recommended)

## Features

- **Responsive Landing Page:** Mobile-optimized with a retro pixel-art aesthetic.
- **Participant Dashboard:** Team management, status tracking, and submission capability.
- **Admin Dashboard:** Manage teams, update statuses, and view participant details.
- **Dynamic Content:** Fetches FAQ, Mentors, and Schedule from the backend.

## Installation

1.  **Navigate to the frontend directory:**
    ```bash
    cd codequest-hackathon-platform/frontend
    ```

2.  **Install dependencies:**
    ```bash
    npm install
    ```

3.  **Environment Setup:**
    Ensure the backend is running at `http://localhost:3000`. Modify `src/config.ts` or `.env` if your backend URL differs.

## Running the Application

- **Development Mode:**
    ```bash
    npm run dev
    ```
    The application will be available at `http://localhost:4321`.

- **Build for Production:**
    ```bash
    npm run build
    ```
    This generates a static/SSR build in the `dist/` directory.

## Project Structure

```
frontend/
├── src/
│   ├── components/    # Reusable UI components (Navbar, Hero, etc.)
│   ├── layouts/       # Global page layouts
│   ├── pages/         # Astro pages (File-based routing)
│   ├── styles/        # Global CSS and Tailwind directives
│   └── utils/         # Helper functions
└── public/            # Static assets
```

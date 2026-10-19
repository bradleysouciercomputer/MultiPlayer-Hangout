# MultiPlayer Hangout

A cozy, browser-based 3D multiplayer hangout built with Three.js, Vite, and Supabase.

## Features

- A hand-built low-poly island with a town square, fountain, trees, Little Cloud Cafe, Sky Lounge, Music Corner, Flower Market, and a Daydream Portal.
- First-person movement: WASD or arrow keys to walk, Shift to run, Space to hop, and mouse movement to look around after clicking the world. On touch devices, drag across the world to look around. Press Esc to release the mouse on desktop.
- More detailed stylized avatars with layered outfits, facial features, hair, and backpacks, plus smoother idle, walk, and run animation with arm, elbow, leg, and knee movement. Live multiplayer avatars have overhead nameplates, interpolated movement, and online presence.
- Global chat backed by Postgres. Recent messages are loaded when you join and new messages are broadcast live.
- Email/password account creation and sign-in, email confirmation, sign-out, and password reset.
- Row Level Security for the profile and chat tables, server-assigned chat display names, and authenticated-only access to the private global-lobby Realtime channel.
- Responsive sign-in and in-game UI.

## Run locally

Requires Node.js 22 or newer.

1. Clone this repository.
2. Run npm install.
3. Run npm run dev.
4. Open the local URL printed by Vite (normally http://localhost:5173).

The app has safe defaults for the Supabase project associated with this repository. To point to another project, copy .env.example to .env.local and set VITE_SUPABASE_URL and VITE_SUPABASE_PUBLISHABLE_KEY.

The Supabase publishable key is designed to be visible in browser code. Never use a service_role or secret key in this repository or in a VITE_ environment variable. RLS—not key secrecy—protects database access.

## Supabase project

The migrations under supabase/migrations were applied to the Supabase project named MultiPlayer Hangout. They create:

- public.profiles, one profile per authentication user, plus an account-creation trigger.
- public.chat_messages, with a 500-character limit, history indexes, and Realtime publication.
- RLS policies for profile ownership and authenticated global-chat access.
- Realtime authorization policies limiting the private global-lobby topic to authenticated users.
- Revoked client RPC execution on internal trigger functions.

For a separate Supabase project, apply the SQL migrations in version order and set the project URL and publishable key in .env.local. Configure Supabase Auth's allowed redirect URLs for both your local origin and deployed site. Email confirmation and password reset require email delivery; configure custom SMTP before a public launch.

## Deploy on GitHub Pages

A GitHub Actions workflow builds the static site and deploys the dist folder to Pages whenever main is updated. **One-time setup required:** open repository Settings → Pages → Build and deployment, set Source to **GitHub Actions**, and save. The connected GitHub integration cannot enable Pages on behalf of the repository, so the first deployment will fail until you turn it on here. Then go to Actions and re-run the latest “Build and deploy to GitHub Pages” workflow (or push another commit). After deployment succeeds, open the Pages URL shown in the deployment summary.

GitHub Pages hosts the static client, not a game server process. Supabase Realtime handles player presence and movement broadcasts.

## Architecture note

Character movement is client-simulated and broadcast to other connected players. This is a lightweight social hangout prototype, not an authoritative competitive game server. For competitive mechanics, add server-side movement validation and anti-cheat protections. Player positions are transient and reset when a user disconnects; chat messages persist in Postgres.

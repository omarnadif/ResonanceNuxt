import { createClient } from "@supabase/supabase-js";

const supabase = createClient(
  "https://tbdrkpemxcmynpywjmjn.supabase.co",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRiZHJrcGVteGNteW5weXdqbWpuIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MTg1MzIxNiwiZXhwIjoyMDg3NDI5MjE2fQ.vlt1J5zLoJdNTN-FpMbgc1qEEIYkUB3u0bNExJGgLaw" // IMPORTANT: service role required
);

async function main() {
  const emails = Array.from({ length: 15 }).map((_, i) => `user${i+15}@example.com`);

  for (const email of emails) {
    const { data, error } = await supabase.auth.admin.createUser({
      email,
      password: "password123",
      email_confirm: true,
    });

    if (error) console.error("❌ Error:", error);
    else console.log("✅ User created:", data.user.id);
  }
}

main();
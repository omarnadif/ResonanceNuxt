<template>
  <div class="min-h-screen bg-[#171717] flex items-center justify-center px-4 overflow-hidden">

    <!-- Background glows -->
    <div class="absolute top-1/4 left-1/3 w-[500px] h-[500px] bg-green-500/5 blur-[140px] rounded-full pointer-events-none" />
    <div class="absolute bottom-1/4 right-1/3 w-[400px] h-[400px] bg-indigo-600/5 blur-[120px] rounded-full pointer-events-none" />

    <div class="relative w-full max-w-md">

      <!-- Logo -->
      <NuxtLink to="/" class="flex justify-center mb-10">
        <span class="text-2xl font-black tracking-tighter text-white uppercase">RESONANCE</span>
      </NuxtLink>

      <!-- Card -->
      <div class="bg-white/5 border border-white/10 rounded-3xl p-8 backdrop-blur-xl shadow-2xl">

        <!-- Tabs -->
        <div class="flex bg-white/5 rounded-2xl p-1 mb-8">
          <button
            class="flex-1 py-2 text-sm font-semibold rounded-xl transition-all"
            :class="mode === 'login' ? 'bg-white text-black shadow' : 'text-white/50 hover:text-white'"
            @click="mode = 'login'"
          >
            Connexion
          </button>
          <button
            class="flex-1 py-2 text-sm font-semibold rounded-xl transition-all"
            :class="mode === 'register' ? 'bg-white text-black shadow' : 'text-white/50 hover:text-white'"
            @click="mode = 'register'"
          >
            Inscription
          </button>
        </div>

        <!-- Error -->
        <div v-if="error" class="mb-5 flex items-center gap-2 bg-red-500/10 border border-red-500/20 text-red-400 text-sm rounded-xl px-4 py-3">
          <UIcon name="i-heroicons-exclamation-circle" class="shrink-0" />
          {{ error }}
        </div>

        <!-- Success (register) -->
        <div v-if="success" class="mb-5 flex items-center gap-2 bg-green-500/10 border border-green-500/20 text-green-400 text-sm rounded-xl px-4 py-3">
          <UIcon name="i-heroicons-check-circle" class="shrink-0" />
          {{ success }}
        </div>

        <form class="flex flex-col gap-4" @submit.prevent="submit">

          <!-- Name fields (register only) -->
          <template v-if="mode === 'register'">
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="field-label">Prénom</label>
                <input v-model="firstName" type="text" placeholder="Jean" class="field-input" required>
              </div>
              <div>
                <label class="field-label">Nom</label>
                <input v-model="lastName" type="text" placeholder="Dupont" class="field-input" required>
              </div>
            </div>
          </template>

          <!-- Email -->
          <div>
            <label class="field-label">Email</label>
            <input v-model="email" type="email" placeholder="jean@example.com" class="field-input" required>
          </div>

          <!-- Password -->
          <div>
            <label class="field-label">Mot de passe</label>
            <input v-model="password" type="password" placeholder="••••••••" class="field-input" required minlength="6">
          </div>

          <!-- Submit -->
          <UButton
            type="submit"
            :loading="loading"
            :label="submitLabel"
            color="primary"
            block
            size="lg"
            class="rounded-xl font-bold mt-2"
          />
        </form>
      </div>

      <!-- Back home -->
      <div class="text-center mt-6">
        <NuxtLink to="/" class="text-white/30 text-sm hover:text-white/60 transition-colors">
          ← Retour à l'accueil
        </NuxtLink>
      </div>
    </div>
  </div>
</template>

<script setup>
const supabase = useSupabaseClient()
const user = useSupabaseUser()

// Already logged in → redirect
if (user.value) {
  await navigateTo('/profile')
}

const mode = ref('login')
const submitLabel = computed(() => mode.value === 'login' ? 'Se connecter' : "S'inscrire")
const email = ref('')
const password = ref('')
const firstName = ref('')
const lastName = ref('')
const loading = ref(false)
const error = ref('')
const success = ref('')

// Reset messages when switching mode
watch(mode, () => {
  error.value = ''
  success.value = ''
})

function friendlyError(msg) {
  if (!msg) return 'Une erreur est survenue.'
  if (msg.includes('Invalid login credentials')) return 'Email ou mot de passe incorrect.'
  if (msg.includes('Email not confirmed')) return 'Confirme ton email avant de te connecter. Vérifie ta boîte mail.'
  if (msg.includes('User already registered')) return 'Un compte existe déjà avec cet email. Connecte-toi.'
  if (msg.includes('Password should be at least')) return 'Le mot de passe doit faire au moins 6 caractères.'
  if (msg.includes('Unable to validate email')) return 'Adresse email invalide.'
  return msg
}

async function submit() {
  error.value = ''
  success.value = ''
  loading.value = true

  if (mode.value === 'login') {
    const { error: err } = await supabase.auth.signInWithPassword({
      email: email.value,
      password: password.value
    })

    if (err) {
      error.value = friendlyError(err.message)
    } else {
      await navigateTo('/profile')
    }
  } else {
    const { data, error: err } = await supabase.auth.signUp({
      email: email.value,
      password: password.value
    })

    if (err) {
      error.value = friendlyError(err.message)
    } else {
      // Create profile row immediately if user exists (email confirmation disabled)
      if (data.user && data.session) {
        await supabase.from('profiles').insert({
          id: data.user.id,
          first_name: firstName.value,
          last_name: lastName.value
        })
        await navigateTo('/profile')
      } else {
        // Email confirmation required
        success.value = 'Compte créé ! Vérifie ta boîte mail pour confirmer ton inscription, puis connecte-toi.'
        email.value = ''
        password.value = ''
        firstName.value = ''
        lastName.value = ''
        mode.value = 'login'
      }
    }
  }

  loading.value = false
}
</script>

<style scoped>
@reference "~/assets/css/main.css";

.field-label {
  @apply block text-xs font-semibold text-white/40 uppercase tracking-widest mb-1.5;
}
.field-input {
  @apply w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2.5 text-white text-sm placeholder-white/20 outline-none focus:border-white/30 focus:bg-white/[0.07] transition-all;
}
</style>

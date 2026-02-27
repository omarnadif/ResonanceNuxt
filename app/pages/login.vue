<template>
  <div class="min-h-screen bg-[#080808] flex items-center justify-center px-4 overflow-hidden">

    <!-- Glow -->
    <div class="absolute top-1/3 left-1/2 -translate-x-1/2 w-[500px] h-[500px] bg-[#F75C03] opacity-[0.04] blur-[160px] rounded-full pointer-events-none" />

    <div class="relative w-full max-w-sm">

      <!-- Logo -->
      <NuxtLink to="/" class="flex items-center justify-center gap-2 mb-12 group">
        <span class="w-2 h-2 rounded-full bg-[#F75C03]" />
        <span class="text-base font-bold tracking-[0.2em] text-white uppercase">Resonance</span>
      </NuxtLink>

      <!-- Card -->
      <div class="bg-[#0F0F0F] border border-white/[0.07] rounded-2xl p-8">

        <!-- Toggle -->
        <div class="flex bg-white/[0.04] rounded-xl p-1 mb-8 gap-1">
          <button
            class="flex-1 py-2 text-sm font-semibold rounded-lg transition-all"
            :class="mode === 'login' ? 'bg-white text-black' : 'text-white/40 hover:text-white'"
            @click="mode = 'login'"
          >
            Connexion
          </button>
          <button
            class="flex-1 py-2 text-sm font-semibold rounded-lg transition-all"
            :class="mode === 'register' ? 'bg-white text-black' : 'text-white/40 hover:text-white'"
            @click="mode = 'register'"
          >
            Inscription
          </button>
        </div>

        <!-- Error -->
        <div v-if="error" class="mb-5 flex items-start gap-2.5 bg-red-500/[0.08] border border-red-500/20 text-red-400 text-sm rounded-xl px-4 py-3">
          <UIcon name="i-heroicons-exclamation-circle" class="shrink-0 mt-0.5" />
          {{ error }}
        </div>

        <!-- Success -->
        <div v-if="success" class="mb-5 flex items-start gap-2.5 bg-[#F75C03]/[0.08] border border-[#F75C03]/20 text-[#F75C03] text-sm rounded-xl px-4 py-3">
          <UIcon name="i-heroicons-check-circle" class="shrink-0 mt-0.5" />
          {{ success }}
        </div>

        <form class="flex flex-col gap-4" @submit.prevent="submit">

          <!-- Register fields -->
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

          <div>
            <label class="field-label">Email</label>
            <input v-model="email" type="email" placeholder="jean@example.com" class="field-input" required>
          </div>

          <div>
            <label class="field-label">Mot de passe</label>
            <input v-model="password" type="password" placeholder="••••••••" class="field-input" required minlength="6">
          </div>

          <button
            type="submit"
            :disabled="loading"
            class="mt-2 w-full bg-[#F75C03] text-white font-semibold py-3 rounded-lg hover:bg-[#e05200] transition-colors disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2 text-sm"
          >
            <span v-if="loading" class="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
            {{ submitLabel }}
          </button>
        </form>
      </div>

      <!-- Back -->
      <div class="text-center mt-6">
        <NuxtLink to="/" class="text-white/20 text-xs hover:text-white/50 transition-colors tracking-wide uppercase">
          ← Retour à l'accueil
        </NuxtLink>
      </div>
    </div>
  </div>
</template>

<script setup>
const supabase = useSupabaseClient()
const user = useSupabaseUser()

if (user.value) await navigateTo('/profile')

const mode = ref('login')
const submitLabel = computed(() => mode.value === 'login' ? 'Se connecter' : "S'inscrire")
const email = ref('')
const password = ref('')
const firstName = ref('')
const lastName = ref('')
const loading = ref(false)
const error = ref('')
const success = ref('')

watch(mode, () => { error.value = ''; success.value = '' })

function friendlyError(msg) {
  if (!msg) return 'Une erreur est survenue.'
  if (msg.includes('Invalid login credentials')) return 'Email ou mot de passe incorrect.'
  if (msg.includes('Email not confirmed')) return 'Confirme ton email avant de te connecter.'
  if (msg.includes('User already registered')) return 'Un compte existe déjà avec cet email.'
  if (msg.includes('Password should be at least')) return 'Le mot de passe doit faire au moins 6 caractères.'
  return msg
}

async function submit() {
  error.value = ''
  success.value = ''
  loading.value = true

  if (mode.value === 'login') {
    const { error: err } = await supabase.auth.signInWithPassword({ email: email.value, password: password.value })
    if (err) error.value = friendlyError(err.message)
    else await navigateTo('/profile')
  } else {
    const { data, error: err } = await supabase.auth.signUp({ email: email.value, password: password.value })
    if (err) {
      error.value = friendlyError(err.message)
    } else if (data.user && data.session) {
      await supabase.from('profiles').insert({ id: data.user.id, first_name: firstName.value, last_name: lastName.value })
      await navigateTo('/profile')
    } else {
      success.value = 'Compte créé ! Vérifie ta boîte mail pour confirmer ton inscription.'
      email.value = ''; password.value = ''; firstName.value = ''; lastName.value = ''
      mode.value = 'login'
    }
  }

  loading.value = false
}
</script>

<style scoped>
@reference "~/assets/css/main.css";

.field-label {
  @apply block text-xs font-semibold text-white/30 uppercase tracking-widest mb-1.5;
}
.field-input {
  @apply w-full bg-white/[0.04] border border-white/[0.07] rounded-lg px-4 py-2.5 text-white text-sm placeholder-white/20 outline-none focus:border-[#F75C03]/40 focus:bg-white/[0.06] transition-all;
}
</style>

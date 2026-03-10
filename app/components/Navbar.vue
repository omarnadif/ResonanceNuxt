<template>
  <header class="fixed top-0 left-0 right-0 z-50 border-b border-white/[0.06] bg-[#080808]/90 backdrop-blur-xl">
    <div class="max-w-7xl mx-auto px-6 flex items-center h-16 gap-12">

      <!-- Logo -->
      <NuxtLink to="/" class="shrink-0 flex items-center group">
        <img src="/images/logo_resonance.png" alt="Resonance" class="h-8 w-auto" />
      </NuxtLink>

      <!-- Nav -->
      <nav class="hidden md:flex items-center gap-8 flex-1">
        <NuxtLink
          v-for="link in links"
          :key="link.to"
          :to="link.to"
          class="text-sm font-medium text-white/40 hover:text-white transition-colors"
          active-class="!text-white"
        >
          {{ link.label }}
        </NuxtLink>
      </nav>

      <!-- Auth -->
      <div class="flex items-center gap-5 ml-auto">
        <template v-if="user">
          <NuxtLink
            to="/conversations"
            class="relative text-sm font-medium text-white/40 hover:text-white transition-colors"
          >
            <UIcon name="i-heroicons-chat-bubble-left-right" class="text-base" />
            <span
              v-if="pendingCount > 0"
              class="absolute -top-1.5 -right-1.5 w-3.5 h-3.5 bg-[#F75C03] rounded-full text-[8px] font-bold text-white flex items-center justify-center"
            >{{ pendingCount }}</span>
          </NuxtLink>
          <NuxtLink
            to="/profile"
            class="text-sm font-medium text-white/40 hover:text-white transition-colors"
          >
            Mon Profil
          </NuxtLink>
          <button
            class="text-white/30 hover:text-red-400 transition-colors"
            title="Déconnexion"
            @click="logout"
          >
            <UIcon name="i-heroicons-power" class="text-base" />
          </button>
        </template>
        <template v-else>
          <NuxtLink
            to="/login"
            class="text-sm font-semibold text-white/40 hover:text-white transition-colors"
          >
            Connexion
          </NuxtLink>
          <NuxtLink
            to="/login"
            class="bg-[#F75C03] text-white text-sm font-semibold px-5 py-2 rounded-lg hover:bg-[#e05200] transition-colors"
          >
            Rejoindre →
          </NuxtLink>
        </template>
      </div>
    </div>
  </header>
</template>

<script setup>
const user = useSupabaseUser()
const supabase = useSupabaseClient()

const pendingCount = ref(0)

watchEffect(async () => {
  if (!user.value) { pendingCount.value = 0; return }
  const { data } = await supabase.rpc('count_pending_interests')
  pendingCount.value = data ?? 0
})

const links = [
  { to: '/', label: 'Accueil' },
  { to: '/features', label: 'Annonces' },
  { to: '/pricing', label: 'Tarifs' },
  { to: '/contact', label: 'Contact' }
]

const logout = async () => {
  const { error } = await supabase.auth.signOut()
  if (!error) navigateTo('/login')
}
</script>

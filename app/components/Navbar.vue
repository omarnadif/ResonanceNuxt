<template>
  <div class="fixed top-6 left-0 right-0 z-50 flex justify-center px-4">
    <nav class="border border-white/20 bg-[#737373]/90 backdrop-blur-xl rounded-full px-6 py-2.5 flex items-center gap-10 shadow-xl">

      <NuxtLink to="/" class="text-xl font-black tracking-tighter text-white hover:text-indigo-200 transition-colors">
        RESONANCE
      </NuxtLink>

      <div class="hidden md:flex items-center space-x-8 text-sm font-medium text-white/70">
        <NuxtLink to="/" class="hover:text-white transition" active-class="text-white font-bold">
          Accueil
        </NuxtLink>
        <NuxtLink to="/features" class="hover:text-white transition" active-class="text-white font-bold">
          Fonctionnalités
        </NuxtLink>
        <NuxtLink to="/pricing" class="hover:text-white transition" active-class="text-white font-bold">
          Tarifs
        </NuxtLink>
        <NuxtLink to="/contact" class="hover:text-white transition" active-class="text-white font-bold">
          Contact
        </NuxtLink>
      </div>

      <div class="flex items-center gap-4 border-l border-white/30 pl-6">
        <template v-if="user">
          <NuxtLink to="/profile" class="text-sm font-medium text-white/70 hover:text-white">
            Mon Profil
          </NuxtLink>
          <UButton
            color="red"
            variant="ghost"
            icon="i-heroicons-power"
            size="sm"
            @click="logout"
          />
        </template>

        <template v-else>
          <NuxtLink
            to="/login"
            class="bg-white text-black px-6 py-2 rounded-full text-sm font-bold hover:bg-gray-200 transition-colors shadow-lg"
          >
            Rejoins Nous
          </NuxtLink>
        </template>
      </div>
    </nav>
  </div>
</template>

<script setup>
const user = useSupabaseUser()
const supabase = useSupabaseClient()

const logout = async () => {
  const { error } = await supabase.auth.signOut()
  if (!error) navigateTo('/login')
}
</script>

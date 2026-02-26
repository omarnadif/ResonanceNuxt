<template>
  <footer class="relative bg-[#0d0d0d] border-t border-white/5 pt-20 pb-10 overflow-hidden">
    <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[300px] bg-green-500/3 blur-[120px] rounded-full pointer-events-none" />

    <div class="relative max-w-7xl mx-auto px-8">
      <div class="grid grid-cols-1 md:grid-cols-4 gap-12 mb-16">
        <!-- Brand -->
        <div class="md:col-span-1">
          <h2 class="text-2xl font-black tracking-tighter text-white uppercase mb-4">Resonance</h2>
          <p class="text-white/40 text-sm leading-relaxed">
            La plateforme qui connecte les musiciens, artistes et passionnés de musique.
          </p>
        </div>

        <!-- Navigation -->
        <div>
          <h3 class="text-xs font-bold tracking-[0.2em] uppercase text-white/30 mb-5">Navigation</h3>
          <ul class="space-y-3">
            <li><NuxtLink to="/" class="text-sm text-white/50 hover:text-white transition">Accueil</NuxtLink></li>
            <li><NuxtLink to="/features" class="text-sm text-white/50 hover:text-white transition">Fonctionnalités</NuxtLink></li>
            <li><NuxtLink to="/pricing" class="text-sm text-white/50 hover:text-white transition">Tarifs</NuxtLink></li>
            <li><NuxtLink to="/contact" class="text-sm text-white/50 hover:text-white transition">Contact</NuxtLink></li>
          </ul>
        </div>

        <!-- Légal -->
        <div>
          <h3 class="text-xs font-bold tracking-[0.2em] uppercase text-white/30 mb-5">Légal</h3>
          <ul class="space-y-3">
            <li><a href="#" class="text-sm text-white/50 hover:text-white transition">Mentions légales</a></li>
            <li><a href="#" class="text-sm text-white/50 hover:text-white transition">Politique de confidentialité</a></li>
            <li><a href="#" class="text-sm text-white/50 hover:text-white transition">CGU</a></li>
          </ul>
        </div>

        <!-- Social -->
        <div>
          <h3 class="text-xs font-bold tracking-[0.2em] uppercase text-white/30 mb-5">Suivez-nous</h3>
          <div class="flex gap-3">
            <a href="#" class="w-10 h-10 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center hover:bg-white/10 transition">
              <UIcon name="i-simple-icons-instagram" class="text-white/50 text-lg" />
            </a>
            <a href="#" class="w-10 h-10 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center hover:bg-white/10 transition">
              <UIcon name="i-simple-icons-x" class="text-white/50 text-lg" />
            </a>
            <a href="#" class="w-10 h-10 rounded-xl bg-white/5 border border-white/10 flex items-center justify-center hover:bg-white/10 transition">
              <UIcon name="i-simple-icons-discord" class="text-white/50 text-lg" />
            </a>
          </div>
        </div>
      </div>

      <!-- Divider + Copyright -->
      <div class="border-t border-white/5 pt-8 flex flex-col md:flex-row items-center justify-between gap-4">
        <p class="text-white/20 text-xs">
          © {{ new Date().getFullYear() }} Resonance. Tous droits réservés.
        </p>
        <p class="text-white/10 text-xs">
          Fait avec ♥ pour les musiciens
        </p>
      </div>
    </div>
  </footer>
</template>


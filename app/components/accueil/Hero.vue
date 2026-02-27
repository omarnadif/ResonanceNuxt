<template>
  <section class="relative min-h-screen bg-[#080808] flex items-center overflow-hidden">

    <!-- Grain texture overlay -->
    <div class="absolute inset-0 opacity-[0.03] pointer-events-none" style="background-image: url('data:image/svg+xml,%3Csvg viewBox=%220 0 256 256%22 xmlns=%22http://www.w3.org/2000/svg%22%3E%3Cfilter id=%22noise%22%3E%3CfeTurbulence type=%22fractalNoise%22 baseFrequency=%220.9%22 numOctaves=%224%22 stitchTiles=%22stitch%22/%3E%3C/filter%3E%3Crect width=%22100%25%22 height=%22100%25%22 filter=%22url(%23noise)%22/%3E%3C/svg%3E')" />

    <!-- Orange glow top-left -->
    <div class="absolute -top-32 -left-32 w-[600px] h-[600px] bg-[#F75C03] opacity-[0.06] blur-[160px] rounded-full pointer-events-none" />

    <div class="relative max-w-7xl mx-auto px-6 pt-28 pb-20 w-full">
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">

        <!-- Left — Text -->
        <div>
          <!-- Pill badge -->
          <div class="inline-flex items-center gap-2 border border-[#F75C03]/30 bg-[#F75C03]/5 rounded-full px-4 py-1.5 mb-10">
            <span class="w-1.5 h-1.5 rounded-full bg-[#F75C03] animate-pulse" />
            <span class="text-[#F75C03] text-xs font-semibold tracking-widest uppercase">Plateforme musicale</span>
          </div>

          <!-- Headline -->
          <h1 class="font-headline font-black uppercase leading-none tracking-tight text-white" style="font-size: clamp(5rem, 12vw, 9rem); line-height: 0.88;">
            CONS-<br>
            TRUIS.<br>
            JOUE.<br>
            <span class="text-[#F75C03]">RÉSONNE.</span>
          </h1>

          <!-- Tagline -->
          <p class="mt-10 text-white/50 text-lg font-medium max-w-sm leading-relaxed">
            La plateforme des musiciens qui veulent marquer leur scène — annonces, collaborations, contacts.
          </p>

          <!-- CTAs -->
          <div class="mt-10 flex items-center gap-4 flex-wrap">
            <NuxtLink
              to="/login"
              class="inline-flex items-center gap-2 bg-[#F75C03] text-white font-semibold px-7 py-3.5 rounded-lg hover:bg-[#e05200] transition-colors text-sm"
            >
              Rejoindre maintenant
              <UIcon name="i-heroicons-arrow-right" class="text-sm" />
            </NuxtLink>
            <NuxtLink
              to="/features"
              class="inline-flex items-center gap-2 border border-white/10 text-white/60 font-semibold px-7 py-3.5 rounded-lg hover:border-white/20 hover:text-white transition-all text-sm"
            >
              Voir les annonces
            </NuxtLink>
          </div>

          <!-- Stats -->
          <div class="mt-14 flex items-center gap-10 pt-10 border-t border-white/[0.06]">
            <div>
              <p class="text-2xl font-bold text-white">500+</p>
              <p class="text-xs text-white/30 mt-0.5 uppercase tracking-widest">Musiciens</p>
            </div>
            <div class="w-px h-8 bg-white/[0.08]" />
            <div>
              <p class="text-2xl font-bold text-white">120+</p>
              <p class="text-xs text-white/30 mt-0.5 uppercase tracking-widest">Annonces</p>
            </div>
            <div class="w-px h-8 bg-white/[0.08]" />
            <div>
              <p class="text-2xl font-bold text-white">30+</p>
              <p class="text-xs text-white/30 mt-0.5 uppercase tracking-widest">Villes</p>
            </div>
          </div>
        </div>

        <!-- Right — Images -->
        <div class="relative flex justify-center items-center h-[580px] hidden lg:flex">
          <!-- Card back-left -->
          <div class="absolute w-[260px] h-[360px] rounded-2xl overflow-hidden border border-white/[0.08] -rotate-12 -translate-x-28 shadow-2xl">
            <img
              src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&q=80&w=600"
              class="w-full h-full object-cover"
              alt=""
            >
            <div class="absolute inset-0 bg-gradient-to-t from-[#080808]/60 to-transparent" />
          </div>

          <!-- Card center -->
          <div class="absolute w-[280px] h-[380px] rounded-2xl overflow-hidden border border-white/[0.08] rotate-2 z-20 shadow-[0_40px_80px_rgba(0,0,0,0.6)]">
            <img
              src="https://images.unsplash.com/photo-1514320298574-255c21f8ad0a?auto=format&fit=crop&q=80&w=600"
              class="w-full h-full object-cover"
              alt=""
            >
            <div class="absolute inset-0 bg-gradient-to-t from-[#080808]/50 to-transparent" />
            <!-- Orange accent bar -->
            <div class="absolute bottom-0 left-0 right-0 h-1 bg-[#F75C03]" />
          </div>

          <!-- Card right -->
          <div class="absolute w-[260px] h-[360px] rounded-2xl overflow-hidden border border-white/[0.08] rotate-12 translate-x-28 translate-y-10 z-10 shadow-2xl">
            <img
              src="https://images.unsplash.com/photo-1507838596058-a762b05c30f9?auto=format&fit=crop&q=80&w=600"
              class="w-full h-full object-cover"
              alt=""
            >
            <div class="absolute inset-0 bg-gradient-to-t from-[#080808]/60 to-transparent" />
          </div>
        </div>

      </div>
    </div>
  </section>
</template>

<template>
  <section class="relative pt-44 pb-24 bg-[#404040] overflow-hidden min-h-screen flex items-center">
    <div class="absolute top-0 left-1/4 w-96 h-96 bg-indigo-600/5 blur-[120px] rounded-full"></div>

    <div class="max-w-7xl mx-auto px-8 grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">

      <div class="relative z-10">
        <h1 class="text-7xl md:text-[110px] font-black tracking-tighter leading-[0.85] text-white uppercase">
          Construis.<br>
          Participe.<br>
          <span class="text-[#171717]">Monétise.</span>
        </h1>
        <p class="mt-10 text-xl text-[#A3A3A3] max-w-sm font-medium leading-snug">
          Construis ton projet, engage ta communauté et monétise ton talent pour atteindre tes objectifs.
        </p>

        <div class="mt-12">
          <NuxtLink
            to="/login"
            class="inline-flex items-center gap-3 bg-white text-black rounded-full px-10 py-4 font-bold text-lg hover:bg-zinc-200 transition-all shadow-lg"
          >
            Commencer maintenant
            <UIcon name="i-heroicons-rocket-launch" class="text-xl" />
          </NuxtLink>
        </div>
      </div>

      <div class="relative flex justify-center items-center h-[600px]">
        <div class="absolute w-[280px] h-[380px] rounded-[3.5rem] overflow-hidden border-[6px] border-[#171717] -rotate-12 -translate-x-32 shadow-2xl">
          <img src="https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&q=80&w=600" alt="Musicien en studio" class="w-full h-full object-cover" />
        </div>

        <div class="absolute w-[300px] h-[400px] rounded-[4rem] overflow-hidden border-[6px] border-[#171717] rotate-3 z-20 shadow-[0_35px_60px_-15px_rgba(0,0,0,0.5)]">
          <img src="https://images.unsplash.com/photo-1514320298574-255c21f8ad0a?auto=format&fit=crop&q=80&w=600" alt="Performance musicale" class="w-full h-full object-cover" />
        </div>

        <div class="absolute w-[280px] h-[380px] rounded-[3.5rem] overflow-hidden border-[6px] border-[#171717] rotate-12 translate-x-32 translate-y-12 z-10 shadow-2xl">
          <img src="https://images.unsplash.com/photo-1507838596058-a762b05c30f9?auto=format&fit=crop&q=80&w=600" alt="Artiste musical" class="w-full h-full object-cover" />
        </div>
      </div>
    </div>
  </section>
</template>

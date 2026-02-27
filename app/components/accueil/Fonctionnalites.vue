<template>
  <section class="relative py-24 bg-[#171717] overflow-hidden">

    <div class="relative max-w-7xl mx-auto px-6 lg:px-8">
      <h2 class="text-5xl md:text-6xl font-black text-white text-center mb-14 tracking-tighter drop-shadow-sm">
        Comment ça marche?
      </h2>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">

        <div
          v-for="(step, i) in steps"
          :key="i"
          :class="[
            'flex flex-col items-center text-center rounded-[2.5rem] p-8 shadow-2xl transition-all hover:-translate-y-2 hover:shadow-indigo-500/10 duration-300 border border-white/5',
            step.bgClass
          ]"
        >
          <h3 class="text-white font-extrabold text-[22px] tracking-tight mb-2 whitespace-pre-line leading-tight">
            {{ step.title }}
          </h3>
          <p class="text-white/75 text-[15px] font-medium leading-relaxed px-1">
            {{ step.description }}
          </p>

          <div class="mt-4 flex justify-center items-end flex-1 w-full min-h-[140px]">
            <span class="text-8xl drop-shadow-2xl hover:scale-110 transition-transform duration-300">
              {{ step.emojiFallback }}
            </span>
          </div>
        </div>

      </div>
    </div>
  </section>
</template>

<script setup>
const steps = [
  {
    title: 'Crée ton profil',
    description: 'Présente ton style et tes compétences.',
    image: '/profil-3d.png',
    emojiFallback: '👥',
    bgClass: 'bg-[#404040]'
  },
  {
    title: 'Trouve tes\ncollaborateurs',
    description: 'Rencontre les artistes qui te correspondent',
    image: '/handshake-3d.png',
    emojiFallback: '🤝',
    bgClass: 'bg-[#223055]'
  },
  {
    title: 'Collabore et produis',
    description: 'Collabore et fais vibrer ta musique',
    image: '/music-3d.png',
    emojiFallback: '🎵',
    bgClass: 'bg-[#404040]'
  },
  {
    title: 'Monétise ton talent',
    description: 'Recevez des commissions, ventes, opportunités',
    image: '/coin-3d.png',
    emojiFallback: '🪙',
    bgClass: 'bg-[#223055]'
  }
]
</script>

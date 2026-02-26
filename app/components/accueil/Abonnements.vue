<template>
  <section class="relative py-32 bg-[#171717] overflow-hidden">
    <div class="absolute top-0 right-1/4 w-[500px] h-[500px] bg-indigo-600/10 blur-[140px] rounded-full pointer-events-none" />

    <div class="relative max-w-7xl mx-auto px-8">
      <div class="text-center mb-20">
        <span class="inline-block text-xs font-bold tracking-[0.3em] uppercase text-indigo-400 mb-4">Tarifs</span>
        <h2 class="text-5xl md:text-7xl font-black tracking-tighter text-white uppercase leading-none">
          Choisis ton<br>plan.
        </h2>
        <p class="mt-6 text-lg text-[#A3A3A3] max-w-xl mx-auto">
          Commence gratuitement, puis passe à la vitesse supérieure quand tu es prêt.
        </p>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-5xl mx-auto">
        <div
          v-for="(plan, i) in plans"
          :key="i"
          class="relative flex flex-col rounded-[2rem] p-8 transition-all duration-300"
          :class="plan.featured
            ? 'bg-white text-black border-2 border-white shadow-[0_0_60px_-15px_rgba(79,70,229,0.4)] scale-[1.03]'
            : 'bg-white/5 border border-white/10 hover:bg-white/[0.07] hover:border-white/20 hover:-translate-y-1'"
        >
          <span
            v-if="plan.featured"
            class="absolute -top-3 left-1/2 -translate-x-1/2 text-xs font-black tracking-widest uppercase bg-indigo-500 text-white rounded-full px-5 py-1.5 shadow-lg"
          >
            Populaire
          </span>

          <h3 class="text-2xl font-black mb-1 tracking-tight" :class="plan.featured ? 'text-black' : 'text-white'">
            {{ plan.name }}
          </h3>
          <p class="text-sm font-medium mb-6" :class="plan.featured ? 'text-gray-500' : 'text-[#A3A3A3]'">
            {{ plan.subtitle }}
          </p>

          <div class="mb-8">
            <span class="text-5xl font-black tracking-tighter" :class="plan.featured ? 'text-black' : 'text-white'">
              {{ plan.price }}
            </span>
            <span v-if="plan.period" class="text-sm font-bold ml-1" :class="plan.featured ? 'text-gray-400' : 'text-[#737373]'">
              / {{ plan.period }}
            </span>
          </div>

          <ul class="flex-1 space-y-4 mb-8">
            <li
              v-for="(item, j) in plan.features"
              :key="j"
              class="flex items-start gap-3 text-[15px] font-medium leading-tight"
              :class="plan.featured ? 'text-gray-700' : 'text-white/70'"
            >
              <UIcon name="i-heroicons-check-circle-solid" class="text-xl mt-0.5 shrink-0" :class="plan.featured ? 'text-indigo-600' : 'text-white/30'" />
              {{ item }}
            </li>
          </ul>

          <NuxtLink
            to="/login"
            class="inline-flex items-center justify-center rounded-full px-6 py-4 font-bold text-sm transition-all shadow-lg"
            :class="plan.featured
              ? 'bg-black text-white hover:bg-gray-800 hover:scale-105'
              : 'bg-white/10 text-white border border-white/10 hover:bg-white/20'"
          >
            {{ plan.cta }}
          </NuxtLink>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
const plans = [
  {
    name: "Gratuit",
    subtitle: 'Pour débuter et explorer',
    price: '0€',
    period: 'mois',
    featured: false,
    cta: 'Commencer gratuitement',
    features: [
      'Profil artiste complet',
      'Consultation des annonces',
      'Messagerie limitée (5/jour)',
      'Accès communauté'
    ]
  },
  {
    name: 'Pro',
    subtitle: 'Pour les artistes sérieux',
    price: '9€',
    period: 'mois',
    featured: true,
    cta: 'Passer Pro',
    features: [
      'Tout du plan Gratuit',
      'Annonces illimitées',
      'Messagerie illimitée',
      'Projets collaboratifs',
      'Statistiques avancées',
      'Badge vérifié'
    ]
  },
  {
    name: 'Studio',
    subtitle: 'Pour les studios et labels',
    price: '29€',
    period: 'mois',
    featured: false,
    cta: "Contacter l'équipe",
    features: [
      'Tout du plan Pro',
      'Multi-utilisateurs (5 places)',
      'Outils de monétisation',
      'Support prioritaire',
      'API & intégrations',
      'Page studio personnalisée'
    ]
  }
]
</script>

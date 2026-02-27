<template>
  <div class="min-h-screen bg-[#080808] pt-32 pb-24 overflow-hidden">

    <!-- Glow -->
    <div class="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[600px] bg-[#F75C03] opacity-[0.04] blur-[160px] rounded-full pointer-events-none" />

    <div class="relative max-w-5xl mx-auto px-6">

      <!-- Header -->
      <div class="text-center mb-20">
        <p class="text-[#F75C03] text-xs font-semibold tracking-[0.25em] uppercase mb-4">Simple & transparent</p>
        <h1 class="font-headline font-black uppercase text-white leading-none" style="font-size: clamp(3.5rem, 8vw, 6rem); line-height: 0.9;">
          CHOISIS<br>TON PLAN.
        </h1>
        <p class="mt-6 text-white/40 text-base max-w-sm mx-auto leading-relaxed">
          Commence gratuitement, passe au niveau supérieur quand tu es prêt.
        </p>
      </div>

      <!-- Cards -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-3xl mx-auto">

        <!-- Freemium -->
        <div class="flex flex-col bg-[#0F0F0F] border border-white/[0.07] rounded-2xl p-8">
          <div class="mb-8">
            <p class="text-white/40 text-xs font-semibold tracking-[0.2em] uppercase mb-3">Freemium</p>
            <div class="flex items-end gap-1.5">
              <span class="font-headline font-black text-white text-6xl leading-none">0€</span>
              <span class="text-white/30 text-sm mb-2">/ mois</span>
            </div>
            <p class="mt-3 text-white/40 text-sm leading-relaxed">Pour débuter et explorer la communauté.</p>
          </div>

          <ul class="flex flex-col gap-3 flex-1 mb-8">
            <li v-for="f in freemiumFeatures" :key="f" class="flex items-start gap-3 text-sm">
              <span class="mt-0.5 shrink-0 w-4 h-4 rounded-full bg-white/10 flex items-center justify-center">
                <UIcon name="i-heroicons-check" class="text-white/50 text-[10px]" />
              </span>
              <span class="text-white/60">{{ f }}</span>
            </li>
          </ul>

          <NuxtLink
            to="/login"
            class="w-full inline-flex items-center justify-center gap-2 border border-white/[0.08] text-white/50 font-semibold py-3 rounded-lg hover:border-white/20 hover:text-white transition-all text-sm"
          >
            Commencer gratuitement
          </NuxtLink>
        </div>

        <!-- Premium -->
        <div class="flex flex-col bg-[#0F0F0F] border border-[#F75C03]/30 rounded-2xl p-8 relative overflow-hidden">
          <!-- Top accent bar -->
          <div class="absolute top-0 left-0 right-0 h-0.5 bg-[#F75C03]" />

          <div class="mb-8">
            <div class="flex items-center gap-3 mb-3">
              <p class="text-[#F75C03] text-xs font-semibold tracking-[0.2em] uppercase">Premium</p>
              <span class="text-[10px] font-bold uppercase tracking-widest text-[#F75C03] bg-[#F75C03]/10 border border-[#F75C03]/20 rounded-full px-2.5 py-1">
                Recommandé
              </span>
            </div>
            <div class="flex items-end gap-1.5">
              <span class="font-headline font-black text-white text-6xl leading-none">9.99€</span>
              <span class="text-white/30 text-sm mb-2">/ mois</span>
            </div>
            <p class="mt-3 text-white/40 text-sm leading-relaxed">Tout le potentiel de Resonance, sans limite.</p>
          </div>

          <ul class="flex flex-col gap-3 flex-1 mb-8">
            <li v-for="f in premiumFeatures" :key="f" class="flex items-start gap-3 text-sm">
              <span class="mt-0.5 shrink-0 w-4 h-4 rounded-full bg-[#F75C03]/15 flex items-center justify-center">
                <UIcon name="i-heroicons-check" class="text-[#F75C03] text-[10px]" />
              </span>
              <span class="text-white/80">{{ f }}</span>
            </li>
          </ul>

          <NuxtLink
            to="/login"
            class="w-full inline-flex items-center justify-center gap-2 bg-[#F75C03] text-white font-semibold py-3 rounded-lg hover:bg-[#e05200] transition-colors text-sm"
          >
            Passer au Premium
            <UIcon name="i-heroicons-arrow-right" class="text-sm" />
          </NuxtLink>
        </div>
      </div>

      <!-- FAQ / Reassurance -->
      <div class="mt-20 text-center border-t border-white/[0.05] pt-16">
        <p class="text-white/20 text-sm">
          Paiement sécurisé · Résiliation à tout moment · Sans engagement
        </p>
      </div>

    </div>
  </div>
</template>

<script setup>
const freemiumFeatures = [
  'Profil musicien complet',
  '1 annonce active',
  'Accès aux annonces publiées',
  'Contact direct par messagerie',
  'Mise en avant basique'
]

const premiumFeatures = [
  'Tout ce qui est inclus en Freemium',
  'Annonces illimitées',
  'Mise en avant prioritaire',
  'Badge Premium sur ton profil',
  'Statistiques de visibilité',
  'Support prioritaire'
]
</script>

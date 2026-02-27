<template>
  <div>
    <Hero />

    <!-- ─── COMMENT ÇA MARCHE ──────────────────────────────── -->
    <section class="bg-[#080808] py-28 border-t border-white/[0.05]">
      <div class="max-w-6xl mx-auto px-6">
        <div class="mb-16">
          <p class="text-[#F75C03] text-xs font-semibold tracking-[0.25em] uppercase mb-4">Simple & efficace</p>
          <h2 class="font-headline font-black uppercase text-white" style="font-size: clamp(2.5rem, 5vw, 4rem); line-height: 0.9;">
            EN 3 ÉTAPES.
          </h2>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-px bg-white/[0.05]">
          <div v-for="step in steps" :key="step.n" class="bg-[#080808] p-10 hover:bg-[#0F0F0F] transition-colors">
            <span class="font-headline font-black text-5xl leading-none text-[#F75C03]">{{ step.n }}</span>
            <h3 class="text-white font-bold text-lg mt-5 mb-3">{{ step.title }}</h3>
            <p class="text-white/40 text-sm leading-relaxed">{{ step.desc }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- ─── CATÉGORIES ─────────────────────────────────────── -->
    <section class="bg-[#080808] py-28 border-t border-white/[0.05]">
      <div class="max-w-6xl mx-auto px-6">
        <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-14">
          <div>
            <p class="text-[#F75C03] text-xs font-semibold tracking-[0.25em] uppercase mb-4">Ce que tu peux trouver</p>
            <h2 class="font-headline font-black uppercase text-white" style="font-size: clamp(2.5rem, 5vw, 4rem); line-height: 0.9;">
              TOUTES<br>LES CONFIGS.
            </h2>
          </div>
          <NuxtLink
            to="/features"
            class="inline-flex items-center gap-2 text-sm font-semibold text-white/40 hover:text-white border border-white/[0.07] hover:border-white/20 rounded-lg px-5 py-2.5 transition-all shrink-0"
          >
            Voir toutes les annonces <UIcon name="i-heroicons-arrow-right" class="text-sm" />
          </NuxtLink>
        </div>

        <div class="grid grid-cols-2 md:grid-cols-3 gap-3">
          <NuxtLink
            v-for="cat in categories"
            :key="cat.label"
            to="/features"
            class="flex items-center gap-4 p-5 bg-[#0F0F0F] border border-white/[0.07] rounded-xl hover:border-[#F75C03]/30 hover:bg-[#141414] transition-all"
          >
            <span class="text-2xl shrink-0">{{ cat.icon }}</span>
            <div>
              <p class="text-white font-semibold text-sm">{{ cat.label }}</p>
              <p class="text-white/30 text-xs mt-0.5">{{ cat.sub }}</p>
            </div>
          </NuxtLink>
        </div>
      </div>
    </section>

    <!-- ─── CTA FINAL ──────────────────────────────────────── -->
    <section class="bg-[#080808] border-t border-white/[0.05]">
      <div class="max-w-6xl mx-auto px-6 py-28 flex flex-col md:flex-row items-center justify-between gap-12">
        <h2 class="font-headline font-black uppercase text-white" style="font-size: clamp(3rem, 6vw, 5rem); line-height: 0.9;">
          PRÊT À<br><span class="text-[#F75C03]">RÉSONNER ?</span>
        </h2>
        <div class="flex flex-col gap-3 shrink-0">
          <NuxtLink
            to="/login"
            class="inline-flex items-center justify-center gap-2 bg-[#F75C03] text-white font-semibold px-8 py-4 rounded-lg hover:bg-[#e05200] transition-colors text-sm"
          >
            Créer mon compte gratuitement
            <UIcon name="i-heroicons-arrow-right" class="text-sm" />
          </NuxtLink>
          <NuxtLink
            to="/features"
            class="inline-flex items-center justify-center gap-2 border border-white/[0.08] text-white/40 font-semibold px-8 py-4 rounded-lg hover:border-white/15 hover:text-white transition-all text-sm"
          >
            Explorer les annonces
          </NuxtLink>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import Hero from '~/components/accueil/Hero.vue'

const steps = [
  { n: '01', title: 'Crée ton profil', desc: 'Présente ton style, tes instruments et ton niveau. Mets une photo, une bio, ta ville.' },
  { n: '02', title: 'Publie une annonce', desc: 'Recherche un musicien, un groupe, propose des cours ou une collaboration studio.' },
  { n: '03', title: 'Connecte-toi', desc: 'Trouve les profils qui correspondent et construis ton réseau musical.' }
]

const categories = [
  { icon: '🎸', label: 'Musicien cherche groupe', sub: 'Rejoindre une formation' },
  { icon: '🥁', label: 'Groupe cherche musicien', sub: 'Compléter le lineup' },
  { icon: '🎹', label: 'Cours de musique', sub: 'Apprendre & enseigner' },
  { icon: '🎤', label: 'Collaboration studio', sub: 'Enregistrer ensemble' },
  { icon: '🎵', label: 'Concert / Événement', sub: 'Jouer sur scène' },
  { icon: '🎧', label: 'Autre', sub: 'Toutes les opportunités' }
]
</script>

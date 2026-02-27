<script setup>
useHead({
  title: 'Resonance | Connect with Musicians',
  htmlAttrs: { lang: 'fr' },
  link: [
    { rel: 'icon', href: '/favicon.ico' },
    { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
    { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' },
    { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Barlow+Condensed:wght@700;800;900&family=Space+Grotesk:wght@400;500;600;700&display=swap' }
  ]
})

useSeoMeta({
  description: 'La plateforme des musiciens qui veulent marquer leur scène.',
  ogTitle: 'Resonance',
  twitterCard: 'summary_large_image'
})
</script>

<template>
  <UApp>
    <Navbar />
    <UMain>
      <NuxtPage />
    </UMain>
  </UApp>
</template>

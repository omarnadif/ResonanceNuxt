<script setup>
useHead({
  title: 'Resonance | Connect with Musicians',
  htmlAttrs: {
    lang: 'fr'
  },
  link: [
    {rel: 'icon', href: '/favicon.ico'}
  ]
})

useSeoMeta({
  description: 'The ultimate platform for musicians, singers, and producers to collaborate.',
  ogTitle: 'Resonance',
  twitterCard: 'summary_large_image'
})
</script>

<template>
  <UApp>
    <NuxtLayout>
      <Navbar></Navbar>
      <UMain>
        <NuxtPage/>
      </UMain>
    </NuxtLayout>

    <UNotifications/>
  </UApp>
</template>

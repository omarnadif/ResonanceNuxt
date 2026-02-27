<template>
  <div class="min-h-screen bg-[#080808] pt-32 pb-24 overflow-hidden">

    <!-- Glow -->
    <div class="absolute top-0 right-1/3 w-[500px] h-[500px] bg-[#F75C03] opacity-[0.04] blur-[160px] rounded-full pointer-events-none" />

    <div class="relative max-w-5xl mx-auto px-6">

      <!-- Header -->
      <div class="mb-16">
        <p class="text-[#F75C03] text-xs font-semibold tracking-[0.25em] uppercase mb-4">On t'écoute</p>
        <h1 class="font-headline font-black uppercase text-white leading-none" style="font-size: clamp(3.5rem, 8vw, 6rem); line-height: 0.9;">
          CONTACTE<br>L'ÉQUIPE.
        </h1>
        <p class="mt-6 text-white/40 text-base max-w-md leading-relaxed">
          Une question, un bug, une idée ? Écris-nous, on répond dans les 48h.
        </p>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-5 gap-12">

        <!-- Form -->
        <div class="lg:col-span-3">
          <form class="flex flex-col gap-5" @submit.prevent="submit">

            <!-- Nom + Email -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label class="field-label">Nom *</label>
                <input v-model="form.name" type="text" placeholder="Jean Dupont" class="field-input" required>
              </div>
              <div>
                <label class="field-label">Votre email *</label>
                <input v-model="form.email" type="email" placeholder="jean@example.com" class="field-input" required>
              </div>
            </div>

            <!-- Sujet -->
            <div>
              <label class="field-label">Sujet</label>
              <select v-model="form.subject" class="field-input">
                <option value="" class="bg-[#0F0F0F] text-white/50">Choisir un sujet…</option>
                <option value="Question générale" class="bg-[#0F0F0F] text-white">Question générale</option>
                <option value="Problème technique" class="bg-[#0F0F0F] text-white">Problème technique</option>
                <option value="Signaler un contenu" class="bg-[#0F0F0F] text-white">Signaler un contenu</option>
                <option value="Partenariat" class="bg-[#0F0F0F] text-white">Partenariat</option>
                <option value="Autre" class="bg-[#0F0F0F] text-white">Autre</option>
              </select>
            </div>

            <!-- Message -->
            <div>
              <label class="field-label">Message *</label>
              <textarea
                v-model="form.message"
                rows="6"
                placeholder="Décris ta demande en détail…"
                class="field-input resize-none"
                required
              />
            </div>

            <button
              type="submit"
              class="inline-flex items-center justify-center gap-2 bg-[#F75C03] text-white font-semibold px-8 py-3.5 rounded-lg hover:bg-[#e05200] transition-colors text-sm"
            >
              <UIcon name="i-heroicons-paper-airplane" class="text-sm" />
              Envoyer le message
            </button>

            <p class="text-white/20 text-xs">
              En cliquant sur "Envoyer", votre client mail s'ouvrira avec le message pré-rempli.
            </p>
          </form>
        </div>

        <!-- Infos -->
        <div class="lg:col-span-2 flex flex-col gap-4 pt-2">
          <div
            v-for="info in infos"
            :key="info.label"
            class="flex items-start gap-4 p-5 bg-[#0F0F0F] border border-white/[0.07] rounded-2xl"
          >
            <div class="w-10 h-10 rounded-xl bg-[#F75C03]/10 flex items-center justify-center shrink-0">
              <UIcon :name="info.icon" class="text-[#F75C03] text-base" />
            </div>
            <div>
              <p class="text-white font-semibold text-sm mb-0.5">{{ info.label }}</p>
              <p class="text-white/40 text-sm leading-relaxed">{{ info.value }}</p>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<script setup>
const form = ref({ name: '', email: '', subject: '', message: '' })

const infos = [
  { icon: 'i-heroicons-clock', label: 'Temps de réponse', value: 'Nous répondons sous 48h en jours ouvrés.' },
  { icon: 'i-heroicons-envelope', label: 'Email', value: 'loris.lebreton@hotmail.com' },
  { icon: 'i-heroicons-map-pin', label: 'Basé en France', value: 'Paris, France 🇫🇷' }
]

function submit() {
  const to = 'loris.lebreton@hotmail.com'
  const subject = encodeURIComponent(
    form.value.subject
      ? `[Resonance] ${form.value.subject}`
      : '[Resonance] Message de contact'
  )
  const body = encodeURIComponent(
    `Nom : ${form.value.name}\nEmail : ${form.value.email}\n\n${form.value.message}`
  )
  window.location.href = `mailto:${to}?subject=${subject}&body=${body}`
}
</script>

<style scoped>
@reference "~/assets/css/main.css";

.field-label {
  @apply block text-xs font-semibold text-white/40 uppercase tracking-widest mb-1.5;
}
.field-input {
  @apply w-full bg-white/[0.04] border border-white/[0.07] rounded-lg px-4 py-2.5 text-white text-sm placeholder-white/20 outline-none focus:border-[#F75C03]/40 focus:bg-white/[0.06] transition-all;
}
</style>

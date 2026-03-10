<template>
  <div class="min-h-screen bg-[#080808] pt-24 pb-24">

    <!-- Glow -->
    <div class="absolute top-0 right-1/4 w-[500px] h-[500px] bg-[#F75C03] opacity-[0.04] blur-[160px] rounded-full pointer-events-none" />

    <div class="relative max-w-6xl mx-auto px-6">

      <!-- Header -->
      <div class="mb-14 pt-8">
        <p class="text-[#F75C03] text-xs font-semibold tracking-[0.25em] uppercase mb-4">Toutes les annonces</p>
        <h1 class="font-headline font-black uppercase text-white leading-none" style="font-size: clamp(3.5rem, 8vw, 6rem); line-height: 0.9;">
          TROUVE<br>TON ÉQUIPE.
        </h1>
        <p class="mt-6 text-white/40 text-base max-w-md leading-relaxed">
          Musiciens, groupes, profs, studios — toutes les annonces publiées par la communauté.
        </p>
      </div>

      <!-- Filtres -->
      <div class="flex flex-col md:flex-row gap-3 mb-10">
        <div class="relative flex-1">
          <UIcon name="i-heroicons-magnifying-glass" class="absolute left-4 top-1/2 -translate-y-1/2 text-white/20 text-sm pointer-events-none" />
          <input
            v-model="search"
            type="text"
            placeholder="Rechercher…"
            class="w-full bg-white/[0.04] border border-white/[0.07] rounded-lg pl-10 pr-4 py-2.5 text-white text-sm placeholder-white/20 outline-none focus:border-[#F75C03]/40 transition-all"
          >
        </div>

        <select v-model="filterType" class="filter-select">
          <option value="" class="bg-[#0F0F0F]">Tous les types</option>
          <option value="Musicien cherche groupe" class="bg-[#0F0F0F]">Musicien cherche groupe</option>
          <option value="Groupe cherche musicien" class="bg-[#0F0F0F]">Groupe cherche musicien</option>
          <option value="Cours de musique" class="bg-[#0F0F0F]">Cours de musique</option>
          <option value="Collaboration studio" class="bg-[#0F0F0F]">Collaboration studio</option>
          <option value="Concert / Événement" class="bg-[#0F0F0F]">Concert / Événement</option>
          <option value="Autre" class="bg-[#0F0F0F]">Autre</option>
        </select>

        <select v-model="filterGenre" class="filter-select">
          <option value="" class="bg-[#0F0F0F]">Tous les genres</option>
          <option v-for="g in availableGenres" :key="g" :value="g" class="bg-[#0F0F0F]">{{ g }}</option>
        </select>

        <button
          v-if="hasFilters"
          class="flex items-center gap-1.5 text-white/30 hover:text-white text-sm px-4 py-2.5 border border-white/[0.07] rounded-lg transition-colors"
          @click="resetFilters"
        >
          <UIcon name="i-heroicons-x-mark" class="text-sm" />
          Effacer
        </button>
      </div>

      <!-- Loader -->
      <div v-if="pending" class="flex justify-center py-28">
        <div class="flex flex-col items-center gap-4">
          <div class="w-8 h-8 border-2 border-white/[0.08] border-t-[#F75C03] rounded-full animate-spin" />
          <p class="text-white/20 text-sm">Chargement…</p>
        </div>
      </div>

      <!-- Empty -->
      <div
        v-else-if="!filtered.length"
        class="flex flex-col items-center justify-center py-28 border border-dashed border-white/[0.07] rounded-2xl"
      >
        <UIcon name="i-heroicons-face-frown" class="text-white/10 mb-4" style="font-size: 3rem;" />
        <p class="text-white/30 text-sm">
          {{ hasFilters ? 'Aucun résultat.' : 'Aucune annonce publiée pour le moment.' }}
        </p>
        <button v-if="hasFilters" class="mt-3 text-[#F75C03] text-sm hover:underline" @click="resetFilters">
          Effacer les filtres
        </button>
      </div>

      <!-- Count -->
      <p v-else class="text-white/20 text-xs uppercase tracking-widest mb-6">
        {{ filtered.length }} annonce{{ filtered.length > 1 ? 's' : '' }}
      </p>

      <!-- Grid -->
      <div v-if="!pending && filtered.length" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        <article
          v-for="ann in filtered"
          :key="ann.id"
          class="group flex flex-col bg-[#0F0F0F] border border-white/[0.07] rounded-2xl p-6 hover:border-[#F75C03]/30 hover:-translate-y-0.5 transition-all"
        >
          <!-- Author -->
          <div class="flex items-center gap-3 mb-5">
            <NuxtLink :to="`/user/${ann.id_profile}`" class="w-8 h-8 rounded-lg overflow-hidden shrink-0 bg-[#1A1A1A] border border-white/[0.07] flex items-center justify-center hover:border-[#F75C03]/30 transition-colors">
              <img v-if="ann.avatar_url" :src="ann.avatar_url" :alt="authorName(ann)" class="w-full h-full object-cover">
              <UIcon v-else name="i-heroicons-user" class="text-white/20 text-base" />
            </NuxtLink>
            <div class="min-w-0 flex-1">
              <NuxtLink :to="`/user/${ann.id_profile}`" class="text-white text-sm font-semibold truncate hover:text-[#F75C03] transition-colors block">{{ authorName(ann) }}</NuxtLink>
              <p v-if="ann.city" class="text-white/30 text-xs">{{ ann.city }}</p>
            </div>
            <span v-if="ann.type" class="text-xs text-[#F75C03]/70 bg-[#F75C03]/[0.08] border border-[#F75C03]/20 rounded-full px-2.5 py-0.5 shrink-0 hidden xl:block">
              {{ ann.type }}
            </span>
          </div>

          <!-- Content -->
          <h3 class="text-white font-bold text-base leading-snug line-clamp-2 mb-2">
            {{ ann.title || 'Sans titre' }}
          </h3>
          <p v-if="ann.description" class="text-white/40 text-sm leading-relaxed line-clamp-3 flex-1">
            {{ ann.description }}
          </p>

          <!-- Tags -->
          <div class="mt-4 flex flex-wrap gap-1.5">
            <span v-if="ann.instrument" class="tag">
              <UIcon name="i-heroicons-musical-note" class="text-[#F75C03] text-xs" />{{ ann.instrument }}
            </span>
            <span v-if="ann.genre" class="tag">
              <UIcon name="i-heroicons-tag" class="text-xs" />{{ ann.genre }}
            </span>
            <span v-if="ann.location" class="tag">
              <UIcon name="i-heroicons-map-pin" class="text-xs" />{{ ann.location }}
            </span>
          </div>

          <!-- Prix + date -->
          <div class="mt-5 pt-4 border-t border-white/[0.05] flex items-center justify-between">
            <div v-if="ann.price" class="text-white font-bold text-sm">
              {{ ann.price }}€
              <span v-if="ann.price_type" class="text-white/30 font-normal text-xs ml-1">/ {{ ann.price_type }}</span>
            </div>
            <div v-else class="text-white/20 text-xs">À discuter</div>
            <span class="text-white/20 text-xs">{{ formatDate(ann.created_date) }}</span>
          </div>

          <!-- Bouton intérêt (masqué si c'est sa propre annonce) -->
          <div v-if="!user || ann.id_profile !== user.id" class="mt-3">
            <NuxtLink
              v-if="myInterestMap[ann.id]?.status === 'accepted' && myInterestMap[ann.id]?.conversation_id"
              :to="`/conversations?id=${myInterestMap[ann.id].conversation_id}`"
              class="w-full inline-flex items-center justify-center gap-1.5 text-xs font-semibold text-[#F75C03] bg-[#F75C03]/10 border border-[#F75C03]/20 rounded-lg py-2 hover:bg-[#F75C03]/20 transition-colors"
            >
              <UIcon name="i-heroicons-chat-bubble-left-right" class="text-xs" />
              Ouvrir le chat
            </NuxtLink>
            <button
              v-else-if="myInterestMap[ann.id]?.status === 'pending'"
              disabled
              class="w-full inline-flex items-center justify-center gap-1.5 text-xs font-semibold text-white/30 bg-white/5 border border-white/10 rounded-lg py-2 cursor-default"
            >
              <UIcon name="i-heroicons-clock" class="text-xs" />
              Demande envoyée
            </button>
            <button
              v-else
              :disabled="interestLoading.has(ann.id)"
              class="w-full inline-flex items-center justify-center gap-1.5 text-xs font-semibold text-white/50 bg-white/[0.04] border border-white/[0.07] rounded-lg py-2 hover:bg-[#F75C03]/10 hover:text-[#F75C03] hover:border-[#F75C03]/20 transition-all disabled:opacity-40"
              @click="submitInterest(ann.id)"
            >
              <UIcon v-if="interestLoading.has(ann.id)" name="i-heroicons-arrow-path" class="text-xs animate-spin" />
              <UIcon v-else name="i-heroicons-hand-raised" class="text-xs" />
              {{ interestLoading.has(ann.id) ? '…' : 'Je suis intéressé' }}
            </button>
          </div>
        </article>
      </div>
    </div>
  </div>
</template>

<script setup>
const supabase = useSupabaseClient()
const user = useSupabaseUser()

const announcements = ref([])
const pending = ref(true)
const search = ref('')
const filterType = ref('')
const filterGenre = ref('')

const myInterestMap = ref({}) // annId -> { status, conversation_id }
const interestLoading = ref(new Set())

const hasFilters = computed(() => search.value || filterType.value || filterGenre.value)

const availableGenres = computed(() => {
  const genres = announcements.value.map(a => a.genre).filter(Boolean)
  return [...new Set(genres)].sort()
})

const filtered = computed(() => {
  let list = announcements.value
  if (search.value.trim()) {
    const q = search.value.toLowerCase()
    list = list.filter(a =>
      a.title?.toLowerCase().includes(q)
      || a.description?.toLowerCase().includes(q)
      || a.instrument?.toLowerCase().includes(q)
      || a.genre?.toLowerCase().includes(q)
    )
  }
  if (filterType.value) list = list.filter(a => a.type === filterType.value)
  if (filterGenre.value) list = list.filter(a => a.genre === filterGenre.value)
  return list
})

function authorName(ann) {
  return ann.stage_name || `${ann.first_name ?? ''} ${ann.last_name ?? ''}`.trim() || 'Utilisateur'
}

function formatDate(dateStr) {
  if (!dateStr) return ''
  return new Date(dateStr).toLocaleDateString('fr-FR', { day: 'numeric', month: 'short', year: 'numeric' })
}

function resetFilters() {
  search.value = ''
  filterType.value = ''
  filterGenre.value = ''
}

async function submitInterest(annId) {
  if (!user.value) { await navigateTo('/login'); return }

  const loading = new Set(interestLoading.value)
  loading.add(annId)
  interestLoading.value = loading

  const { error } = await supabase.rpc('submit_interest', { p_announcement_id: annId })
  if (!error) {
    myInterestMap.value = { ...myInterestMap.value, [annId]: { status: 'pending', conversation_id: null } }
  }

  const newLoading = new Set(interestLoading.value)
  newLoading.delete(annId)
  interestLoading.value = newLoading
}

onMounted(async () => {
  const [annRes, interestRes] = await Promise.all([
    supabase.rpc('get_published_announcements'),
    user.value ? supabase.rpc('get_my_interests_sent') : Promise.resolve({ data: [] })
  ])

  if (annRes.data) announcements.value = annRes.data
  if (interestRes.data) {
    const map = {}
    for (const i of interestRes.data) {
      if (i.status !== 'rejected') {
        map[i.announcement_id] = { status: i.status, conversation_id: i.conversation_id }
      }
    }
    myInterestMap.value = map
  }

  pending.value = false
})
</script>

<style scoped>
@reference "~/assets/css/main.css";

.filter-select {
  @apply bg-[#0F0F0F] border border-white/[0.07] rounded-lg px-4 py-2.5 text-white/60 text-sm outline-none focus:border-[#F75C03]/40 transition-all min-w-[180px];
}
.tag {
  @apply flex items-center gap-1 text-xs text-white/40 bg-white/[0.04] border border-white/[0.07] rounded-full px-2.5 py-1;
}
</style>

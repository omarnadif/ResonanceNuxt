<template>
  <div class="min-h-screen bg-[#171717] pt-32 pb-24">

    <div class="absolute top-0 left-1/3 w-[600px] h-[600px] bg-green-500/5 blur-[160px] rounded-full pointer-events-none" />
    <div class="absolute bottom-0 right-1/4 w-[400px] h-[400px] bg-indigo-600/5 blur-[120px] rounded-full pointer-events-none" />

    <div class="relative max-w-6xl mx-auto px-6">

      <!-- ─── HEADER ──────────────────────────────────────────── -->
      <div class="mb-12">
        <h1 class="text-5xl md:text-7xl font-black tracking-tighter text-white uppercase leading-none">
          Annonces
        </h1>
        <p class="mt-4 text-[#A3A3A3] text-lg max-w-xl">
          Trouve des musiciens, des groupes ou des collaborateurs près de chez toi.
        </p>
      </div>

      <!-- ─── FILTRES ─────────────────────────────────────────── -->
      <div class="flex flex-col md:flex-row gap-3 mb-10">

        <!-- Recherche -->
        <div class="relative flex-1">
          <UIcon name="i-heroicons-magnifying-glass" class="absolute left-4 top-1/2 -translate-y-1/2 text-white/30 text-sm pointer-events-none" />
          <input
            v-model="search"
            type="text"
            placeholder="Rechercher une annonce…"
            class="w-full bg-white/5 border border-white/10 rounded-xl pl-10 pr-4 py-2.5 text-white text-sm placeholder-white/20 outline-none focus:border-green-400/50 focus:bg-white/[0.07] transition-all"
          >
        </div>

        <!-- Filtre type -->
        <select
          v-model="filterType"
          class="bg-[#1c1c1c] border border-white/10 rounded-xl px-4 py-2.5 text-white text-sm outline-none focus:border-green-400/50 transition-all min-w-[200px]"
        >
          <option value="" class="bg-[#1c1c1c] text-white/50">Tous les types</option>
          <option value="Musicien cherche groupe" class="bg-[#1c1c1c] text-white">Musicien cherche groupe</option>
          <option value="Groupe cherche musicien" class="bg-[#1c1c1c] text-white">Groupe cherche musicien</option>
          <option value="Cours de musique" class="bg-[#1c1c1c] text-white">Cours de musique</option>
          <option value="Collaboration studio" class="bg-[#1c1c1c] text-white">Collaboration studio</option>
          <option value="Concert / Événement" class="bg-[#1c1c1c] text-white">Concert / Événement</option>
          <option value="Autre" class="bg-[#1c1c1c] text-white">Autre</option>
        </select>

        <!-- Filtre genre -->
        <select
          v-model="filterGenre"
          class="bg-[#1c1c1c] border border-white/10 rounded-xl px-4 py-2.5 text-white text-sm outline-none focus:border-green-400/50 transition-all min-w-[160px]"
        >
          <option value="" class="bg-[#1c1c1c] text-white/50">Tous les genres</option>
          <option v-for="g in availableGenres" :key="g" :value="g" class="bg-[#1c1c1c] text-white">{{ g }}</option>
        </select>

        <!-- Reset filtres -->
        <UButton
          v-if="hasFilters"
          icon="i-heroicons-x-mark"
          label="Réinitialiser"
          variant="ghost"
          color="neutral"
          size="sm"
          class="rounded-xl text-white/50 hover:text-white"
          @click="resetFilters"
        />
      </div>

      <!-- ─── RÉSULTATS ───────────────────────────────────────── -->

      <!-- Loader -->
      <div v-if="pending" class="flex justify-center py-24">
        <div class="flex flex-col items-center gap-4">
          <div class="w-10 h-10 border-2 border-white/10 border-t-green-400 rounded-full animate-spin" />
          <p class="text-white/30 text-sm">Chargement des annonces…</p>
        </div>
      </div>

      <!-- Aucun résultat -->
      <div
        v-else-if="!filtered.length"
        class="flex flex-col items-center justify-center py-24 border border-dashed border-white/10 rounded-3xl"
      >
        <UIcon name="i-heroicons-face-frown" class="text-white/15 mb-4" style="font-size: 3rem;" />
        <p class="text-white/40 text-sm">
          {{ hasFilters ? 'Aucune annonce ne correspond à ta recherche.' : 'Aucune annonce publiée pour le moment.' }}
        </p>
        <UButton
          v-if="hasFilters"
          label="Effacer les filtres"
          variant="ghost"
          color="primary"
          size="sm"
          class="mt-3"
          @click="resetFilters"
        />
      </div>

      <!-- Compteur -->
      <p v-else class="text-white/30 text-sm mb-5">
        {{ filtered.length }} annonce{{ filtered.length > 1 ? 's' : '' }}
      </p>

      <!-- Grille -->
      <div v-if="!pending && filtered.length" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
        <div
          v-for="ann in filtered"
          :key="ann.id"
          class="group flex flex-col bg-white/5 border border-white/10 rounded-3xl p-6 hover:bg-white/[0.07] hover:border-white/20 hover:-translate-y-0.5 transition-all"
        >

          <!-- Auteur -->
          <div class="flex items-center gap-3 mb-5">
            <div class="w-9 h-9 rounded-xl overflow-hidden shrink-0 bg-[#404040] border border-white/10 flex items-center justify-center">
              <img
                v-if="ann.avatar_url"
                :src="ann.avatar_url"
                :alt="authorName(ann)"
                class="w-full h-full object-cover"
              >
              <UIcon v-else name="i-heroicons-user" class="text-white/20 text-lg" />
            </div>
            <div class="min-w-0">
              <p class="text-white text-sm font-semibold truncate">{{ authorName(ann) }}</p>
              <p v-if="ann.city" class="text-white/30 text-xs truncate">{{ ann.city }}</p>
            </div>
            <span
              v-if="ann.type"
              class="ml-auto text-xs text-white/40 bg-white/5 border border-white/10 rounded-full px-2.5 py-0.5 shrink-0 hidden lg:block"
            >
              {{ ann.type }}
            </span>
          </div>

          <!-- Contenu -->
          <h3 class="text-white font-bold text-lg leading-snug line-clamp-2 mb-2">
            {{ ann.title || 'Sans titre' }}
          </h3>
          <p v-if="ann.description" class="text-white/50 text-sm leading-relaxed line-clamp-3 flex-1">
            {{ ann.description }}
          </p>

          <!-- Tags -->
          <div class="mt-4 flex flex-wrap gap-1.5">
            <span
              v-if="ann.instrument"
              class="flex items-center gap-1 text-xs text-white/50 bg-white/5 border border-white/10 rounded-full px-2.5 py-1"
            >
              <UIcon name="i-heroicons-musical-note" class="text-xs text-green-400" />
              {{ ann.instrument }}
            </span>
            <span
              v-if="ann.genre"
              class="flex items-center gap-1 text-xs text-white/50 bg-white/5 border border-white/10 rounded-full px-2.5 py-1"
            >
              <UIcon name="i-heroicons-tag" class="text-xs" />
              {{ ann.genre }}
            </span>
            <span
              v-if="ann.location"
              class="flex items-center gap-1 text-xs text-white/50 bg-white/5 border border-white/10 rounded-full px-2.5 py-1"
            >
              <UIcon name="i-heroicons-map-pin" class="text-xs" />
              {{ ann.location }}
            </span>
          </div>

          <!-- Footer -->
          <div class="mt-5 pt-4 border-t border-white/5 flex items-center justify-between">
            <div v-if="ann.price" class="text-white font-bold text-sm">
              {{ ann.price }}€
              <span v-if="ann.price_type" class="text-white/30 font-normal text-xs ml-1">/ {{ ann.price_type }}</span>
            </div>
            <div v-else class="text-white/20 text-xs">Gratuit / À discuter</div>
            <span class="text-white/25 text-xs">{{ formatDate(ann.created_date) }}</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
const supabase = useSupabaseClient()

const announcements = ref([])
const pending = ref(true)
const search = ref('')
const filterType = ref('')
const filterGenre = ref('')

const hasFilters = computed(() => search.value || filterType.value || filterGenre.value)

const availableGenres = computed(() => {
  const genres = announcements.value
    .map(a => a.genre)
    .filter(Boolean)
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

  if (filterType.value) {
    list = list.filter(a => a.type === filterType.value)
  }

  if (filterGenre.value) {
    list = list.filter(a => a.genre === filterGenre.value)
  }

  return list
})

function authorName(ann) {
  return ann.stage_name
    || `${ann.first_name ?? ''} ${ann.last_name ?? ''}`.trim()
    || 'Utilisateur'
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

onMounted(async () => {
  const { data } = await supabase.rpc('get_published_announcements')
  if (data) announcements.value = data
  pending.value = false
})
</script>

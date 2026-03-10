<template>
  <div class="min-h-screen bg-[#080808] pt-32 pb-24 overflow-hidden">

    <div class="absolute top-0 right-1/4 w-[600px] h-[600px] bg-[#F75C03]/4 blur-[160px] rounded-full pointer-events-none" />

    <!-- Loader -->
    <div v-if="pending" class="flex justify-center items-center min-h-[50vh]">
      <div class="w-12 h-12 border-2 border-white/10 border-t-[#F75C03] rounded-full animate-spin" />
    </div>

    <!-- Not found -->
    <div v-else-if="!profile" class="flex flex-col items-center justify-center min-h-[50vh] gap-4">
      <UIcon name="i-heroicons-user-slash" class="text-white/10" style="font-size: 4rem;" />
      <p class="text-white/40">Profil introuvable.</p>
      <NuxtLink to="/features" class="text-[#F75C03] text-sm hover:underline">← Retour aux annonces</NuxtLink>
    </div>

    <div v-else class="relative max-w-5xl mx-auto px-6">

      <!-- ─── HEADER ────────────────────────────────────────────── -->
      <div class="flex flex-col md:flex-row gap-8 items-start">
        <!-- Avatar -->
        <div class="shrink-0">
          <img
            v-if="profile.avatar_url"
            :src="profile.avatar_url"
            :alt="displayName"
            class="w-28 h-28 md:w-36 md:h-36 rounded-3xl object-cover border-2 border-white/10 shadow-2xl"
          >
          <div
            v-else
            class="w-28 h-28 md:w-36 md:h-36 rounded-3xl bg-[#1A1A1A] border-2 border-white/10 flex items-center justify-center"
          >
            <UIcon name="i-heroicons-user" class="text-white/20 text-6xl" />
          </div>
        </div>

        <!-- Info -->
        <div class="flex-1 min-w-0">
          <h1 class="text-3xl md:text-5xl font-black tracking-tighter text-white uppercase leading-none">
            {{ displayName }}
          </h1>
          <p v-if="profile.stage_name && profile.first_name" class="text-white/40 text-base mt-1.5">
            {{ profile.first_name }} {{ profile.last_name }}
          </p>
          <div v-if="profile.city" class="flex items-center gap-1.5 mt-2">
            <UIcon name="i-heroicons-map-pin-mini" class="text-white/40 text-sm shrink-0" />
            <span class="text-white/40 text-sm">{{ profile.city }}</span>
          </div>
          <p v-if="profile.bio" class="mt-4 text-white/60 max-w-lg leading-relaxed text-sm">
            {{ profile.bio }}
          </p>

          <!-- Rating summary -->
          <div class="mt-5">
            <div v-if="stats.review_count > 0" class="inline-flex items-center gap-3 bg-white/5 border border-white/10 rounded-2xl px-5 py-3">
              <div class="flex items-center gap-0.5">
                <UIcon
                  v-for="s in 5" :key="s"
                  :name="s <= Math.round(Number(stats.avg_rating)) ? 'i-heroicons-star-20-solid' : 'i-heroicons-star'"
                  class="text-lg"
                  :class="s <= Math.round(Number(stats.avg_rating)) ? 'text-[#F75C03]' : 'text-white/15'"
                />
              </div>
              <div class="w-px h-5 bg-white/10" />
              <div>
                <span class="text-white font-black text-lg">{{ stats.avg_rating }}</span>
                <span class="text-white/30 text-sm ml-1">/ 5</span>
              </div>
              <div class="w-px h-5 bg-white/10" />
              <span class="text-white/40 text-sm">{{ stats.review_count }} avis</span>
            </div>
            <div v-else class="inline-flex items-center gap-2 text-white/20 text-sm">
              <div class="flex items-center gap-0.5">
                <UIcon v-for="s in 5" :key="s" name="i-heroicons-star" class="text-base text-white/10" />
              </div>
              Aucun avis pour le moment
            </div>
          </div>
        </div>
      </div>

      <!-- ─── LAISSER UN AVIS ──────────────────────────────────── -->
      <section v-if="user && user.id !== route.params.id" class="mt-14">
        <h2 class="section-label">{{ myReview ? 'Modifier votre avis' : 'Laisser un avis' }}</h2>
        <div class="bg-[#0F0F0F] border border-white/[0.07] rounded-2xl p-6 max-w-2xl">

          <!-- Étoiles cliquables -->
          <div class="flex items-center gap-1 mb-5">
            <button
              v-for="s in 5"
              :key="s"
              class="transition-all hover:scale-110 active:scale-95"
              @mouseenter="hoverRating = s"
              @mouseleave="hoverRating = 0"
              @click="reviewForm.rating = s"
            >
              <UIcon
                :name="s <= (hoverRating || reviewForm.rating) ? 'i-heroicons-star-20-solid' : 'i-heroicons-star'"
                class="text-3xl transition-colors"
                :class="s <= (hoverRating || reviewForm.rating) ? 'text-[#F75C03]' : 'text-white/20'"
              />
            </button>
            <span v-if="hoverRating || reviewForm.rating" class="ml-3 text-sm font-semibold text-white/60">
              {{ ratingLabels[hoverRating || reviewForm.rating] }}
            </span>
          </div>

          <!-- Commentaire -->
          <textarea
            v-model="reviewForm.comment"
            rows="3"
            placeholder="Décrivez votre expérience avec ce musicien…"
            class="w-full bg-white/5 border border-white/10 rounded-xl px-4 py-3 text-white text-sm placeholder-white/20 outline-none focus:border-[#F75C03]/50 focus:bg-white/[0.07] transition-all resize-none"
          />

          <div v-if="reviewError" class="mt-2 flex items-center gap-2 text-red-400 text-sm">
            <UIcon name="i-heroicons-exclamation-circle" class="shrink-0 text-base" />
            {{ reviewError }}
          </div>
          <div v-if="reviewSuccess" class="mt-2 flex items-center gap-2 text-[#F75C03] text-sm">
            <UIcon name="i-heroicons-check-circle" class="shrink-0 text-base" />
            Avis publié !
          </div>

          <div class="flex items-center justify-between mt-4">
            <span class="text-white/20 text-xs">{{ reviewForm.comment?.length ?? 0 }} caractères</span>
            <button
              :disabled="!reviewForm.rating || reviewSaving"
              class="inline-flex items-center gap-2 text-sm font-bold text-white bg-[#F75C03] rounded-xl px-6 py-2.5 hover:bg-[#F75C03]/90 disabled:opacity-40 disabled:cursor-not-allowed transition-all"
              @click="submitReview"
            >
              <UIcon v-if="reviewSaving" name="i-heroicons-arrow-path" class="text-sm animate-spin" />
              {{ myReview ? 'Mettre à jour' : 'Publier' }}
            </button>
          </div>
        </div>
      </section>

      <!-- ─── AVIS REÇUS ───────────────────────────────────────── -->
      <section class="mt-14">
        <h2 class="section-label">
          Avis
          <span v-if="reviews.length" class="ml-2 text-white/30 font-normal normal-case tracking-normal text-sm">({{ reviews.length }})</span>
        </h2>

        <div v-if="!reviews.length" class="py-12 flex flex-col items-center justify-center border border-dashed border-white/[0.07] rounded-2xl">
          <UIcon name="i-heroicons-chat-bubble-left-ellipsis" class="text-white/10 mb-3" style="font-size: 2.5rem;" />
          <p class="text-white/25 text-sm">Aucun avis pour le moment</p>
        </div>

        <div v-else class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div
            v-for="r in reviews"
            :key="r.id"
            class="bg-[#0F0F0F] border border-white/[0.07] rounded-2xl p-5 hover:border-white/10 transition-colors"
          >
            <!-- Reviewer header -->
            <div class="flex items-center gap-3 mb-4">
              <NuxtLink :to="`/user/${r.reviewer_id}`" class="w-9 h-9 rounded-xl overflow-hidden shrink-0 bg-[#1A1A1A] border border-white/[0.07] flex items-center justify-center hover:border-white/20 transition-colors">
                <img v-if="r.reviewer_avatar_url" :src="r.reviewer_avatar_url" class="w-full h-full object-cover">
                <UIcon v-else name="i-heroicons-user" class="text-white/20 text-sm" />
              </NuxtLink>
              <div class="flex-1 min-w-0">
                <NuxtLink :to="`/user/${r.reviewer_id}`" class="text-white text-sm font-semibold hover:text-[#F75C03] transition-colors">
                  {{ r.reviewer_stage_name || `${r.reviewer_first_name ?? ''} ${r.reviewer_last_name ?? ''}`.trim() || 'Utilisateur' }}
                </NuxtLink>
                <p class="text-white/30 text-xs">{{ formatDate(r.created_at) }}</p>
              </div>
              <!-- Stars -->
              <div class="flex items-center gap-0.5 shrink-0">
                <UIcon
                  v-for="s in 5"
                  :key="s"
                  :name="s <= r.rating ? 'i-heroicons-star-20-solid' : 'i-heroicons-star'"
                  class="text-sm"
                  :class="s <= r.rating ? 'text-[#F75C03]' : 'text-white/15'"
                />
              </div>
            </div>
            <p v-if="r.comment" class="text-white/50 text-sm leading-relaxed">{{ r.comment }}</p>
            <p v-else class="text-white/20 text-sm italic">Aucun commentaire</p>
          </div>
        </div>
      </section>

      <!-- ─── ANNONCES ─────────────────────────────────────────── -->
      <section v-if="announcements.length" class="mt-14">
        <h2 class="section-label">
          Annonces
          <span class="ml-2 text-white/30 font-normal normal-case tracking-normal text-sm">({{ announcements.length }})</span>
        </h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <article
            v-for="ann in announcements"
            :key="ann.id"
            class="bg-[#0F0F0F] border border-white/[0.07] rounded-2xl p-5 hover:border-[#F75C03]/30 transition-all"
          >
            <span v-if="ann.type" class="inline-block text-xs text-[#F75C03]/70 bg-[#F75C03]/[0.08] border border-[#F75C03]/20 rounded-full px-2.5 py-0.5 mb-3">
              {{ ann.type }}
            </span>
            <h3 class="text-white font-bold text-base leading-snug line-clamp-2 mb-2">{{ ann.title }}</h3>
            <p v-if="ann.description" class="text-white/40 text-sm leading-relaxed line-clamp-3">{{ ann.description }}</p>
            <div class="mt-4 flex flex-wrap gap-1.5">
              <span v-if="ann.instrument" class="tag"><UIcon name="i-heroicons-musical-note" class="text-[#F75C03] text-xs" />{{ ann.instrument }}</span>
              <span v-if="ann.genre" class="tag"><UIcon name="i-heroicons-tag" class="text-xs" />{{ ann.genre }}</span>
              <span v-if="ann.location" class="tag"><UIcon name="i-heroicons-map-pin" class="text-xs" />{{ ann.location }}</span>
            </div>
            <div v-if="ann.price" class="mt-3 pt-3 border-t border-white/[0.05] text-white font-bold text-sm">
              {{ ann.price }}€
              <span v-if="ann.price_type" class="text-white/30 font-normal text-xs ml-1">/ {{ ann.price_type }}</span>
            </div>
          </article>
        </div>
      </section>

    </div>
  </div>
</template>

<script setup>
const route = useRoute()
const supabase = useSupabaseClient()
const user = useSupabaseUser()

const profile = ref(null)
const stats = ref({ avg_rating: 0, review_count: 0 })
const reviews = ref([])
const announcements = ref([])
const myReview = ref(null)
const pending = ref(true)

const reviewForm = ref({ rating: 0, comment: '' })
const hoverRating = ref(0)
const reviewSaving = ref(false)
const reviewError = ref('')
const reviewSuccess = ref(false)

const ratingLabels = ['', 'Mauvais', 'Passable', 'Correct', 'Très bien', 'Excellent']

const displayName = computed(() => {
  if (!profile.value) return ''
  return profile.value.stage_name
    || `${profile.value.first_name ?? ''} ${profile.value.last_name ?? ''}`.trim()
    || 'Profil'
})

function formatDate(d) {
  if (!d) return ''
  return new Date(d).toLocaleDateString('fr-FR', { day: 'numeric', month: 'long', year: 'numeric' })
}

async function submitReview() {
  if (!reviewForm.value.rating) return
  reviewSaving.value = true
  reviewError.value = ''
  reviewSuccess.value = false

  const { error } = await supabase.rpc('submit_review', {
    p_reviewed_id: route.params.id,
    p_rating: reviewForm.value.rating,
    p_comment: reviewForm.value.comment || null
  })

  if (error) {
    reviewError.value = error.message
  } else {
    const [reviewsRes, statsRes] = await Promise.all([
      supabase.rpc('get_profile_reviews', { p_profile_id: route.params.id }),
      supabase.rpc('get_profile_stats', { p_profile_id: route.params.id })
    ])
    if (reviewsRes.data) reviews.value = reviewsRes.data
    if (statsRes.data?.[0]) stats.value = statsRes.data[0]
    myReview.value = { rating: reviewForm.value.rating, comment: reviewForm.value.comment }
    reviewSuccess.value = true
    setTimeout(() => { reviewSuccess.value = false }, 3000)
  }
  reviewSaving.value = false
}

onMounted(async () => {
  const id = route.params.id
  const baseQueries = [
    supabase.rpc('get_public_profile', { p_profile_id: id }),
    supabase.rpc('get_profile_reviews', { p_profile_id: id }),
    supabase.rpc('get_profile_stats', { p_profile_id: id }),
    supabase.rpc('get_user_announcements', { p_profile_id: id })
  ]
  if (user.value) baseQueries.push(supabase.rpc('get_my_review_for', { p_reviewed_id: id }))

  const results = await Promise.all(baseQueries)
  const [profileRes, reviewsRes, statsRes, annRes, myReviewRes] = results

  if (profileRes.data?.[0]) profile.value = profileRes.data[0]
  if (reviewsRes.data) reviews.value = reviewsRes.data
  if (statsRes.data?.[0]) stats.value = statsRes.data[0]
  if (annRes.data) announcements.value = annRes.data
  if (myReviewRes?.data?.[0]) {
    myReview.value = myReviewRes.data[0]
    reviewForm.value = { rating: myReview.value.rating, comment: myReview.value.comment || '' }
  }

  pending.value = false
})
</script>

<style scoped>
@reference "~/assets/css/main.css";

.section-label {
  @apply text-xs font-bold uppercase tracking-widest text-white/30 mb-4;
}
.tag {
  @apply flex items-center gap-1 text-xs text-white/40 bg-white/[0.04] border border-white/[0.07] rounded-full px-2.5 py-1;
}
</style>

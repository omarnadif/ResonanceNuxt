<template>
  <div class="min-h-screen bg-[#080808] pt-32 pb-24 overflow-hidden">

    <div class="absolute top-0 right-1/4 w-[500px] h-[500px] bg-[#F75C03]/5 blur-[140px] rounded-full pointer-events-none" />
    <div class="absolute top-60 left-1/4 w-[400px] h-[400px] bg-[#F75C03]/3 blur-[120px] rounded-full pointer-events-none" />

    <!-- Loader -->
    <div v-if="pending" class="flex justify-center items-center min-h-[50vh]">
      <div class="flex flex-col items-center gap-4">
        <div class="w-12 h-12 border-2 border-white/10 border-t-[#F75C03] rounded-full animate-spin" />
        <p class="text-white/40 text-sm">Chargement du profil…</p>
      </div>
    </div>

    <div v-else class="relative max-w-5xl mx-auto px-6">

      <!-- ─── HEADER ──────────────────────────────────────────── -->
      <div class="flex flex-col md:flex-row gap-8 items-start md:items-end">
        <div class="relative shrink-0 group cursor-pointer" @click="openEdit">
          <img
            v-if="profile?.avatar_url"
            :src="profile.avatar_url"
            :alt="displayName"
            class="w-28 h-28 md:w-36 md:h-36 rounded-3xl object-cover border-2 border-white/10 shadow-2xl transition-opacity group-hover:opacity-70"
          >
          <div
            v-else
            class="w-28 h-28 md:w-36 md:h-36 rounded-3xl bg-[#1A1A1A] border-2 border-white/10 flex items-center justify-center shadow-2xl transition-opacity group-hover:opacity-70"
          >
            <UIcon name="i-heroicons-user" class="text-white/20 text-6xl" />
          </div>
          <div class="absolute inset-0 rounded-3xl flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity bg-black/40">
            <UIcon name="i-heroicons-camera" class="text-white text-2xl" />
          </div>
          <div
            v-if="subscription?.plan_type"
            class="absolute -bottom-2 -right-2 text-xs font-bold uppercase px-2.5 py-1 rounded-full border pointer-events-none"
            :class="planBadgeClass"
          >
            {{ subscription.plan_type }}
          </div>
        </div>

        <div class="flex-1 min-w-0">
          <h1 class="text-3xl md:text-5xl font-black tracking-tighter text-white uppercase leading-none">
            {{ displayName }}
          </h1>
          <p v-if="profile?.stage_name && profile?.first_name" class="text-white/40 text-base mt-1.5 font-medium">
            {{ profile.first_name }} {{ profile.last_name }}
          </p>
          <div v-if="profile?.city" class="flex items-center gap-1.5 mt-2">
            <UIcon name="i-heroicons-map-pin-mini" class="text-white/40 text-sm shrink-0" />
            <span class="text-white/40 text-sm">{{ profile.city }}</span>
          </div>
          <p v-if="profile?.bio" class="mt-4 text-white/60 max-w-lg leading-relaxed text-sm md:text-base">
            {{ profile.bio }}
          </p>
          <p v-if="profile?.created_date" class="mt-3 text-white/30 text-xs">
            Membre depuis {{ formatDate(profile.created_date) }}
          </p>
        </div>

        <UButton
          icon="i-heroicons-pencil-square"
          label="Modifier le profil"
          color="primary"
          size="md"
          class="shrink-0 rounded-full font-semibold px-5"
          @click="openEdit"
        />
      </div>

      <!-- ─── ROLES ───────────────────────────────────────────── -->
      <section v-if="roles.length" class="mt-12">
        <h2 class="section-label">Rôles & Compétences</h2>
        <div class="flex flex-wrap gap-2 mt-3">
          <div
            v-for="role in roles"
            :key="role.id"
            class="flex items-center gap-2 bg-white/5 border border-white/10 rounded-full px-4 py-1.5"
          >
            <UIcon name="i-heroicons-musical-note" class="text-[#F75C03] text-xs shrink-0" />
            <span class="text-white text-sm font-semibold">{{ role.role_name }}</span>
            <span v-if="role.experience_level" class="text-white/40 text-xs border-l border-white/10 pl-2">
              {{ role.experience_level }}
            </span>
          </div>
        </div>
      </section>

      <!-- ─── SUBSCRIPTION ───────────────────────────────────── -->
      <section v-if="subscription" class="mt-12">
        <h2 class="section-label">Abonnement</h2>
        <div class="mt-3 inline-flex items-center gap-6 bg-white/5 border border-white/10 rounded-2xl px-6 py-4">
          <div>
            <p class="text-white/40 text-xs uppercase tracking-widest mb-0.5">Plan</p>
            <p class="text-white font-bold text-lg uppercase">{{ subscription.plan_type }}</p>
          </div>
          <div class="w-px h-8 bg-white/10" />
          <div>
            <p class="text-white/40 text-xs uppercase tracking-widest mb-0.5">Statut</p>
            <div class="flex items-center gap-1.5">
              <span class="w-1.5 h-1.5 rounded-full" :class="subscription.status_subscriptions === 'active' ? 'bg-green-400' : 'bg-red-400'" />
              <p class="text-white font-semibold text-sm">
                {{ subscription.status_subscriptions === 'active' ? 'Actif' : 'Inactif' }}
              </p>
            </div>
          </div>
          <template v-if="subscription.expires_date">
            <div class="w-px h-8 bg-white/10" />
            <div>
              <p class="text-white/40 text-xs uppercase tracking-widest mb-0.5">Expire le</p>
              <p class="text-white font-semibold text-sm">{{ formatDate(subscription.expires_date) }}</p>
            </div>
          </template>
        </div>
      </section>

      <!-- ─── AVIS REÇUS ──────────────────────────────────────── -->
      <section class="mt-12">
        <div class="flex items-center justify-between mb-4">
          <h2 class="section-label mb-0">
            Avis reçus
            <span v-if="profileStats.review_count > 0" class="ml-2 text-white/30 font-normal normal-case tracking-normal text-sm">({{ profileStats.review_count }})</span>
          </h2>
          <!-- Moyenne -->
          <div v-if="profileStats.review_count > 0" class="flex items-center gap-2">
            <div class="flex items-center gap-0.5">
              <UIcon
                v-for="s in 5" :key="s"
                :name="s <= Math.round(Number(profileStats.avg_rating)) ? 'i-heroicons-star-20-solid' : 'i-heroicons-star'"
                class="text-sm"
                :class="s <= Math.round(Number(profileStats.avg_rating)) ? 'text-[#F75C03]' : 'text-white/20'"
              />
            </div>
            <span class="text-white font-bold text-sm">{{ profileStats.avg_rating }}</span>
          </div>
        </div>

        <div v-if="!receivedReviews.length" class="py-10 flex flex-col items-center justify-center border border-dashed border-white/[0.07] rounded-2xl">
          <UIcon name="i-heroicons-star" class="text-white/10 mb-2" style="font-size: 2rem;" />
          <p class="text-white/20 text-sm">Aucun avis reçu pour le moment</p>
        </div>
        <div v-else class="grid grid-cols-1 md:grid-cols-2 gap-3">
          <div
            v-for="r in receivedReviews"
            :key="r.id"
            class="bg-[#0F0F0F] border border-white/[0.07] rounded-2xl p-4 hover:border-white/10 transition-colors"
          >
            <div class="flex items-center gap-3 mb-3">
              <NuxtLink :to="`/user/${r.reviewer_id}`" class="w-8 h-8 rounded-xl overflow-hidden shrink-0 bg-[#1A1A1A] border border-white/[0.07] flex items-center justify-center hover:border-white/20 transition-colors">
                <img v-if="r.reviewer_avatar_url" :src="r.reviewer_avatar_url" class="w-full h-full object-cover">
                <UIcon v-else name="i-heroicons-user" class="text-white/20 text-xs" />
              </NuxtLink>
              <div class="flex-1 min-w-0">
                <NuxtLink :to="`/user/${r.reviewer_id}`" class="text-white text-sm font-semibold hover:text-[#F75C03] transition-colors">
                  {{ r.reviewer_stage_name || `${r.reviewer_first_name ?? ''} ${r.reviewer_last_name ?? ''}`.trim() || 'Utilisateur' }}
                </NuxtLink>
                <p class="text-white/30 text-xs">{{ formatDate(r.created_at) }}</p>
              </div>
              <div class="flex items-center gap-0.5 shrink-0">
                <UIcon
                  v-for="s in 5" :key="s"
                  :name="s <= r.rating ? 'i-heroicons-star-20-solid' : 'i-heroicons-star'"
                  class="text-xs"
                  :class="s <= r.rating ? 'text-[#F75C03]' : 'text-white/15'"
                />
              </div>
            </div>
            <p v-if="r.comment" class="text-white/50 text-sm leading-relaxed">{{ r.comment }}</p>
            <p v-else class="text-white/20 text-xs italic">Sans commentaire</p>
          </div>
        </div>
      </section>

      <!-- ─── DEMANDES REÇUES ────────────────────────────────── -->
      <section v-if="interests.length" class="mt-12">
        <h2 class="section-label">
          Demandes reçues
          <span class="ml-2 text-[#F75C03] font-bold">
            {{ interests.filter(i => i.status === 'pending').length || '' }}
          </span>
        </h2>
        <div class="flex flex-col gap-3 mt-3">
          <div
            v-for="req in interests"
            :key="req.id"
            class="flex items-center gap-4 bg-[#0F0F0F] border rounded-2xl px-5 py-4 transition-colors"
            :class="req.status === 'pending' ? 'border-[#F75C03]/20' : 'border-white/[0.07]'"
          >
            <!-- Avatar -->
            <div class="w-9 h-9 rounded-xl overflow-hidden shrink-0 bg-[#1A1A1A] border border-white/10 flex items-center justify-center">
              <img v-if="req.sender_avatar_url" :src="req.sender_avatar_url" class="w-full h-full object-cover">
              <UIcon v-else name="i-heroicons-user" class="text-white/20 text-base" />
            </div>

            <!-- Infos -->
            <div class="flex-1 min-w-0">
              <p class="text-white font-semibold text-sm truncate">
                {{ req.sender_stage_name || `${req.sender_first_name ?? ''} ${req.sender_last_name ?? ''}`.trim() || 'Utilisateur' }}
              </p>
              <p class="text-white/30 text-xs truncate">
                Intéressé par : <span class="text-white/50">{{ req.announcement_title }}</span>
              </p>
            </div>

            <!-- Status / Actions -->
            <div class="shrink-0 flex items-center gap-2">
              <span
                v-if="req.status === 'accepted'"
                class="text-xs font-semibold text-[#F75C03] bg-[#F75C03]/10 border border-[#F75C03]/20 rounded-full px-2.5 py-1"
              >Accepté</span>
              <span
                v-else-if="req.status === 'rejected'"
                class="text-xs font-semibold text-white/30 bg-white/5 border border-white/10 rounded-full px-2.5 py-1"
              >Refusé</span>
              <template v-else>
                <button
                  class="text-xs font-semibold text-white/40 border border-white/10 rounded-lg px-3 py-1.5 hover:border-red-400/30 hover:text-red-400 transition-colors"
                  @click="rejectInterest(req.id)"
                >
                  Refuser
                </button>
                <button
                  class="text-xs font-semibold text-[#F75C03] bg-[#F75C03]/10 border border-[#F75C03]/20 rounded-lg px-3 py-1.5 hover:bg-[#F75C03]/20 transition-colors"
                  @click="acceptInterest(req.id)"
                >
                  Accepter
                </button>
              </template>
            </div>
          </div>
        </div>
      </section>

      <!-- ─── ANNONCES ───────────────────────────────────────── -->
      <section class="mt-14">
        <div class="flex items-center justify-between mb-5">
          <h2 class="section-label mb-0">
            Annonces
            <span v-if="announcements.length" class="ml-2 text-white/30 font-normal text-sm normal-case tracking-normal">
              ({{ announcements.length }})
            </span>
          </h2>
          <UButton
            icon="i-heroicons-plus"
            label="Nouvelle annonce"
            size="sm"
            color="primary"
            class="rounded-full font-semibold"
            @click="openNewAnn"
          />
        </div>

        <!-- Empty state -->
        <div
          v-if="!announcements.length"
          class="flex flex-col items-center justify-center py-20 border border-dashed border-white/10 rounded-3xl"
        >
          <UIcon name="i-heroicons-megaphone" class="text-white/15 mb-4" style="font-size: 3.5rem;" />
          <p class="text-white/40 text-sm">Aucune annonce pour le moment</p>
          <UButton label="Créer ma première annonce" variant="ghost" color="primary" size="sm" class="mt-4" @click="openNewAnn" />
        </div>

        <!-- Cards -->
        <div v-else class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div
            v-for="ann in announcements"
            :key="ann.id"
            class="group bg-white/5 border border-white/10 rounded-3xl p-6 hover:bg-white/[0.07] hover:border-white/20 transition-all"
          >
            <!-- Top row : statut + type + actions -->
            <div class="flex items-start justify-between gap-3 mb-4">
              <div class="flex items-center gap-2">
                <span
                  class="w-2 h-2 rounded-full shrink-0 mt-0.5"
                  :class="ann.status_announcements === 'published' ? 'bg-green-400' : 'bg-white/20'"
                />
                <span class="text-white/40 text-xs">
                  {{ ann.status_announcements === 'published' ? 'Publié' : 'Brouillon' }}
                </span>
              </div>
              <div class="flex items-center gap-1.5 ml-auto">
                <span v-if="ann.type" class="text-xs text-white/40 bg-white/5 border border-white/10 rounded-full px-2.5 py-0.5">
                  {{ ann.type }}
                </span>
                <!-- Actions (visibles au hover) -->
                <div class="flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                  <button
                    class="p-1.5 rounded-lg text-white/40 hover:text-white hover:bg-white/10 transition-colors"
                    title="Modifier"
                    @click="openEditAnn(ann)"
                  >
                    <UIcon name="i-heroicons-pencil" class="text-sm" />
                  </button>
                  <button
                    class="p-1.5 rounded-lg text-white/40 hover:text-red-400 hover:bg-red-400/10 transition-colors"
                    title="Supprimer"
                    @click="confirmDelete(ann.id)"
                  >
                    <UIcon name="i-heroicons-trash" class="text-sm" />
                  </button>
                </div>
              </div>
            </div>

            <h3 class="text-white font-bold text-lg leading-snug line-clamp-2">
              {{ ann.title || 'Sans titre' }}
            </h3>
            <p v-if="ann.description" class="mt-2 text-white/50 text-sm leading-relaxed line-clamp-3">
              {{ ann.description }}
            </p>

            <div class="mt-4 flex flex-wrap items-center gap-x-4 gap-y-1.5 text-xs text-white/30">
              <span v-if="ann.instrument" class="flex items-center gap-1">
                <UIcon name="i-heroicons-musical-note" class="text-xs" />{{ ann.instrument }}
              </span>
              <span v-if="ann.genre" class="flex items-center gap-1">
                <UIcon name="i-heroicons-tag" class="text-xs" />{{ ann.genre }}
              </span>
              <span v-if="ann.location" class="flex items-center gap-1">
                <UIcon name="i-heroicons-map-pin" class="text-xs" />{{ ann.location }}
              </span>
            </div>

            <div class="mt-4 pt-4 border-t border-white/5 flex items-center justify-between">
              <div v-if="ann.price" class="text-white font-bold">
                {{ ann.price }}€
                <span v-if="ann.price_type" class="text-white/30 font-normal text-xs ml-1">/ {{ ann.price_type }}</span>
              </div>
              <div v-else class="text-white/20 text-xs">Prix non défini</div>
              <span class="text-white/25 text-xs">{{ formatDate(ann.created_date) }}</span>
            </div>
          </div>
        </div>
      </section>
    </div>

    <!-- ─── MODAL SUPPRESSION ──────────────────────────────── -->
    <UModal v-model:open="deleteOpen" :ui="{ content: 'bg-[#0F0F0F] ring-1 ring-white/10 divide-y-0' }">
      <template #content>
        <div class="p-6 flex flex-col gap-5">
          <div class="flex items-center gap-3">
            <div class="w-10 h-10 rounded-xl bg-red-500/10 flex items-center justify-center shrink-0">
              <UIcon name="i-heroicons-trash" class="text-red-400" />
            </div>
            <div>
              <h3 class="text-white font-bold">Supprimer l'annonce</h3>
              <p class="text-white/40 text-sm">Cette action est irréversible.</p>
            </div>
          </div>
          <div class="flex gap-3">
            <UButton label="Annuler" variant="ghost" color="neutral" block @click="deleteOpen = false" />
            <UButton label="Supprimer" color="error" block :loading="deleting" @click="executeDelete" />
          </div>
        </div>
      </template>
    </UModal>

    <!-- ─── SLIDEOVER PROFIL ───────────────────────────────── -->
    <USlideover v-model:open="editOpen" side="right" :ui="{ width: 'max-w-md' }">
      <template #content>
        <div class="flex flex-col h-full bg-[#0F0F0F] overflow-y-auto">
          <div class="flex items-center justify-between px-6 py-5 border-b border-white/10 shrink-0">
            <h2 class="text-white font-bold text-lg">Modifier le profil</h2>
            <UButton icon="i-heroicons-x-mark" variant="ghost" color="neutral" size="sm" @click="editOpen = false" />
          </div>

          <div class="flex-1 px-6 py-6 flex flex-col gap-6">
            <!-- Avatar -->
            <div class="flex flex-col items-center gap-3">
              <div class="relative group cursor-pointer" @click="triggerFileInput">
                <img
                  v-if="avatarPreview || profile?.avatar_url"
                  :src="avatarPreview || profile.avatar_url"
                  class="w-24 h-24 rounded-2xl object-cover border-2 border-white/10 transition-opacity group-hover:opacity-70"
                >
                <div
                  v-else
                  class="w-24 h-24 rounded-2xl bg-[#1A1A1A] border-2 border-white/10 flex items-center justify-center transition-opacity group-hover:opacity-70"
                >
                  <UIcon name="i-heroicons-user" class="text-white/20 text-4xl" />
                </div>
                <div class="absolute inset-0 rounded-2xl flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity bg-black/40">
                  <UIcon name="i-heroicons-camera" class="text-white text-xl" />
                </div>
              </div>
              <input ref="fileInput" type="file" accept="image/*" class="hidden" @change="onFileChange">
              <button class="text-[#F75C03] text-xs font-semibold hover:text-[#F75C03]/70 transition-colors" @click="triggerFileInput">
                Changer la photo
              </button>
              <p v-if="uploadProgress" class="text-white/40 text-xs">{{ uploadProgress }}</p>
            </div>

            <div class="w-full h-px bg-white/10" />

            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="edit-label">Prénom</label>
                <input v-model="form.first_name" type="text" placeholder="Jean" class="edit-input">
              </div>
              <div>
                <label class="edit-label">Nom</label>
                <input v-model="form.last_name" type="text" placeholder="Dupont" class="edit-input">
              </div>
            </div>

            <div>
              <label class="edit-label">Pseudo de scène</label>
              <input v-model="form.stage_name" type="text" placeholder="DJ Shadow…" class="edit-input">
            </div>

            <div>
              <label class="edit-label">Ville</label>
              <input v-model="form.city" type="text" placeholder="Paris, Lyon…" class="edit-input">
            </div>

            <div>
              <label class="edit-label">Bio</label>
              <textarea v-model="form.bio" rows="4" placeholder="Parle de toi…" class="edit-input resize-none" />
              <p class="text-white/25 text-xs mt-1 text-right">{{ form.bio?.length ?? 0 }} / 300</p>
            </div>

            <div v-if="saveError" class="flex items-center gap-2 bg-red-500/10 border border-red-500/20 text-red-400 text-sm rounded-xl px-4 py-3">
              <UIcon name="i-heroicons-exclamation-circle" class="shrink-0" />{{ saveError }}
            </div>
            <div v-if="saveSuccess" class="flex items-center gap-2 bg-[#F75C03]/10 border border-[#F75C03]/20 text-[#F75C03] text-sm rounded-xl px-4 py-3">
              <UIcon name="i-heroicons-check-circle" class="shrink-0" />Profil mis à jour !
            </div>
          </div>

          <div class="px-6 py-5 border-t border-white/10 flex gap-3 shrink-0">
            <UButton label="Annuler" variant="ghost" color="neutral" block @click="editOpen = false" />
            <UButton label="Enregistrer" color="primary" block :loading="saving" @click="saveProfile" />
          </div>
        </div>
      </template>
    </USlideover>

    <!-- ─── SLIDEOVER ANNONCE ──────────────────────────────── -->
    <USlideover v-model:open="annOpen" side="right" :ui="{ width: 'max-w-md' }">
      <template #content>
        <div class="flex flex-col h-full bg-[#0F0F0F] overflow-y-auto">
          <div class="flex items-center justify-between px-6 py-5 border-b border-white/10 shrink-0">
            <h2 class="text-white font-bold text-lg">
              {{ annEditId ? 'Modifier l\'annonce' : 'Nouvelle annonce' }}
            </h2>
            <UButton icon="i-heroicons-x-mark" variant="ghost" color="neutral" size="sm" @click="annOpen = false" />
          </div>

          <div class="flex-1 px-6 py-6 flex flex-col gap-5 overflow-y-auto">

            <!-- Titre -->
            <div>
              <label class="edit-label">Titre *</label>
              <input v-model="annForm.title" type="text" placeholder="Recherche bassiste pour groupe rock…" class="edit-input">
            </div>

            <!-- Description -->
            <div>
              <label class="edit-label">Description</label>
              <textarea v-model="annForm.description" rows="4" placeholder="Décris ta recherche, ton style, tes attentes…" class="edit-input resize-none" />
            </div>

            <!-- Type -->
            <div>
              <label class="edit-label">Type d'annonce</label>
              <select v-model="annForm.type" class="edit-input">
                <option value="" class="bg-[#0F0F0F] text-white/50">Choisir un type…</option>
                <option value="Musicien cherche groupe" class="bg-[#0F0F0F] text-white">Musicien cherche groupe</option>
                <option value="Groupe cherche musicien" class="bg-[#0F0F0F] text-white">Groupe cherche musicien</option>
                <option value="Cours de musique" class="bg-[#0F0F0F] text-white">Cours de musique</option>
                <option value="Collaboration studio" class="bg-[#0F0F0F] text-white">Collaboration studio</option>
                <option value="Concert / Événement" class="bg-[#0F0F0F] text-white">Concert / Événement</option>
                <option value="Autre" class="bg-[#0F0F0F] text-white">Autre</option>
              </select>
            </div>

            <!-- Instrument + Genre -->
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="edit-label">Instrument</label>
                <input v-model="annForm.instrument" type="text" placeholder="Guitare, Batterie…" class="edit-input">
              </div>
              <div>
                <label class="edit-label">Genre musical</label>
                <input v-model="annForm.genre" type="text" placeholder="Rock, Jazz, Hip-hop…" class="edit-input">
              </div>
            </div>

            <!-- Localisation -->
            <div>
              <label class="edit-label">Localisation</label>
              <input v-model="annForm.location" type="text" placeholder="Paris, En ligne…" class="edit-input">
            </div>

            <!-- Prix -->
            <div class="grid grid-cols-2 gap-3">
              <div>
                <label class="edit-label">Prix (€)</label>
                <input v-model="annForm.price" type="number" min="0" placeholder="0" class="edit-input">
              </div>
              <div>
                <label class="edit-label">Par</label>
                <select v-model="annForm.price_type" class="edit-input">
                  <option value="" class="bg-[#0F0F0F] text-white/50">Sans tarif</option>
                  <option value="heure" class="bg-[#0F0F0F] text-white">Heure</option>
                  <option value="séance" class="bg-[#0F0F0F] text-white">Séance</option>
                  <option value="projet" class="bg-[#0F0F0F] text-white">Projet</option>
                  <option value="concert" class="bg-[#0F0F0F] text-white">Concert</option>
                  <option value="mois" class="bg-[#0F0F0F] text-white">Mois</option>
                </select>
              </div>
            </div>

            <!-- Statut -->
            <div>
              <label class="edit-label">Statut</label>
              <div class="flex bg-white/5 rounded-xl p-1 gap-1">
                <button
                  class="flex-1 py-2 text-sm font-semibold rounded-lg transition-all"
                  :class="annForm.status === 'draft' ? 'bg-white/10 text-white' : 'text-white/40 hover:text-white'"
                  @click="annForm.status = 'draft'"
                >
                  Brouillon
                </button>
                <button
                  class="flex-1 py-2 text-sm font-semibold rounded-lg transition-all"
                  :class="annForm.status === 'published' ? 'bg-[#F75C03]/20 text-[#F75C03]' : 'text-white/40 hover:text-white'"
                  @click="annForm.status = 'published'"
                >
                  Publier
                </button>
              </div>
            </div>

            <div v-if="annError" class="flex items-center gap-2 bg-red-500/10 border border-red-500/20 text-red-400 text-sm rounded-xl px-4 py-3">
              <UIcon name="i-heroicons-exclamation-circle" class="shrink-0" />{{ annError }}
            </div>
            <div v-if="annSuccess" class="flex items-center gap-2 bg-[#F75C03]/10 border border-[#F75C03]/20 text-[#F75C03] text-sm rounded-xl px-4 py-3">
              <UIcon name="i-heroicons-check-circle" class="shrink-0" />
              {{ annEditId ? 'Annonce mise à jour !' : 'Annonce créée !' }}
            </div>
          </div>

          <div class="px-6 py-5 border-t border-white/10 flex gap-3 shrink-0">
            <UButton label="Annuler" variant="ghost" color="neutral" block @click="annOpen = false" />
            <UButton :label="annEditId ? 'Mettre à jour' : 'Créer'" color="primary" block :loading="annSaving" @click="saveAnn" />
          </div>
        </div>
      </template>
    </USlideover>
  </div>
</template>

<script setup>
definePageMeta({ middleware: 'auth' })

const user = useSupabaseUser()
const supabase = useSupabaseClient()

const profile = ref(null)
const roles = ref([])
const announcements = ref([])
const subscription = ref(null)
const interests = ref([])
const receivedReviews = ref([])
const profileStats = ref({ avg_rating: 0, review_count: 0 })
const pending = ref(true)

// ── Profil edit ──────────────────────────────────────────────
const editOpen = ref(false)
const saving = ref(false)
const saveError = ref('')
const saveSuccess = ref(false)
const fileInput = ref(null)
const avatarPreview = ref(null)
const avatarFile = ref(null)
const uploadProgress = ref('')
const form = ref({ first_name: '', last_name: '', stage_name: '', bio: '', city: '' })

// ── Annonce CRUD ─────────────────────────────────────────────
const annOpen = ref(false)
const annSaving = ref(false)
const annError = ref('')
const annSuccess = ref(false)
const annEditId = ref(null)
const annForm = ref({ title: '', description: '', type: '', instrument: '', genre: '', location: '', price: '', price_type: '', status: 'draft' })

// ── Suppression ───────────────────────────────────────────────
const deleteOpen = ref(false)
const deleteTargetId = ref(null)
const deleting = ref(false)

// ── Computed ─────────────────────────────────────────────────
const displayName = computed(() => {
  if (!profile.value) return ''
  return profile.value.stage_name
    || `${profile.value.first_name ?? ''} ${profile.value.last_name ?? ''}`.trim()
    || 'Mon Profil'
})

const planBadgeClass = computed(() => {
  const plan = subscription.value?.plan_type?.toLowerCase()
  if (plan === 'pro') return 'bg-[#F75C03]/10 border-[#F75C03]/30 text-[#F75C03]'
  if (plan === 'premium') return 'bg-indigo-400/10 border-indigo-400/30 text-indigo-400'
  return 'bg-white/10 border-white/20 text-white/60'
})

function formatDate(dateStr) {
  if (!dateStr) return ''
  return new Date(dateStr).toLocaleDateString('fr-FR', { year: 'numeric', month: 'long', day: 'numeric' })
}

// ── Profil helpers ────────────────────────────────────────────
function openEdit() {
  form.value = {
    first_name: profile.value?.first_name ?? '',
    last_name: profile.value?.last_name ?? '',
    stage_name: profile.value?.stage_name ?? '',
    bio: profile.value?.bio ?? '',
    city: profile.value?.city ?? ''
  }
  avatarPreview.value = null
  avatarFile.value = null
  saveError.value = ''
  saveSuccess.value = false
  editOpen.value = true
}

function triggerFileInput() { fileInput.value?.click() }

function onFileChange(e) {
  const file = e.target.files?.[0]
  if (!file) return
  avatarFile.value = file
  avatarPreview.value = URL.createObjectURL(file)
}

async function saveProfile() {
  saving.value = true
  saveError.value = ''
  saveSuccess.value = false
  try {
    const uid = user.value.id
    let avatar_url = profile.value?.avatar_url ?? null

    if (avatarFile.value) {
      uploadProgress.value = 'Envoi de la photo…'
      const ext = avatarFile.value.name.split('.').pop()
      const path = `${uid}/avatar.${ext}`
      const { error: uploadErr } = await supabase.storage.from('avatars').upload(path, avatarFile.value, { upsert: true })
      if (uploadErr) throw new Error('Échec upload : ' + uploadErr.message)
      const { data: urlData } = supabase.storage.from('avatars').getPublicUrl(path)
      avatar_url = urlData.publicUrl
      uploadProgress.value = ''
    }

    const { error: upsertErr } = await supabase.rpc('upsert_profile', {
      p_first_name: form.value.first_name || null,
      p_last_name: form.value.last_name || null,
      p_stage_name: form.value.stage_name || null,
      p_bio: form.value.bio || null,
      p_city: form.value.city || null,
      p_avatar_url: avatar_url
    })
    if (upsertErr) throw new Error(upsertErr.message)

    profile.value = { ...profile.value, ...form.value, avatar_url }
    saveSuccess.value = true
    setTimeout(() => { editOpen.value = false; saveSuccess.value = false }, 1200)
  } catch (err) {
    saveError.value = err.message
  } finally {
    saving.value = false
  }
}

// ── Intérêts helpers ──────────────────────────────────────────
async function acceptInterest(interestId) {
  const { data: convId, error } = await supabase.rpc('accept_interest', { p_interest_id: interestId })
  if (!error) {
    const idx = interests.value.findIndex(i => i.id === interestId)
    if (idx !== -1) interests.value[idx] = { ...interests.value[idx], status: 'accepted' }
    await navigateTo(`/conversations?id=${convId}`)
  }
}

async function rejectInterest(interestId) {
  const { error } = await supabase.rpc('reject_interest', { p_interest_id: interestId })
  if (!error) {
    const idx = interests.value.findIndex(i => i.id === interestId)
    if (idx !== -1) interests.value[idx] = { ...interests.value[idx], status: 'rejected' }
  }
}

// ── Annonce helpers ───────────────────────────────────────────
function resetAnnForm() {
  annForm.value = { title: '', description: '', type: '', instrument: '', genre: '', location: '', price: '', price_type: '', status: 'draft' }
  annError.value = ''
  annSuccess.value = false
  annEditId.value = null
}

function openNewAnn() {
  resetAnnForm()
  annOpen.value = true
}

function openEditAnn(ann) {
  annEditId.value = ann.id
  annForm.value = {
    title: ann.title ?? '',
    description: ann.description ?? '',
    type: ann.type ?? '',
    instrument: ann.instrument ?? '',
    genre: ann.genre ?? '',
    location: ann.location ?? '',
    price: ann.price ?? '',
    price_type: ann.price_type ?? '',
    status: ann.status_announcements ?? 'draft'
  }
  annError.value = ''
  annSuccess.value = false
  annOpen.value = true
}

async function saveAnn() {
  if (!annForm.value.title.trim()) {
    annError.value = 'Le titre est obligatoire.'
    return
  }
  annSaving.value = true
  annError.value = ''
  annSuccess.value = false

  try {
    const params = {
      p_title: annForm.value.title || null,
      p_description: annForm.value.description || null,
      p_type: annForm.value.type || null,
      p_instrument: annForm.value.instrument || null,
      p_genre: annForm.value.genre || null,
      p_location: annForm.value.location || null,
      p_price: annForm.value.price ? Number(annForm.value.price) : null,
      p_price_type: annForm.value.price_type || null,
      p_status: annForm.value.status
    }

    if (annEditId.value) {
      // Modification
      const { error } = await supabase.rpc('update_announcement', { p_id: annEditId.value, ...params })
      if (error) throw new Error(error.message)
      const idx = announcements.value.findIndex(a => a.id === annEditId.value)
      if (idx !== -1) {
        announcements.value[idx] = {
          ...announcements.value[idx],
          title: params.p_title,
          description: params.p_description,
          type: params.p_type,
          instrument: params.p_instrument,
          genre: params.p_genre,
          location: params.p_location,
          price: params.p_price,
          price_type: params.p_price_type,
          status_announcements: params.p_status
        }
      }
    } else {
      // Création
      const { data: newId, error } = await supabase.rpc('create_announcement', params)
      if (error) throw new Error(error.message)
      announcements.value.unshift({
        id: newId,
        id_profile: user.value.id,
        ...params,
        title: params.p_title,
        description: params.p_description,
        type: params.p_type,
        instrument: params.p_instrument,
        genre: params.p_genre,
        location: params.p_location,
        price: params.p_price,
        price_type: params.p_price_type,
        status_announcements: params.p_status,
        created_date: new Date().toISOString().split('T')[0]
      })
    }

    annSuccess.value = true
    setTimeout(() => { annOpen.value = false; annSuccess.value = false }, 1200)
  } catch (err) {
    annError.value = err.message
  } finally {
    annSaving.value = false
  }
}

function confirmDelete(id) {
  deleteTargetId.value = id
  deleteOpen.value = true
}

async function executeDelete() {
  deleting.value = true
  try {
    const { error } = await supabase.rpc('delete_announcement', { p_id: deleteTargetId.value })
    if (error) throw new Error(error.message)
    announcements.value = announcements.value.filter(a => a.id !== deleteTargetId.value)
    deleteOpen.value = false
  } catch (err) {
    console.error(err)
  } finally {
    deleting.value = false
  }
}

// ── Load ─────────────────────────────────────────────────────
onMounted(async () => {
  const { data: { user: sessionUser } } = await supabase.auth.getUser()
  const uid = sessionUser?.id
  if (!uid) { pending.value = false; return }

  const [profileRes, rolesRes, announcementsRes, subscriptionRes, interestsRes, reviewsRes, statsRes] = await Promise.all([
    supabase.rpc('get_my_profile'),
    supabase.from('roles').select('*').eq('id_profile', uid),
    supabase.rpc('get_my_announcements'),
    supabase.from('subscriptions').select('*').eq('id_profile', uid).single(),
    supabase.rpc('get_my_interests_received'),
    supabase.rpc('get_profile_reviews', { p_profile_id: uid }),
    supabase.rpc('get_profile_stats', { p_profile_id: uid })
  ])

  if (profileRes.data?.[0]) profile.value = profileRes.data[0]
  if (rolesRes.data) roles.value = rolesRes.data
  if (announcementsRes.data) announcements.value = announcementsRes.data
  if (subscriptionRes.data) subscription.value = subscriptionRes.data
  if (interestsRes.data) interests.value = interestsRes.data
  if (reviewsRes.data) receivedReviews.value = reviewsRes.data
  if (statsRes.data?.[0]) profileStats.value = statsRes.data[0]

  pending.value = false
})
</script>

<style scoped>
@reference "~/assets/css/main.css";

.section-label {
  @apply text-xs font-bold uppercase tracking-widest text-white/30 mb-3;
}
.edit-label {
  @apply block text-xs font-semibold text-white/40 uppercase tracking-widest mb-1.5;
}
.edit-input {
  @apply w-full bg-white/5 border border-white/10 rounded-xl px-4 py-2.5 text-white text-sm placeholder-white/20 outline-none focus:border-[#F75C03]/50 focus:bg-white/[0.07] transition-all;
}
</style>

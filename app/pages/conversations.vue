<template>
  <div class="min-h-screen bg-[#080808] pt-16 flex flex-col">

    <!-- Loader initial -->
    <div v-if="pending" class="flex-1 flex items-center justify-center">
      <div class="w-8 h-8 border-2 border-white/10 border-t-[#F75C03] rounded-full animate-spin" />
    </div>

    <!-- Aucune conversation -->
    <div v-else-if="!conversations.length" class="flex-1 flex flex-col items-center justify-center gap-4">
      <div class="w-16 h-16 rounded-2xl bg-[#F75C03]/10 flex items-center justify-center">
        <UIcon name="i-heroicons-chat-bubble-left-right" class="text-[#F75C03] text-2xl" />
      </div>
      <p class="text-white font-bold text-lg">Aucune conversation</p>
      <p class="text-white/40 text-sm text-center max-w-xs leading-relaxed">
        Exprime ton intérêt pour une annonce et attends que l'auteur accepte ta demande.
      </p>
      <NuxtLink
        to="/features"
        class="mt-2 inline-flex items-center gap-2 bg-[#F75C03] text-white font-semibold px-6 py-2.5 rounded-lg hover:bg-[#e05200] transition-colors text-sm"
      >
        Voir les annonces
      </NuxtLink>
    </div>

    <!-- Interface principale -->
    <div v-else class="flex-1 flex overflow-hidden" style="height: calc(100vh - 64px);">

      <!-- ── Sidebar conversations ── -->
      <aside
        class="w-full md:w-80 lg:w-96 shrink-0 border-r border-white/[0.06] flex flex-col"
        :class="activeConvId && isMobile ? 'hidden' : 'flex'"
      >
        <div class="px-5 py-4 border-b border-white/[0.06]">
          <p class="text-[#F75C03] text-xs font-semibold tracking-[0.2em] uppercase">Messages</p>
          <h2 class="text-white font-bold text-lg leading-tight mt-0.5">Conversations</h2>
        </div>

        <div class="flex-1 overflow-y-auto">
          <button
            v-for="conv in conversations"
            :key="conv.id"
            class="w-full flex items-start gap-3 px-5 py-4 border-b border-white/[0.04] hover:bg-white/[0.03] transition-colors text-left"
            :class="activeConvId === conv.id ? 'bg-[#F75C03]/5 border-l-2 border-l-[#F75C03]' : ''"
            @click="openConversation(conv.id)"
          >
            <!-- Avatar -->
            <div class="w-10 h-10 rounded-xl overflow-hidden shrink-0 bg-[#1A1A1A] border border-white/10 flex items-center justify-center">
              <img v-if="conv.other_avatar_url" :src="conv.other_avatar_url" class="w-full h-full object-cover">
              <UIcon v-else name="i-heroicons-user" class="text-white/20 text-base" />
            </div>
            <div class="flex-1 min-w-0">
              <div class="flex items-center justify-between gap-2">
                <p class="text-white font-semibold text-sm truncate">{{ otherName(conv) }}</p>
                <span v-if="conv.last_message_at" class="text-white/25 text-[10px] shrink-0">
                  {{ formatTime(conv.last_message_at) }}
                </span>
              </div>
              <p v-if="conv.announcement_title" class="text-[#F75C03]/60 text-xs truncate mt-0.5">
                {{ conv.announcement_title }}
              </p>
              <p class="text-white/30 text-xs truncate mt-0.5">
                {{ conv.last_message || 'Conversation ouverte' }}
              </p>
            </div>
          </button>
        </div>
      </aside>

      <!-- ── Zone de chat ── -->
      <div
        class="flex-1 flex flex-col min-w-0"
        :class="!activeConvId && isMobile ? 'hidden' : 'flex'"
      >
        <!-- Header chat -->
        <div v-if="activeConv" class="flex items-center gap-3 px-6 py-4 border-b border-white/[0.06] shrink-0">
          <button
            class="md:hidden p-1.5 rounded-lg text-white/40 hover:text-white hover:bg-white/5 transition-colors mr-1"
            @click="activeConvId = null"
          >
            <UIcon name="i-heroicons-arrow-left" class="text-base" />
          </button>
          <div class="w-9 h-9 rounded-xl overflow-hidden shrink-0 bg-[#1A1A1A] border border-white/10 flex items-center justify-center">
            <img v-if="activeConv.other_avatar_url" :src="activeConv.other_avatar_url" class="w-full h-full object-cover">
            <UIcon v-else name="i-heroicons-user" class="text-white/20 text-base" />
          </div>
          <div class="flex-1 min-w-0">
            <p class="text-white font-semibold text-sm">{{ otherName(activeConv) }}</p>
            <p v-if="activeConv.announcement_title" class="text-white/30 text-xs truncate">
              {{ activeConv.announcement_title }}
            </p>
          </div>
        </div>

        <!-- Messages -->
        <div
          v-if="activeConvId"
          ref="messagesEl"
          class="flex-1 overflow-y-auto px-6 py-6 flex flex-col gap-3"
        >
          <div v-if="messagesLoading" class="flex justify-center py-10">
            <div class="w-6 h-6 border-2 border-white/10 border-t-[#F75C03] rounded-full animate-spin" />
          </div>

          <template v-else>
            <div
              v-for="msg in messages"
              :key="msg.id"
              class="flex gap-3"
              :class="msg.sender_id === user.id ? 'flex-row-reverse' : 'flex-row'"
            >
              <!-- Avatar (autre utilisateur seulement) -->
              <div
                v-if="msg.sender_id !== user.id"
                class="w-7 h-7 rounded-lg shrink-0 bg-[#1A1A1A] border border-white/10 overflow-hidden flex items-center justify-center mt-auto"
              >
                <img v-if="msg.sender_avatar_url" :src="msg.sender_avatar_url" class="w-full h-full object-cover">
                <UIcon v-else name="i-heroicons-user" class="text-white/20 text-xs" />
              </div>

              <!-- Bulle -->
              <div
                class="max-w-[70%] px-4 py-2.5 rounded-2xl text-sm leading-relaxed"
                :class="msg.sender_id === user.id
                  ? 'bg-[#F75C03] text-white rounded-br-sm'
                  : 'bg-[#1A1A1A] text-white/80 rounded-bl-sm border border-white/[0.07]'"
              >
                {{ msg.content }}
                <div
                  class="text-[10px] mt-1 opacity-60 text-right"
                >
                  {{ formatTime(msg.created_at) }}
                </div>
              </div>
            </div>

            <div v-if="!messages.length" class="flex flex-col items-center justify-center py-16 text-center">
              <UIcon name="i-heroicons-chat-bubble-left-right" class="text-white/10 mb-3" style="font-size: 2.5rem;" />
              <p class="text-white/30 text-sm">Démarrez la conversation !</p>
            </div>
          </template>
        </div>

        <!-- Placeholder si aucune conv sélectionnée -->
        <div v-else class="flex-1 flex flex-col items-center justify-center gap-3">
          <UIcon name="i-heroicons-chat-bubble-left-right" class="text-white/10" style="font-size: 3rem;" />
          <p class="text-white/20 text-sm">Sélectionne une conversation</p>
        </div>

        <!-- Input message -->
        <div v-if="activeConvId" class="px-6 py-4 border-t border-white/[0.06] shrink-0">
          <form class="flex gap-3" @submit.prevent="sendMessage">
            <input
              v-model="newMessage"
              type="text"
              placeholder="Écris un message…"
              class="flex-1 bg-white/[0.04] border border-white/[0.07] rounded-xl px-4 py-2.5 text-white text-sm placeholder-white/20 outline-none focus:border-[#F75C03]/40 transition-all"
              :disabled="sending"
            >
            <button
              type="submit"
              :disabled="!newMessage.trim() || sending"
              class="shrink-0 w-10 h-10 bg-[#F75C03] text-white rounded-xl flex items-center justify-center hover:bg-[#e05200] transition-colors disabled:opacity-40"
            >
              <UIcon name="i-heroicons-paper-airplane" class="text-sm" />
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
definePageMeta({ middleware: 'auth' })

const supabase = useSupabaseClient()
const user = useSupabaseUser()
const route = useRoute()

const conversations = ref([])
const messages = ref([])
const activeConvId = ref(null)
const pending = ref(true)
const messagesLoading = ref(false)
const newMessage = ref('')
const sending = ref(false)
const messagesEl = ref(null)

const isMobile = ref(false)
let channel = null

const activeConv = computed(() => conversations.value.find(c => c.id === activeConvId.value))

function otherName(conv) {
  return conv?.other_stage_name
    || `${conv?.other_first_name ?? ''} ${conv?.other_last_name ?? ''}`.trim()
    || 'Utilisateur'
}

function formatTime(dateStr) {
  if (!dateStr) return ''
  const d = new Date(dateStr)
  const today = new Date()
  if (d.toDateString() === today.toDateString()) {
    return d.toLocaleTimeString('fr-FR', { hour: '2-digit', minute: '2-digit' })
  }
  return d.toLocaleDateString('fr-FR', { day: 'numeric', month: 'short' })
}

async function openConversation(convId) {
  activeConvId.value = convId
  messagesLoading.value = true
  messages.value = []

  if (channel) supabase.removeChannel(channel)

  const { data } = await supabase.rpc('get_messages', { p_conversation_id: convId })
  if (data) messages.value = data
  messagesLoading.value = false
  scrollToBottom()

  channel = supabase
    .channel(`conv-${convId}`)
    .on('postgres_changes', {
      event: 'INSERT',
      schema: 'public',
      table: 'messages',
      filter: `conversation_id=eq.${convId}`
    }, (payload) => {
      const msg = payload.new
      if (messages.value.find(m => m.id === msg.id)) return
      const conv = activeConv.value
      const isMe = msg.sender_id === user.value?.id
      messages.value.push({
        ...msg,
        sender_stage_name: isMe ? null : conv?.other_stage_name,
        sender_first_name: isMe ? null : conv?.other_first_name,
        sender_last_name: isMe ? null : conv?.other_last_name,
        sender_avatar_url: isMe ? null : conv?.other_avatar_url
      })
      scrollToBottom()
      updateLastMessage(convId, msg.content, msg.created_at)
    })
    .subscribe()
}

async function sendMessage() {
  const content = newMessage.value.trim()
  if (!content || !activeConvId.value) return
  newMessage.value = ''
  sending.value = true

  const tempId = `temp-${Date.now()}`
  messages.value.push({
    id: tempId,
    conversation_id: activeConvId.value,
    sender_id: user.value.id,
    content,
    created_at: new Date().toISOString()
  })
  scrollToBottom()

  const { data: msgId } = await supabase.rpc('send_message', {
    p_conversation_id: activeConvId.value,
    p_content: content
  })

  const idx = messages.value.findIndex(m => m.id === tempId)
  if (idx !== -1 && msgId) messages.value[idx].id = msgId

  updateLastMessage(activeConvId.value, content, new Date().toISOString())
  sending.value = false
}

function updateLastMessage(convId, content, at) {
  const ci = conversations.value.findIndex(c => c.id === convId)
  if (ci !== -1) {
    conversations.value[ci] = { ...conversations.value[ci], last_message: content, last_message_at: at }
  }
}

function scrollToBottom() {
  nextTick(() => {
    if (messagesEl.value) messagesEl.value.scrollTop = messagesEl.value.scrollHeight
  })
}

onMounted(async () => {
  isMobile.value = window.innerWidth < 768

  const { data } = await supabase.rpc('get_my_conversations')
  if (data) conversations.value = data
  pending.value = false

  const qId = route.query.id
  if (qId && conversations.value.find(c => c.id === qId)) {
    await openConversation(qId)
  } else if (conversations.value.length && !isMobile.value) {
    await openConversation(conversations.value[0].id)
  }
})

onUnmounted(() => {
  if (channel) supabase.removeChannel(channel)
})
</script>

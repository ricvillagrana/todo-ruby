<template>
  <div class="show-notification" id="notify">
    <div class="notification" :class="`is-${type}`">
      <button class="delete" @click="close"></button>
      {{ text }}
    </div>
  </div>
</template>

<script>
  export default {
    props: ['type', 'text'],
    methods: {
      close () {
        document.getElementById('notify').className = 'hide-notification'
      }
    }
  }
</script>

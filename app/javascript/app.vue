<template>
  <div>
    <nav class="navbar is-light" v-if="user.id">
      <div class="navbar-brand">
        <span class="navbar-item">
          <h1 calss="title is-8">Todo App</h1>
        </span>
      </div>

      <div id="navbarExampleTransparentExample" class="navbar-menu">
        <div class="navbar-start">
          <a class="navbar-item" href="/">
            My lists
          </a>
        </div>
      </div>
      <div class="navbar-end">
        <div class="navbar-item">
          <user-menu :user="user" :token="token" />
        </div>
      </div>
    </nav>
    <slot></slot>
  </div>
</template>

<script>
import UserMenu from './components/UserMenu'

export default {
  data () {
    return {
    }
  },
  props: ['user', 'token'],
  components: {
    UserMenu
  }
}
</script>

<style scoped>
</style>

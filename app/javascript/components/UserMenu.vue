<template>
  <div class="dropdown is-right is-active" @click="toggleMenu">
    <div class="dropdown-trigger">
      <button class="button is-light" aria-haspopup="true" aria-controls="dropdown-menu6">
        <figure class="mr-10">
          <img 
            :src="avatar !== '' ? avatar : user.image !== null ? user.image : 'https://art.placefull.com/Content/Properties/shared/images/no-profile-image.png'" 
            :alt="user.name" 
            class="is-rounded" />
        </figure>  {{ user.name }}
      </button>
    </div>
    <div class="dropdown-menu" role="menu">
      <div class="dropdown-content" id="dropdown-content" style="display: none;">
         <a href="/user/profile" class="dropdown-item">
            <i class="fa fa-user"></i> Profile
          </a>
          <hr class="dropdown-divider">
          <a @click="logOut" class="dropdown-item">
            <i class="fa fa-sign-out"></i> Log out
          </a>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  export default {
    props: ['user', 'avatar', 'token'],
    methods: {
      logOut: () => {
        axios.delete('/users/sign_out',
        {
          data: {
            authenticity_token: this.token
          }
        }).then(response => {
          window.location = "/"
        })
      },
      toggleMenu: () => {
        const menu = document.getElementById('dropdown-content')
        console.log(menu.style.display)
        menu.style.display = menu.style.display == 'none' ? 'block' : 'none'
      }
    }
  }
</script>

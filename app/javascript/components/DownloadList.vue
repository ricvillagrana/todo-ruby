<template>
  <div class="dropdown is-pulled-right is-right mr-15" :class="{'is-active': shown}">
    <div class="dropdown-trigger">
      <button class="button is-rounded" aria-haspopup="true" aria-controls="dropdown-menu" @click="shown = !shown">
        <span>Export</span>
        <span class="icon is-small">
          <i class="fa fa-caret-down" aria-hidden="true"></i>
        </span>
      </button>
    </div>
    <div class="dropdown-menu" id="dropdown-menu" role="menu">
      <div class="dropdown-content">
        <a target="_blank" :href="`/export/lists.csv`" class="dropdown-item">
          <i class="fa fa-file-o"></i> Export to CSV
        </a>
        <a target="" :href="`/export/lists.pdf`"  class="dropdown-item">
          <i class="fa fa-file-pdf-o"></i> Export to PDF
        </a>
        <hr class="dropdown-divider">
        <a target="_blank" :href="`/export/tasks.csv`"  class="dropdown-item">
          <i class="fa fa-file-o"></i> Export all tasks to CSV
        </a>
        <hr class="dropdown-divider">
        <a target="_blank" @click="sendMail"  class="dropdown-item">
          <i class="fa fa-envelope"></i> Send a email
        </a>
      </div>
    </div>
  </div>
</template>

<script>
  import swal from 'sweetalert2'
  import axios from 'axios'
  
  export default {
    name: 'download-list',
    data() {
      return {
        shown: false
      }
    },
    methods: {
      sendMail: function () {
        swal({ title: 'Enviando...',onOpen: () => swal.showLoading() })
        axios.get('/send_mail')
        .then(({data}) => {
          swal(
            'Email sent',
            `The email has been sent, check your inbox.
            ${data.message}`,
            'success'
          )
        })
        .catch(err => {
          swal({
            type: 'error',
            title: 'Error when sending email.',
            text: `Error: ${err}`
          })
        })
      }
    }
  }
</script>
    
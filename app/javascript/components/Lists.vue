<template>
  <div class="column is-10 is-offset-1">
    <div class="mb-40">
      <span class="title is-3">Your lists</span>
      <a @click="add" class="button is-link is-rounded is-pulled-right"><i class="fa fa-plus"></i> Add new</a>
    </div>
    <div class="lists columns is-4">
      <div v-if="lists.length == 0">No lists yet <a @click="add">add one.</a></div>
      <div class="column is-3" v-for="(list, key) in lists" :key="key">
        <div class="card">
          <div class="card-content">
            <div class="title">
              {{ list.name }}
              <div class="dropdown">
                <div class="dropdown-trigger">
                  <button class="button" aria-haspopup="true" aria-controls="dropdown-menu3">
                    <span class="icon is-small">
                      <i class="fa fa-ellipsis-h fa-no-border" aria-hidden="true"></i>
                    </span>
                  </button>
                </div>
              </div>
            </div>
            <p class="subtitle">
              {{ list.description }}
            </p>
          </div>
          <div class="card-content">
            <div class="tasks-list">
              s
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import swal from 'sweetalert2'
import axios from 'axios'

export default {
  name: 'list',
  data() {
    return {
      lists: []
    }
  },
  components: {},
  beforeMount() {
    this.fetchLists()
  },
  methods: {
    fetchLists: function () {
      const that = this 
      axios.get('/lists')
      .then(result => {
        that.lists = result.data.lists
      })
      .catch(err => {
        swal({
          type: 'error',
          title: 'Failed to retrieve lists',
          text: `Error: ${err}`
        })
      }) 
    },
    add: function () {
      const that = this
      swal.mixin({
        input: 'text',
        confirmButtonText: 'Next &rarr;',
        showCancelButton: true,
        progressSteps: ['1', '2']
      }).queue([
        {
          title: 'List name',
          text: 'The name of the list'
        },
        {
          title: 'Description',
          text: 'A quick description'
        }
      ]).then((result) => {
        let list = null
        if (result.value) {
          list = {
            name: result.value[0],
            description: result.value[1]
          }
        }
        if (list) {
          axios.post('/lists', {
            ...list
          }).then(response => {
            swal({
              title: 'List registered!',
              html: `${result.value[0]} is gonna be awesome.`,
              confirmButtonText: 'Done'
            })
            that.fetchLists()
          })
          .catch(err => {
            console.log(err)
          })
        }
      })
    }
  }
}
  
</script>

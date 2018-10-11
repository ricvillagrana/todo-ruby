<template>
  <div class="column is-10 is-offset-1">
    <div class="mb-40">
      <span class="title is-3">My lists</span>
      <a @click="addList" class="button is-link is-rounded is-pulled-right"><i class="fa fa-plus"></i> Add new</a>
      <download-list />
    </div>
    <div class="lists columns is-4-desktop is-3-tablet is-1-mobile">
      <div v-if="lists.length == 0">No lists yet <a @click="addList">add one.</a></div>
      <div class="column is-3" v-for="(list, key) in lists" :key="key">
        <list :list="list" @shouldFetch="fetchLists" @shouldRemoveList="removeList($event)" />
      </div>
    </div>
  </div>
</template>

<script>
import swal from 'sweetalert2'
import axios from 'axios'
import ListOptions from './ListOptions'
import List from './List'
import DownloadList from './DownloadList'

export default {
  name: 'list-board',
  data() {
    return {
      lists: []
    }
  },
  components: {
    ListOptions, List, DownloadList
  },
  beforeMount() {
    this.fetchLists()
  },
  methods: {
    fetchLists: function () {
      const that = this 
      axios.get('/lists')
      .then(result => {
        let preList = JSON.parse(result.data.lists)
        preList.map(list => list.edit = false)
        preList.map(list => list.tasks.map(task => task.edit = false))
        that.lists = preList
      })
      .catch(err => {
        swal({
          type: 'error',
          title: 'Failed to retrieve lists',
          text: `Error: ${err}`
        })
      }) 
    },
    addList: function () {
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
            that.fetchLists()
          })
          .catch(err => {
            console.log(err)
          })
        }
      })
    },
    removeList: function (list_id) {
      this.lists = this.lists.filter(list => list.id != list_id)
    },
    loading: () => {
      swal({
        title: 'Ejecutando...',
        onOpen: () => {
          swal.showLoading()
        }
      })
    }
  }
}
  
</script>

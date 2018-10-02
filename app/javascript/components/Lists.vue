<template>
  <div class="column is-10 is-offset-1">
    <div class="mb-40">
      <span class="title is-3">My lists</span>
      <a @click="addList" class="button is-link is-rounded is-pulled-right"><i class="fa fa-plus"></i> Add new</a>
    </div>
    <div class="lists columns is-4">
      <div v-if="lists.length == 0">No lists yet <a @click="addList">add one.</a></div>
      <div class="column is-3" v-for="(list, key) in lists" :key="key">
        <div class="card">
          <div class="card-content">
            <div class="title">
              {{ list.name }}
              <list-options :list="list" />
            </div>
            <p class="subtitle">
              {{ list.description }}
            </p>
          </div>
          <div class="card-content">
            <div class="tasks-list" v-for="(task, key) in list.tasks" :key="key">
              <task :task="task" />
            </div>
            <div class="add-task button is-link"><i class="fa fa-plus"></i></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import swal from 'sweetalert2'
import axios from 'axios'
import ListOptions from './ListOptions'
import Task from './Task'

export default {
  name: 'list',
  data() {
    return {
      lists: []
    }
  },
  components: {
    Task, ListOptions
  },
  beforeMount() {
    this.fetchLists()
  },
  methods: {
    fetchLists: function () {
      const that = this 
      axios.get('/lists')
      .then(result => {
        that.lists = JSON.parse(result.data.lists)
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
    }
  }
}
  
</script>

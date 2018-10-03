<template>
  <div class="card">
    <div class="card-content">
      <div class="title">
        {{ list.name }}
        <list-options :list="list" @delete="deleteList" />
      </div>
      <p class="subtitle">
        {{ list.description }}
      </p>
      <div class="tasks-list" v-for="(task, key) in list.tasks" :key="key">
        <task :task="task" @shouldRemoveTask="removeTask($event)" />
      </div>
      <div class="add-task button is-link mt-15" @click="addTask"><i class="fa fa-plus"></i></div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import swal from 'sweetalert2'
  import ListOptions from './ListOptions'
  import Task from './Task'
  
  export default {
    name: 'list',
    props: ['list'],
    components: {
      ListOptions, Task
    },
    methods: {
      addTask: function () {
        const that = this
        swal.mixin({
          input: 'text',
          confirmButtonText: 'Next &rarr;',
          showCancelButton: true,
          progressSteps: ['1']
        }).queue([
          {
            title: 'Task',
            text: `Adding task to ${that.list.name} list`
          },
        ]).then((result) => {
          let task = null
          if (result.value) {
            task = {
              name: result.value[0],
              done: false,
              list_id: that.list.id
            }
          }
          if (task) {
            axios.post('/tasks', {
              ...task
            }).then(response => {
              that.$emit('shouldFetch')
            })
            .catch(err => {
              console.log(err)
            })
          }
        })
      },
      removeTask: function (task_id) {
        this.list.tasks = this.list.tasks.filter(task => task.id != task_id)
      },
      deleteList: function () {
        const that = this
        swal({
          title: `Are you sure you want to delete ${this.list.name}?`,
          text: "You won't be able to revert this; Even all your tasks are going to be deleted!",
          type: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: 'Yes, delete it'
        }).then((result) => {
          if (result.value) {
            axios.delete(`/lists/${this.list.id}`)
            .then(({data}) => {
              that.$emit('shouldRemoveList', that.list.id)
            })
            .catch(err => {
              console.log(err)
              swal({
                type: 'error',
                title: 'Failed to delete task',
                text: `Error: ${err}`
              })
            })
          }
        })
      }
    }
  }
</script>

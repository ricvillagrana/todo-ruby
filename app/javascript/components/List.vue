<template>
  <div class="card">
    <div class="card-content">
      <div class="title">
        {{ list.name }}
        <list-options :list="list" />
      </div>
      <p class="subtitle">
        {{ list.description }}
      </p>
      <div class="tasks-list" v-for="(task, key) in list.tasks" :key="key">
        <task :task="task" />
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
      }
    }
  }
</script>

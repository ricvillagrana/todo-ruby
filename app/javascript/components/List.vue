<template>
  <div class="card">
    <div class="card-content">
      <div class="list-data mb-25" v-if="!list.edit">
        <div class="title">
          <div>
            <list-options :list="list" @delete="deleteList" @edit="list.edit = true" />
            {{ list.name }}
          </div>
        </div>
        <div class="subtitle">
            {{ list.description }}
        </div>
      </div>
      <div v-else class="mb-45">
        <input :id="`list-${list.id}-name`" type="text" class="input" :value="list.name" />
        <input :id="`list-${list.id}-description`" type="text" class="input" :value="list.description" />
        <button class="is-full-width button is-link is-pulled-right" @click="saveList"><i class="fa fa-save"></i> Save</button>
      </div>
      <div class="progress-bar">
        <progress-bar class="mx-25" bar-color="#3273dc" :val="percentage" :text="`${percentage}%`" />
      </div>
      <div class="tasks">
        <div class="tasks-list" v-for="(task, key) in list.tasks" :key="key">
          <task :task="task" @shouldRemoveTask="removeTask($event)" />
        </div>
      </div>
      <div class="add-task-button">
        <button class="is-full-width button is-link mt-15" @click="addTask"><i class="fa fa-plus"></i></button>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import swal from 'sweetalert2'
  import ProgressBar from 'vue-simple-progress'
  import ListOptions from './ListOptions'
  import Task from './Task'
  
  export default {
    name: 'list',
    props: ['list'],
    components: {
      ListOptions, Task, ProgressBar
    },
    computed: {
      percentage: function () {
        return this.list.tasks.length == 0 ? 100 : Math.trunc(this.tasksDone / this.list.tasks.length * 100)
      },
      tasksDone: function () {
        return this.list.tasks.filter(task => task.done).length
      }
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
      saveList: function () {
        const that = this
        const list = {
          id: that.list.id,
          name: document.getElementById(`list-${that.list.id}-name`).value,
          description: document.getElementById(`list-${that.list.id}-description`).value
        }
        axios.put(`/lists/${this.list.id}`, { list })
        .then(({data}) => {
          that.list.name = data.list.name
          that.list.description = data.list.description
          that.list.edit = false
        })
        .catch(err => {
          console.log(err)
          swal({
            type: 'error',
            title: 'Failed to update task',
            text: `Error: ${err}`
          })
        })
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

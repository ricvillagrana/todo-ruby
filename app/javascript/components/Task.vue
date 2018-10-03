<template>
  <div>
    <div v-if="!task.edit">
      <p-check class="p-icon p-round p-plain p-smooth m-0" color="primary" :checked="task.done" @click.native="toggleDone">
        <i slot="extra" class="icon mdi mdi-check"></i>
      </p-check>
      <span @click="task.edit = true">{{ task.name }}</span>
      <task-options :task="task" @edit="task.edit = true" @delete="deleteTask" />
    </div>
    <div v-else>
      <input @keyup.enter="toggleName" type="text" :value="task.name" class="input column" />
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import swal from 'sweetalert2'
  import TaskOptions from './TaskOptions'

  export default {
    props: ['task'],
    components: {
      TaskOptions
    },
    methods: {
      toggleName: function (event) {
        this.task.name = event.target.value
        this.task.edit = false
        this.save()
      },
      toggleDone: function () {
        const that = this
        that.task.done = !that.task.done
        this.save()
      },
      deleteTask: function () {
        const that = this
        axios.delete(`/tasks/${this.task.id}`)
        .then(({data}) => {
          that.$emit('shouldRemoveTask', that.task.id)
        })
        .catch(err => {
          console.log(err)
          swal({
            type: 'error',
            title: 'Failed to delete task',
            text: `Error: ${err}`
          })
        })
      },
      save: function () {
        const that = this
        const task = {
          id: that.task.id,
          name: that.task.name,
          done: that.task.done,
          list_id: that.task.list_id
        }
        axios.put(`/tasks/${this.task.id}`, { task })
        .then(({data}) => {
          that.task.done = data.task.done
        })
        .catch(err => {
          console.log(err)
          swal({
            type: 'error',
            title: 'Failed to update task',
            text: `Error: ${err}`
          })
        })
      }
    }
  }
</script>

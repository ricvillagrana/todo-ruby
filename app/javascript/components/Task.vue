<template>
  <div>
    <p-check class="p-icon p-round p-plain p-smooth" color="primary" :checked="task.done" @click.native="toggle">
        <i slot="extra" class="icon mdi mdi-check"></i>
        {{ task.name }}
    </p-check>
  </div>
</template>

<script>
  import axios from 'axios'
  import swal from 'sweetalert2'

  export default {
    props: ['task'],
    methods: {
      toggle: function () {
        const that = this
        that.task.done = !that.task.done
        const task = {
          id: that.task.id,
          name: that.task.name,
          done: that.task.done,
          list_id: that.task.list_id
        }
        axios.put(`/tasks/${this.task.id}`, { task })
        .then(({data}) => {
          console.log(data.task)
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

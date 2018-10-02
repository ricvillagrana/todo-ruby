<template>
  <div class="column is-10 is-offset-1">
    <a @click="add" class="button is-link is-rounded is-pulled-right"><i class="fa fa-plus"></i> Add new</a>
  </div>
</template>

<script>
import swal from 'sweetalert2'
import axios from 'axios'

export default {
  name: 'lists',
  components: {},
  methods: {
    add: () => {
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
        const list = {
          name: result.value[0],
          description: result.value[1]
        }
        if (list.name) {
          axios.post('/lists', {
            ...list
          }).then(response => {
            swal({
              title: 'All done!',
              html: `List ${result.value[0]} regitered.`,
              confirmButtonText: 'Done'
            })
          })
        }
      })
    }
  }
}
  
</script>

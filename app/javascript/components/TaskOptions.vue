<template>
  <div class="dropdown is-pulled-right is-right is-active pointer" @click="toggleMenu(task.id)">
    <div class="dropdown-trigger">
      <i class="fa fa-ellipsis-h fa-no-reset"></i>
    </div>
    <div :id="`task-${task.id}`" class="dropdown-menu" role="menu" style="display: none;">
      <div class="dropdown-content" id="dropdown-content">
         <a class="dropdown-item has-text-link" @click="$emit('edit')">
            <i class="fa fa-edit"></i> Edit
          </a>
          <a class="dropdown-item has-text-danger" @click="$emit('delete')">
            <i class="fa fa-times"></i> Delete
          </a>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  export default {
    name: 'task-options',
    props: ['task', 'editable'],
    methods: {
      toggleMenu: function (event) {
        const menu = document.getElementById(`task-${this.task.id}`)
        menu.style.display = menu.style.display == 'none' ? 'block' : 'none'
      }
    }
  }
</script>

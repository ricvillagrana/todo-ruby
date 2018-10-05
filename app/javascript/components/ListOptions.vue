<template>
  <div class="dropdown is-pulled-right is-right is-active" @click="toggleMenu(list.id)">
    <div class="dropdown-trigger">
      <button class="button is-rounded" aria-haspopup="true" aria-controls="dropdown-menu6">
        <i class="fa fa-ellipsis-h fa-no-reset"></i>
      </button>
    </div>
    <div :id="`list-${list.id}`" class="dropdown-menu" role="menu" style="display: none;">
      <div class="dropdown-content" id="dropdown-content">
        <a class="dropdown-item" target="_blank" :href="`/export/pdf/tasks/${list.id}.csv`">
          <i class="fa fa-file-o"></i> Download PDF
        </a>
        <a class="dropdown-item" target="_blank" :href="`/export/csv/tasks/${list.id}.csv`">
          <i class="fa fa-file-pdf-o"></i> Download CSV
        </a>
        <hr class="dropdown-divider">
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
    name: 'list-options',
    props: ['list'],
    methods: {
      toggleMenu: function (event) {
        const menu = document.getElementById(`list-${this.list.id}`)
        menu.style.display = menu.style.display == 'none' ? 'block' : 'none'
      }
    }
  }
</script>

<template>
  <div class="dropdown is-pulled-right is-right mr-15" :class="{'is-active': shown}">
    <div class="dropdown-trigger">
      <button class="button is-rounded" aria-haspopup="true" aria-controls="dropdown-menu" @click="shown = !shown">
        <span>Export</span>
        <span class="icon is-small">
          <i class="fa fa-caret-down" aria-hidden="true"></i>
        </span>
      </button>
    </div>
    <div class="dropdown-menu" id="dropdown-menu" role="menu">
      <div class="dropdown-content">
        <a target="_blank" :href="`/export/csv/lists.csv`" class="dropdown-item">
          <i class="fa fa-file-o"></i> Export to CSV
        </a>
        <a target="_blank" :href="`/export/pdf/lists.csv`"  class="dropdown-item">
          <i class="fa fa-file-pdf-o"></i> Export to PDF
        </a>
        <hr class="dropdown-divider">
        <a target="_blank" :href="`/export/csv/tasks.csv`"  class="dropdown-item">
          <i class="fa fa-file-pdf-o"></i> Export all tasks to CSV
        </a>
        <a target="_blank" :href="`/export/pdf/tasks.csv`"  class="dropdown-item">
          <i class="fa fa-file-pdf-o"></i> Export all tasks to PDF
        </a>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'download-list',
    data() {
      return {
        shown: false
      }
    }
  }
</script>
    
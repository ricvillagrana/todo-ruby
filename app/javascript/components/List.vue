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
      <div class="add-task button is-link mt-15"><i class="fa fa-plus"></i></div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import ListOptions from './ListOptions'
  import Task from './Task'
  
  export default {
    name: 'list',
    props: ['list'],
    components: {
      ListOptions, Task
    }
  }
</script>

require 'rake'

task sqlite3_boolean: :environment do
  Task.where('done', 't').update_all(done: 1)
  Task.where('done', 'f').update_all(done: 0)
  puts 'Tasks.done now is numeric'
end

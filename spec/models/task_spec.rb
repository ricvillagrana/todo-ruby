require 'rails_helper'

RSpec.describe Task, type: :model do
  # Define User to be used in tests
  let (:user) do
    user = User.new(
      email: 'someone@example.com',
      password: 'some_password_to_test'
    )
    user.save
    user
  end

  # Define List to be used in tests
  let (:list) do
    list = user.lists.new(
      name: 'New list',
      description: 'Amazing description'
    )
    list.save
    list
  end

  # Define List to be used in tests
  let (:task) do
    task = list.tasks.new(
      name: 'New task',
      done: false
    )
    task.save
    task
  end

  context 'validation test' do
    it 'ensures pesence of name' do
      new_task = list.tasks.new(
        done: false
      ).save
      expect(new_task).to eq(false)
    end
  end

  context 'creation test' do
    it 'ensures that a task can be created' do
      new_task = list.tasks.new(
        name: 'New task',
        done: false
      ).save
      expect(new_task).to eq(true)
    end
  end

  context 'modification test' do
    it 'ensures that a task can be done' do
      new_task = list.tasks.new(
        name: 'New task',
        done: false
      )
      new_task.save
      new_task.done = true
      new_task.save
      expect(new_task.done).to eq(true)
    end

    it 'ensures that a task can be undone' do
      new_task = list.tasks.new(
        name: 'New task',
        done: true
      )
      new_task.save
      new_task.done = false
      new_task.save
      expect(new_task.done).to eq(false)
    end

    it 'ensures that a task can renamed' do
      new_task = list.tasks.new(
        name: 'New task',
        done: false
      )
      new_task.save
      new_task.name = 'New name'
      new_task.save
      expect(new_task.name).to eq('New name')
    end
  end
end

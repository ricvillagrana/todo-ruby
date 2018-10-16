require 'rails_helper'

RSpec.describe List, type: :model do
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

  context 'creation test' do
    it 'ensures that a list can be created' do
      list = user.lists.new(
        name: 'New list',
        description: 'Amazing description'
      ).save
      expect(list).to eq(true)
    end

    it 'ensures that a list can create a task' do
      task = list.tasks.new(name: 'Task', done: false).save
      expect(task).to eq(true)
    end
  end

  context 'update test' do
    it 'ensueres that a list can be updated' do
      list.update!(name: 'Updated name')
      expect(list.name).to eq('Updated name')
    end
  end
end

# /spec/model/inventory_spec.rb
require 'rails_helper'

RSpec.describe Inventory, type: :model do
  user = User.new(name: 'John Doe', email: 'local@host', password: '123456', password_confirmation: '123456')
  before { user.save }

  inventory = Inventory.new(user:, name: 'Inventory 1', description: 'Inventory 1 description')

  it 'is valid with valid attributes' do
    expect(inventory).to be_valid
  end

  it 'is not valid without a name' do
    inventory.name = nil
    expect(inventory).to_not be_valid
  end

  it 'is not valid with a name less than 3 characters' do
    inventory.name = 'ab'
    expect(inventory).to_not be_valid
  end

  it 'is not valid with a name more than 50 characters' do
    inventory.name = 'a' * 51
    expect(inventory).to_not be_valid
  end

  it 'is valid with a name between 3 and 50 characters' do
    inventory.name = 'a' * 10
    expect(inventory).to be_valid
  end

  it 'is not valid with name that already exists' do
    inventory2 = Inventory.create(user_id: 1, name: 'Inventory 1', description: 'Inventory 1 description')
    expect(inventory2).to_not be_valid
  end

  it 'is not valid without a description' do
    inventory.description = nil
    expect(inventory).to_not be_valid
  end

  it 'is not valid with a description less than 3 characters' do
    inventory.description = 'ab'
    expect(inventory).to_not be_valid
  end

  it 'is not valid with a description more than 500 characters' do
    inventory.description = 'a' * 501
    expect(inventory).to_not be_valid
  end

  it 'is valid with a description between 3 and 500 characters' do
    inventory.description = 'a' * 10
    expect(inventory).to be_valid
  end

  it 'is not valid without a user' do
    inventory.user = nil
    expect(inventory).to_not be_valid
  end
end

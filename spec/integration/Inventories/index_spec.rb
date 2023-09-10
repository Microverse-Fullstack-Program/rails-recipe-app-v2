require 'rails_helper'

RSpec.describe 'inventories/index', type: :feature do
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in(@user, scope: :user)

    @inventory1 = Inventory.create(name: 'inventory1', user: @user, description: 'description1')
    @inventory2 = Inventory.create(name: 'inventory2', user: @user, description: 'description2')
  end

  it 'renders the Inventories page' do
    visit inventories_path 
    expect(page).to have_content('Inventories List')

    expect(page).to have_content(@inventory1.name)
    expect(page).to have_content(@inventory1.description)

    expect(page).to have_content(@inventory2.name)
    expect(page).to have_content(@inventory2.description)
  end
end

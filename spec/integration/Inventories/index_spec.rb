# spec/integration/Inventories/index_spec.rb

require 'rails_helper'

RSpec.describe 'inventories/index', type: :view do
  before(:each) do
    @user = FactoryBot.create(:user)
      .login_as(@user, scope: :user)

    @inventory1 = Inventory.create(name: 'inventory1', user: @user, description: 'description1')
    @inventory2 = Inventory.create(name: 'inventory2', user: @user, description: 'description2')
  end

  it 'renders the Inventories page' do
    render
    expect(rendered).to have_content('Inventories List')

    expect(rendered).to have_content(@inventory1.name)
    expect(rendered).to have_content(@inventory1.description)

    expect(rendered).to have_content(@inventory2.name)
    expect(rendered).to have_content(@inventory2.description)
  end
end

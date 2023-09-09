# spec/request/inventories_spec.rb
require 'rails_helper'

RSpec.describe 'InventoriesController', type: :request do
  describe 'GET /index' do
    before do
      user = FactoryBot.create(:user)
      login_as(user, scope: :user)
      get inventories_path
    end

    it 'returns a successful response' do
      expect(response).to have_http_status(200)
    end

    it 'correct template is rendered' do
      expect(response).to render_template(:index)
    end

    it 'the response body includes correct placeholder text' do
      expect(response.body).to include('Inventories List')
    end
  end
end

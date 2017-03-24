# Generated via
#  `rails generate hyrax:work DemoWork`
require 'rails_helper'
include Warden::Test::Helpers

RSpec.feature 'Create a DemoWork' do
  context 'a logged in user' do
    let(:user_attributes) do
      { email: 'test@example.com' }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end

    before do
      login_as user
    end

    scenario do
      visit new_curation_concerns_demo_work_path
      fill_in 'Title', with: 'Test DemoWork'
      click_button 'Create DemoWork'
      expect(page).to have_content 'Test DemoWork'
    end
  end
end

require'rails_helper'

describe "sign into admin panel" do
  context 'login credentials' do
    let!(:admin) { create(:admin) }
    before :each do
      visit new_admin_session_path
    end
    it 'check for valid credentials' do
      within("#new_admin") do
        fill_in 'admin_email', with: admin.email
        fill_in 'admin_password', with: admin.password
        click_on 'Ingresar'
      end
      visit admin_admins_path
      expect(page).to have_content("Administradores")
    end
  end
end

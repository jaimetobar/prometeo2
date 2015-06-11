require'rails_helper'

RSpec.feature "go throw a plan" do
  context 'choose a role' do
    before do
      visit root_path
    end
    scenario "choose 'Sales Engineer' " do
      find(:xpath, "//a[@href='/plan/step_2_accreditations?role=sales_engineer']").click
      expect(page).to have_content 'Selecciona las acreditaciones que deseas tomar'
      expect(current_url).to have_content "/plan/step_2_accreditations?role=sales_engineer"
    end
    scenario "choose 'Sales' " do
      find(:xpath, "//a[@href='/plan/step_2_accreditations?role=sales']").click
      expect(page).to have_content 'Selecciona las acreditaciones que deseas tomar'
      expect(current_url).to have_content "/plan/step_2_accreditations?role=sales"
    end
    scenario "choose 'Delivery' " do
      find(:xpath, "//a[@href='/plan/step_2_accreditations?role=delivery']").click
      expect(page).to have_content 'Selecciona las acreditaciones que deseas tomar'
      expect(current_url).to have_content "/plan/step_2_accreditations?role=delivery"
    end
  end

  context 'step_3', :js => true do
    before do
      @accreditation = create(:accreditation)
      visit '/plan/step_2_accreditations?role=delivery'
    end
    # let(:accreditation) { create(:accreditation) }

    scenario "Choose an accreditation"  do

      within(".accreditation-box") do
        find(:css, '.btn.btn-default.btn-block.btn-select-accreditation')
      end
      click_button ("Crear Plan")
      page.driver.console_messages
      page.driver.error_messages
      save_and_open_page
      expect(current_url).to have_content "/plan/step_3_schedule?utf8=✓&role=delivery&button=&accreditations%5B%5D=#{@accreditation.id}"
    end
  end


end
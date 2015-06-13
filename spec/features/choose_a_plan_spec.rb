require'rails_helper'

RSpec.feature "go throw a plan" do
  context '#step_1_roles' do
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

  context '#step_2_accreditations', :js => true do
    before do
      @accreditation = create(:accreditation)
      visit '/plan/step_2_accreditations?role=delivery'
    end
    # let(:accreditation) { create(:accreditation) }

    scenario "Choose an accreditation and continue"  do
      within(".accreditation-box") do
        find(:css, '.btn.btn-default.btn-block.btn-select-accreditation').click
      end
      click_button ("Crear Plan")
      uri = URI.parse(current_url)
      expect(uri.query).to have_content "utf8=%E2%9C%93&role=delivery&button=&accreditations%5B%5D=#{@accreditation.id}"
    end
    scenario "user forgot to choose an accreditation"  do
      click_button ("Crear Plan")
      uri = URI.parse(current_url)
      expect(page).to have_content "Selecciona por lo menos una acreditación"
    end
  end

  context '#step_3_schedule' do
    before do
      @accreditation = create(:accreditation, :with_course)
      visit '/plan/step_3_schedule?utf8=%E2%9C%93&role=delivery&button=&accreditations%5B%5D=1'
    end
    scenario "Verifies if the accreditation has courses"  do
      expect(page).to have_content "#{@accreditation.courses[0].name}"
      click_link "Suscribirme a notificaciones"
      expect(page).to have_content "Déjanos tus datos y te notificaremos cuando los cursos estén disponibles"
    end
  end

  
end
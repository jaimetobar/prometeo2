require'rails_helper'

RSpec.feature "go through a plan" do
  context '#step_1_roles' do
    before do
      visit plan_path
    end
    scenario "choose 'Sales Engineer' " do
      find(:css,"a[href='/entrenamiento/step_2_accreditations?role=sales_engineer']").click
      expect(page).to have_content 'Selecciona las acreditaciones que deseas tomar'
      expect(current_url).to have_content "/entrenamiento/step_2_accreditations?role=sales_engineer"
    end
    scenario "choose 'Sales' " do
      find(:xpath, "//a[@href='/entrenamiento/step_2_accreditations?role=sales']").click
      expect(page).to have_content 'Selecciona las acreditaciones que deseas tomar'
      expect(current_url).to have_content "/entrenamiento/step_2_accreditations?role=sales"
    end
    scenario "choose 'Delivery' " do
      find(:xpath, "//a[@href='/entrenamiento/step_2_accreditations?role=delivery']").click
      expect(page).to have_content 'Selecciona las acreditaciones que deseas tomar'
      expect(current_url).to have_content "/entrenamiento/step_2_accreditations?role=delivery"
    end
  end

  context '#step_2_accreditations', :js => true do
    before do
      @accreditation = create(:accreditation, role: "delivery")
      visit '/entrenamiento/step_2_accreditations?role=delivery'
    end
    # let(:accreditation) { create(:accreditation) }

    scenario "Choose an accreditation and continue"  do
      within(".accreditation-box") do
        find(:css, '.btn-select-accreditation').click
      end
      click_button ("Crear Plan")
      uri = URI.parse(current_url)
      expect(uri.query).to have_content "D=#{@accreditation.id}"
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
      visit '/entrenamiento/step_3_schedule?utf8=%E2%9C%93&role=delivery&button=&accreditations%5B%5D=1'
    end
    scenario "Verifies if the accreditation has courses"  do
      expect(page).to have_content "#{@accreditation.courses[0].name}"
      click_link "Suscribirme a notificaciones"
      expect(page).to have_content "Déjanos tus datos y te notificaremos cuando los cursos estén disponibles"
    end
  end

  context '#step_4_subscription' do
    let(:accreditation) { create(:accreditation, :with_course) }
    let(:user) { build(:subscriber, country: "BR") }
    before do
      visit '/entrenamiento/step_4_subscription?accreditations%5B%5D=1&role=delivery'
    end
    scenario "Fill-up the formulary and subscribe"  do
      expect(page).to have_content "Déjanos tus datos y te notificaremos cuando los cursos estén disponibles"
      within("form#new_user") do
        fill_in "user_name", with: user.name
        fill_in "user_email", with: user.email
        within '#user_country' do
          first("option[value='#{user.country}']").click
        end
        fill_in "user_partner", with: user.partner
        #The role sould be taken from the URL
        click_button "Suscribirme"
      end
      uri = URI.parse(current_url)
      expect(uri.path).to eq '/'
      expect(page).to have_content "Te avisaremos cuando los cursos vayan a comenzar "
    end
  end
end

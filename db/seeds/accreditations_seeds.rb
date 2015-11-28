# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension

case Rails.env
when "production"
  accreditations = [
    ["Middleware - Desarrollo de apps", :sales],
    ["Middleware - Migración", :sales_engineer],
    ["Middleware - Automatización de procesos de negocio", :delivery],
    ["Middleware - Integración", :sales],
    ["Plataforma - Sistema operativo", :sales],
    ["Plataforma - Virtualización", :sales_engineer],
    ["Plataforma - Migración", :delivery],
    ["Cloud - Administración de nube", :sales],
    ["Cloud - Infraestructura como Servicio (IaaS)", :sales_engineer],
    ["Cloud - Plataforma como Servicio (PaaS)", :delivery]
  ]
  accreditations.each do |name,role|
    Accreditation.create(name: name, role: Accreditation.roles[role])
  end
when "development"
  accreditations_data = [
    { name: "Middleware - Desarrollo de apps", role: "sales", description: Faker::Lorem.paragraph },
    { name: "Middleware - Migración", role: "sales_engineer", description: Faker::Lorem.paragraph },
    { name: "Middleware - Automatización de procesos de negocio", role: "delivery", description: Faker::Lorem.paragraph },
    { name: "Middleware - Integración", role: "sales", description: Faker::Lorem.paragraph },
    { name: "Plataforma - Sistema operativo", role: "sales", description: Faker::Lorem.paragraph },
    { name: "Plataforma - Virtualización", role: "sales_engineer", description: Faker::Lorem.paragraph },
    { name: "Plataforma - Migración", role: "delivery", description: Faker::Lorem.paragraph },
    { name: "Cloud - Administración de nube", role: "sales", description: Faker::Lorem.paragraph },
    { name: "Cloud - Infraestructura como Servicio (IaaS)", role: "sales_engineer", description: Faker::Lorem.paragraph },
    { name: "Cloud - Plataforma como Servicio (PaaS)", role: "delivery", description: Faker::Lorem.paragraph }
  ]
  accreditations = accreditations_data.map do |accreditation_data|
    Accreditation.create(accreditation_data.merge(category: rand(3)))
  end

  10.times do
    d = (rand(5)+1)*10
    c = Course.create(
      name: Faker::Name.title,
      duration: "#{d} hora".pluralize(d),
      description: Faker::Lorem.paragraph,
      category: Course.categories.keys.sample,
      session_type: Course.session_types.keys.sample,
      for_sales_engineer: [true,false].sample,
      for_sales: [true,false].sample,
      for_delivery: [true,false].sample
    )
    c.accreditations << accreditations.sample
  end

end

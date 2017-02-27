data = {
  developer_tools: [
    'JBoss Developer Studio',
    'Openshift Container Local',
    'Container development kit',
    'Application Lifecycle tools',
  ],
  middleware_and_application_services: [
    '3scale',
    'JBoss BPM Suite',
    'JBoss BRMS',
    'JBoss Fuse',
    'JBoss A-MQ',
    'JBoss Data Grid',
    'JBoss Data Virtualization',
    'JBoss Enterprise Application Platform',
    'JBoss Mobile Application Platform'
  ],
  container_platforms: [
    'Openshift Container Platform'
  ],
  infrastructure_software: [
    'Red Hat Enterprise Linux',
    'Red Hat Enterprise Linux Atomic Host',
    'Red Hat Storage',
    'Openstack PLatform',
    'Red Hat Virtualization'
  ],
  security_and_management: [
    'Red Hat Registry',
    'Red Hat Insights',
    'Ansible',
    'Satellite',
    'Cloudforms'
  ]
}

data.each do |category, products|
  category_id = Product.categories[category]
  Product.create!(products.map{ |p| {category: category_id, name: p} })
end
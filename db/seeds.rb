
WcoHosting::Domain.find_or_create_by({ name: 'orbital.city',         route53_zone: 'Z0145070C3DD1OJWHTXJ' })
WcoHosting::Domain.find_or_create_by({ name: 'oquaney-splicing.com', route53_zone: 'Z060228025Y0JHUA35GN5' })

WcoHosting::Serverhost.find_or_create_by({ name: 'vbox1', ssh_host: 'vbox1' })

namespace :db do
  desc "Add default organisation"
  task add_organisation: :environment do
    Organisation.create!(
      name: "Bitzesty",
      slug: "bitzesty",
      content_id: 1,
      organisation_type: "digital"
    )
  end
end

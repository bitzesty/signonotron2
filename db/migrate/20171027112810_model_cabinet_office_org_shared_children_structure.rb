class ModelCabinetOfficeOrgSharedChildrenStructure < ActiveRecord::Migration[5.1][5.0]
  def up
    cabinet_office = Organisation.find_by(name: "Cabinet Office")

    organisation_names = [
      "Social Mobility and Child Poverty Commission",
      "Social Mobility Commission",
    ]

    missing_orgs = []

    organisation_names.each do |child_name|
      org = Organisation.find_by(name: child_name)
      if org.nil?
        missing_orgs << child_name
        puts "!! Couldn't find #{child_name}"
      else
        if org.parent != cabinet_office
          begin
            old_parent_name = org.parent.nil? ? "nil" : org.parent.name
            puts "Checking parent for #{child_name}. Old parent is #{old_parent_name}"
            org.update!(parent: cabinet_office)
            puts "Updating parent for #{child_name} from #{old_parent_name} to #{cabinet_office.name}"
          rescue StandardError => e
            puts "Parent re-assignment failed for: #{child_name} with error '#{e.message}'"
          end
        else
          puts "Parent for #{child_name} is correct"
        end
      end
    end

    if missing_orgs.empty?
      puts "All organisations were found"
    else
      puts "Missing organisations: #{missing_orgs.join("\n")}"
    end
  end

  def down
    # This change cannot be reversed
  end
end

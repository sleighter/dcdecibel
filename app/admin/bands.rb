ActiveAdmin.register Band do
  index do
    column :name do |band|
      band.homepage_url ? link_to(band.name,band.homepage_url) : band.name
    end
    column "Editor\'s Choice?", :is_editors_choice do |band|
      band.is_editors_choice ? raw('&#10003;') : ''
    end
    default_actions
  end
  
  form do |f|
    f.inputs "Basic Information" do
      f.input :name
      f.input :homepage_url
      f.input :bio
    end
    f.inputs "External Identifiers" do
      f.input :last_fm_id
      f.input :wikipedia_id
    end
    f.inputs "Editor\'s Choice" do
      f.input :is_editors_choice
      f.input :editors_choice_note
    end
    f.buttons
  end
end

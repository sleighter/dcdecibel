ActiveAdmin.register Band do
  index do
    column :name
    column "Homepage", :homepage_url, do |band| 
      band.homepage_url ? link_to("Homepage", band.homepage_url) : ""
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
      f.input :is_local
      f.input :is_jazz
      f.input :is_classical
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

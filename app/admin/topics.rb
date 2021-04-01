ActiveAdmin.register Topic do
  permit_params :description, :image

  filter :description

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :description
      f.input :image, as: :file
      f.actions
    end
  end

  index do
    selectable_column
    id_column
    column :description
    column :image do |i|
      image_tag url_for(i.image) || '', class: 'image_thumbnail' if i.image.attached?
    end
    column :created_at
    column :updated_at

    actions
  end

  show do
    attributes_table do
      row :description
      row :image do |i|
        image_tag url_for(i.image) || '', class: 'image_preview' if i.image.attached?
      end
    end
  end
end

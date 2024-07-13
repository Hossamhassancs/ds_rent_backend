# app/admin/brands.rb
ActiveAdmin.register Brand do
  permit_params :name_ar, :name_en, :logo

  index do
    selectable_column
    id_column
    column :name_ar
    column :name_en
    column :logo do |brand|
      if brand.logo.present?
        image_tag brand.logo.url, width: '50px'
      else
        content_tag(:span, "No logo available")
      end
    end
    actions
  end

  filter :name_ar
  filter :name_en
  # Remove any filter that references `cars`

  form do |f|
    f.inputs 'Brand Details' do
      f.input :name_ar
      f.input :name_en
      f.input :logo, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :name_ar
      row :name_en
      row :logo do |brand|
        if brand.logo.present?
          image_tag brand.logo.url, width: '100px'
        else
          content_tag(:span, "No logo available")
        end
      end
    end
    active_admin_comments
  end
end

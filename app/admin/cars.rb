ActiveAdmin.register Car do
  permit_params :name_en, :name_ar, :seats_num, :make_year, :engine_size, :transmission_ar, :transmission_en, :cylinders, :fuel_type_en, :fuel_type_ar, :doors, :colors, :car_type_ar, :car_type_en, :brand_id, :price, :in_stock, features: [], images_attributes: [:id, :file, :_destroy]

  index do
    selectable_column
    id_column
    column :name_en
    column :name_ar
    column :seats_num
    column :make_year
    column :engine_size
    column :transmission_ar
    column :transmission_en
    column :cylinders
    column :fuel_type_en
    column :fuel_type_ar
    column :doors
    column :colors
    column :car_type_ar
    column :car_type_en
    column :brand
    column :price
    column :in_stock
    column :images do |car|
      car.images.map { |img| img.file.present? ? image_tag(img.file.url, size: '50x50') : 'No Image' }.join(' ').html_safe
    end
    actions
  end

  form do |f|
    f.inputs 'Car Details' do
      f.input :brand, as: :select, collection: Brand.all.collect { |brand| [brand.name_en, brand.id] }
      f.input :name_en
      f.input :name_ar
      f.input :seats_num
      f.input :make_year, as: :select, collection: 2000..Date.current.year
      f.input :engine_size
      f.input :transmission_ar, as: :select, collection: %w[مانيوال اوتوماتيك]
      f.input :transmission_en, as: :select, collection: %w[automatic manual]
      f.input :cylinders, as: :select, collection: 1..10
      f.input :fuel_type_en, as: :select, collection: %w[Gasoline Electric Diesel Hybrid]
      f.input :fuel_type_ar, as: :select, collection: %w[ديزل هايبرد بنزين كهربا]
      f.input :doors
      f.input :colors, as: :string
      f.input :features, input_html: { value: f.object.features.join(', ') }
      f.input :car_type_ar, as: :select, collection: [
        "سيدان",
        "اس يو في",
        "هاتشباك",
        "كوبيه",
        "كونفرتبل",
        "واجن",
        "ميني فان",
        "بيك أب",
        "كروس أوفر",
        "رودستر",
        "فان",
        "سبورتس كار",
        "ميكروكار",
        "لاكشري كار",
        "كومباكت كار",
        "ساب كومباكت كار",
        "ماسل كار",
        "ستيشن واجن",
        "أوف رود فيكل",
        "ليموزين",
        "تارغا توب",
        "فاستباك",
        "كابريوليه"
      ]
      f.input :car_type_en, as: :select, collection: [
        "Sedan",
        "SUV",
        "Hatchback",
        "Coupe",
        "Convertible",
        "Wagon",
        "Minivan",
        "Pickup Truck",
        "Crossover",
        "Roadster",
        "Van",
        "Sports Car",
        "Microcar",
        "Luxury Car",
        "Compact Car",
        "Subcompact Car",
        "Muscle Car",
        "Station Wagon",
        "Off-Road Vehicle",
        "Limousine",
        "Targa Top",
        "Fastback",
        "Cabriolet"
      ]
      f.input :price
      f.input :in_stock, as: :boolean
    end
    f.inputs 'Images' do
      f.has_many :images, allow_destroy: true, new_record: true do |ff|
        ff.input :file, as: :file
        ff.input :_destroy, as: :boolean, label: 'Remove image'
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :brand
      row :name_en
      row :name_ar
      row :seats_num
      row :make_year
      row :engine_size
      row :transmission_ar
      row :transmission_en
      row :cylinders
      row :fuel_type_en
      row :fuel_type_ar
      row :doors
      row :colors
      row :car_type_ar
      row :car_type_en
      row :price
      row :in_stock
      row :features do |car|
        car.features.join(', ')
      end
      row :images do |car|
        car.images.map { |img| img.file.present? ? image_tag(img.file.url, size: '50x50') : 'No Image' }.join(' ').html_safe
      end
    end
    active_admin_comments
  end

  filter :brand
  filter :name_en
  filter :name_ar
  filter :seats_num
  filter :make_year
  filter :engine_size
  filter :transmission_ar
  filter :transmission_en
  filter :cylinders
  filter :fuel_type_en
  filter :fuel_type_ar
  filter :doors
  filter :colors
  filter :car_type_ar
  filter :car_type_en
  filter :price
  filter :in_stock
end

require 'rails_helper'

RSpec.feature "Visitor navigate from home page to product page", type: :feature, js: true do
  
   # SETUP
   before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see product details" do
    # ACT
    visit root_path
    
    click_link_or_button('Details', match: :first)
    sleep 1
   
    # DEBUG
    save_screenshot
    # puts page.html

    # VERIFY

    expect(page).to have_css 'section.products-show'

  end
end

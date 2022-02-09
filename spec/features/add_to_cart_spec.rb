require 'rails_helper'

RSpec.feature "Visitor can add product to cart", type: :feature, js: true do
  
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

  scenario "They see cart get updated by 1" do
    # ACT
    visit root_path
    
    click_link_or_button('Add', match: :first)
    sleep 1
   
    # DEBUG
    save_screenshot
    # puts page.html

    # VERIFY

    expect(page).to have_css("a", text: 'My Cart (1)')

  end
end

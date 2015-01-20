module Helpers

  def sign_in(user)
    visit '/users/sign_in'
    within '#main' do
      fill_in 'user_mobile', with: user.mobile
      fill_in 'user_password', with: 'topsecret'
      click_link_or_button 'Logg inn'
      #expect(current_path).to eq(root_path)
      #page.should have_content 'Velkommen!'
    end
  end

  def sign_up(email)
    visit '/users/sign_up'
    fill_in 'user_email', with: user.mobile
    fill_in 'user_password', with: 'topsecret'
    click_link_or_button 'Logg inn'
  end
end

module FeatureHelper

  def sign_in(user)
    visit root_path
    #click_link I18n.t('auth.sign_in.link')
    within '#main' do
      fill_in 'user_mobile',    with: user.mobile
      fill_in 'user_password',  with: 'topsecret'
      click_link_or_button 'Logg inn'
    end
  end
end
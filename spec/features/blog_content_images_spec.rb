require 'spec_helper'

feature 'Blog Content Images' do
  before :all do
    @article = Fabricate(:blog_article)
    @project = Fabricate(:blog_project)
    @project_leader = Fabricate(:user, roles: [:project_leader])
  end

  after :all do
    @article.destroy
    @project.destroy
  end

  scenario 'articles can have multiple images', js: true do
    sign_in(@project_leader)
    visit edit_admin_blog_article_path(@article)

    first(:css, '.has_many_container.blog_images a.button.has_many_add').click
    attach_file 'blog_article_blog_images_attributes_0_image',
              "#{Rails.root}/spec/fabricators/test_assets/mann-frontpage.jpg",
              visible: false

    first(:css, '.has_many_container.blog_images a.button.has_many_add').click
    attach_file 'blog_article_blog_images_attributes_1_image',
              "#{Rails.root}/spec/fabricators/test_assets/mann3-frontpage.jpg",
              visible: false

    first('input[type="submit"]').click

    expect(@article.reload.blog_images.pluck(:image))
      .to eq %w(mann-frontpage.jpg mann3-frontpage.jpg)
  end

  scenario 'article main image is displayed on the front page', js: true do
    pending "not implemented in the views" 
    sign_in(@project_leader)
    visit edit_admin_blog_article_path(@article)

    first(:css, '.has_many_container.blog_images a.button.has_many_add').click
    attach_file 'blog_article_blog_images_attributes_0_image',
              "#{Rails.root}/spec/fabricators/test_assets/mann-frontpage.jpg",
              visible: false

    first(:css, '.has_many_container.blog_images a.button.has_many_add').click
    attach_file 'blog_article_blog_images_attributes_1_image',
              "#{Rails.root}/spec/fabricators/test_assets/mann3-frontpage.jpg",
              visible: false
    check 'blog_article_blog_images_attributes_1_main'

    first('input[type="submit"]').click

    main_image_url = @article.main_image.image.url
    visit root_path
    within first(:css, '.news ul li .content') do
      expect(page).to have_css('img[src="' + main_image_url + '"]')
    end
  end

  scenario 'projects can have multiple images', js: true do
    pending "not implemented in the views" 
    sign_in(@project_leader)
    visit edit_admin_blog_project_path(@project)

    first(:css, '.has_many_container.blog_images a.button.has_many_add').click
    attach_file 'blog_project_blog_images_attributes_0_image',
                "#{Rails.root}/spec/fabricators/test_assets/mann-frontpage.jpg",
                visible: false

    first(:css, '.has_many_container.blog_images a.button.has_many_add').click
    attach_file 'blog_project_blog_images_attributes_1_image',
                "#{Rails.root}/spec/fabricators/test_assets/mann3-frontpage.jpg",
                visible: false

    first('input[type="submit"]').click

    expect(@project.reload.blog_images.pluck(:image))
    .to eq %w(mann-frontpage.jpg mann3-frontpage.jpg)
  end

  scenario 'project main image is displayed on the front page', js: true do
    pending "not implemented in the views" 
    sign_in(@project_leader)
    visit edit_admin_blog_project_path(@project)

    first(:css, '.has_many_container.blog_images a.button.has_many_add').click
    attach_file 'blog_project_blog_images_attributes_0_image',
                "#{Rails.root}/spec/fabricators/test_assets/mann-frontpage.jpg",
                visible: false

    first(:css, '.has_many_container.blog_images a.button.has_many_add').click
    attach_file 'blog_project_blog_images_attributes_1_image',
                "#{Rails.root}/spec/fabricators/test_assets/mann3-frontpage.jpg",
                visible: false
    check 'blog_project_blog_images_attributes_1_main'

    first('input[type="submit"]').click

    main_image_url = @project.main_image.image.url
    visit root_path
    within first(:css, '.projects ul li') do
      expect(page).to have_css('img[src="' + main_image_url + '"]')
    end
  end
end

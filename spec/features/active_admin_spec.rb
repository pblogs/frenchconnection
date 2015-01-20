require 'spec_helper'

feature 'Active Admin' do
  before :all do
    @project_leader = Fabricate(:user, roles: [:project_leader])
  end
  scenario 'project leader can access dashboard' do
    sign_in(@project_leader)

    visit '/admin'

    within first(:css, '.header #current_user') do
      expect(page).to have_content @project_leader.name
    end
  end

  scenario 'worker cannot access dashboard' do
    @worker = Fabricate(:user, roles: [:worker])
    sign_in(@worker)

    visit '/admin'

    current_path.should eq '/'
  end

  scenario 'published article displays in news section' do
    publish_date = Time.now.strftime('%Y-%m-%d')
    sign_in(@project_leader)

    visit '/admin/blog_articles/new'
    fill_in 'blog_article_title', with: 'Test article'
    fill_in 'blog_article_content', with: 'Test article content'
    check 'blog_article_published'
    fill_in 'blog_article_publish_date', with: publish_date
    first('input[type="submit"]').click

    visit '/blog'

    within first(:css, '.news') do
      expect(page).to have_css 'ul li .content'
      expect(page).to have_content 'Test article'
    end
  end

  scenario 'published project displays in projects section' do
    publish_date = Time.now.strftime('%Y-%m-%d')
    sign_in(@project_leader)

    visit '/admin/blog_projects/new'
    fill_in 'blog_project_title', with: 'Test project'
    fill_in 'blog_project_content', with: 'Test project content'
    check 'blog_project_published'
    fill_in 'blog_project_publish_date', with: publish_date
    first('input[type="submit"]').click

    visit '/blog'

    within first(:css, '.projects ul li') do
      expect(page).to have_content 'Test project'
    end
  end

  scenario 'not published article does not display in news section' do
    sign_in(@project_leader)

    visit '/admin/blog_articles/new'
    fill_in 'blog_article_title', with: 'Test article'
    fill_in 'blog_article_content', with: 'Test article content'
    fill_in 'blog_article_publish_date',
            with: -> { Time.now.strftime('%Y-%m-%d') }
    first('input[type="submit"]').click

    visit '/blog'

    within first(:css, '.news') do
      expect(page).to have_content I18n.t('blog.no_articles')
    end
  end

  scenario 'not published project does not display in projects section' do
    sign_in(@project_leader)

    visit '/admin/blog_projects/new'
    fill_in 'blog_project_title', with: 'Test project'
    fill_in 'blog_project_content', with: 'Test project content'
    fill_in 'blog_project_publish_date',
            with: -> { Time.now.strftime('%Y-%m-%d') }
    first('input[type="submit"]').click

    visit '/blog'

    within first(:css, '.projects') do
      expect(page).to have_content I18n.t('blog.no_projects')
    end
  end
end

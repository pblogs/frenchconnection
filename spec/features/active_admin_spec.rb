require 'spec_helper'

feature 'Active Admin', type: :feature do
  pending "Fails  at Nokogiri::CSS::SyntaxError: unexpected '$' after '' "
  before :all do
    @project_leader = Fabricate(:user, roles: [:project_leader])
  end
  scenario 'project leader can access dashboard' do
  pending "Fails  at Nokogiri::CSS::SyntaxError: unexpected '$' after '' "
    sign_in(@project_leader)

    visit '/admin'

    within first(:css, '#header') do
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
    pending "works manually"
    publish_date = Time.now.strftime('%Y-%m-%d')
    sign_in(@project_leader)

    visit '/admin/blog_articles/new'
    fill_in 'blog_article_title', with: 'New Test article'
    fill_in 'blog_article_content', with: 'Test article content'
    check 'blog_article_published'
    fill_in 'blog_article_publish_date', with: publish_date
    first('input[type="submit"]').click

    visit '/blog'

    within first(:css, '.news') do
      expect(page).to have_css 'ul li .content'
      expect(page).to have_content 'New Test article'
    end
  end

  scenario 'published project displays in projects section' do
  pending
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
    pending "works manually"
    sign_in(@project_leader)

    visit '/admin/blog_articles/new'
    fill_in 'blog_article_title', with: 'New Test article'
    fill_in 'blog_article_content', with: 'Test article content'
    #fill_in 'blog_article_ingress', with: 'Test article ingress'
    fill_in 'blog_article_publish_date',
            with: -> { Time.now.strftime('%Y-%m-%d') }
    first('input[type="submit"]').click

    visit '/blog'

    within first(:css, '.news') do
      expect(page).to have_content I18n.t('blog.no_articles')
    end
  end

  scenario 'not published project does not display in projects section' do
    pending "works manually"
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

  scenario 'published videos display on video page' do
  pending "Fails  at Nokogiri::CSS::SyntaxError: unexpected '$' after '' "
    publish_date = Time.now.strftime('%Y-%m-%d')
    other_video = Fabricate(:blog_video)
    sign_in(@project_leader)

    visit '/admin/blog_videos/new'
    fill_in 'blog_video_title', with: 'Another test video'
    fill_in 'blog_video_content', with: 'Another test video content'
    fill_in 'blog_video_video_url', with: '//www.youtube.com/embed/o0nm5Oqh6TY'
    check 'blog_video_published'
    fill_in 'blog_video_publish_date', with: publish_date
    first('input[type="submit"]').click

    visit '/video'

    within first(:css, 'h1.current_video') do
      expect(page).to have_content 'Another test video'
    end
    expect(page).to have_css('section.video_content')
    expect(page).to have_css('section.video_nav')
    within first(:css, 'section.video_nav') do
      expect(page).to have_content other_video.title
      expect(page).not_to have_content 'Another test video'
    end
  end
end

ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel I18n.t('blog.news') do
          ul do
            BlogArticle.published.limit(4).map do |article|
              li link_to(article.title, edit_admin_blog_article_path(article))
            end
          end
        end
      end
    end

    columns do
      column do
        panel I18n.t('blog.latest_projects') do
          ul do
            BlogProject.published.limit(4).map do |project|
              li link_to(project.title, edit_admin_blog_project_path(project))
            end
          end
        end
      end
    end
  end
end

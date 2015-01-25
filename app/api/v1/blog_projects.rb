module V1
  class BlogProjects < Base

    resource :blog_projects do
      
      desc "Get all published BlogProcjects"
      get do
        published_projects = BlogProject.all.select {
          |project| project.published
        }

        present :blog_projects, published_projects, 
                with: V1::Entities::BlogProjects
        
        header 'Access-Control-Allow-Origin', '*'
      end
      
    end
    
  end
end

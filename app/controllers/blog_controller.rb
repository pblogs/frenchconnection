class BlogController < ApplicationController

  def index
    @blog_articles = BlogArticle.published.limit(3)
    @blog_projects = BlogProject.published.limit(4)
  end

  def content
    @content = get_content
    if @content.nil?
      redirect_to :root
    end
  end

  def video
    @current = params[:id].present? ?
        BlogVideo.find_by(id: params[:id], published: true) :
        BlogVideo.published.first
    @blog_videos = BlogVideo.published
                    .where('id != :id', id: @current.id) if @current.present?
  end

  def hms
  end

  def instructions
    @url = 'http://home.powertech.no/martins/orwapp-assets/'
    @files = {'07.02_instruks_byggeplass.pdf' => I18n.t('instructions.construction_site'),
              '07.09_instruks_stillas.pdf' =>    I18n.t('instructions.scaffold'),
              '07.19_instruks_tvangsblander.pdf' => I18n.t('instructions.concrete_mixer'),
              '07.20_instruks_gjerdesag.pdf'     => I18n.t('instructions.gjerdesag'),
              '07.21_instruks_boltpistol.pdf' =>    I18n.t('instructions.boltpistol'),
              '07.22_instruks_vinkelsliper.pdf'  =>  I18n.t('instructions.vinkelsliper'),
              '07.29_instruks_spikerpistol.pdf' =>   I18n.t('instructions.spikerpistol'),
              '07.30_instruks_kjedesag.pdf'     =>   I18n.t('instructions.kjedesag'),
              '07.32_instruks_sikkerhetssele_fallblokk.pdf' => I18n.t('instructions.sikkerhetssele_fallblokk'), 
              '07.33_instruks_hoystrykksspyler.pdf' => I18n.t('instructions.hoystrykksspyler')
              }
  end

  def frontpage_manager
  end

  def new_assignment
    @customers = Customer.all
  end

  private

  def get_content
    type = params[:content_type].present? ?
        params[:content_type].classify.constantize : nil
    type.find(params[:id]) rescue nil
  end

end

class StaticPagesController < ApplicationController

  def blog
  end

  def video
  end

  def hms
  end

  def admin
  end

  def instructions
    @url = 'http://home.powertech.no/martins/orwapp-assets/'
    @files = {'07.02_instruks_byggeplass.pdf'    => I18n.t('instructions.construction_site'),
              '07.09_instruks_stillas.pdf'       => I18n.t('instructions.scaffold'),
              '07.19_instruks_tvangsblander.pdf' => I18n.t('instructions.concrete_mixer'),
              '07.20_instruks_gjerdesag.pdf'     => I18n.t('instructions.gjerdesag'),
              '07.21_instruks_boltpistol.pdf'    => I18n.t('instructions.boltpistol'),
              '07.22_instruks_vinkelsliper.pdf'  => I18n.t('instructions.vinkelsliper'),
              '07.29_instruks_spikerpistol.pdf'  => I18n.t('instructions.spikerpistol'),
              '07.30_instruks_kjedesag.pdf'      => I18n.t('instructions.kjedesag'),
              '07.32_instruks_sikkerhetssele_fallblokk.pdf' => I18n.t('instructions.sikkerhetssele_fallblokk'),
              '07.33_instruks_hoystrykksspyler.pdf'         => I18n.t('instructions.hoystrykksspyler')
              }
  end

  def frontpage_manager
  end

  def new_assignment
    @customers = Customer.all
  end

end

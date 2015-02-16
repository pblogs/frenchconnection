class DailyReport
  require 'rubygems'
  require 'axlsx'

  def initialize(project:, profession:, overtime: :hour, of_kind: :of_kind)
    @project    = project
    @profession = profession
    @overtime   = overtime  # In percent. E.g: 50 or 100
    @workers    = @project.users.where(profession: @profession)
    @header     = "DAGSRAPPORT - #{@profession.title} - #{@overtime}"
    @logo       = 'app/assets/images/alliero-bratfoss-h46.png'
    @of_kind    = of_kind
  end

=begin

  Merk: Faggruppe er rollen: Eks malermester, snekkersven ol.
  Det skal lages en dagsrapport for:
  Hver faggruppe - ordinær tid
  Hver fagggruppe - 50% overtid
  Hver fagggruppe - 100% overtid
  For kjøring med firmabil (kommer først på plass når feature lag oppgave er ferdig)
  For utak av materialer fra lager (samme som kjøring)
  
  Dagsrapporten skal inneholde:
    - Posisjon i excel-arket er det samme som avdeling. Endre navn på dette i importen og i views.
    - Dagsrapporter. Navnene skal listes ut vertikalt. (Dette er Martins notat, jeg vet ikke hva det betyr)

=end


  def create_spreadsheet
    Axlsx::Package.new do |p|
      p.workbook do |wb|
        styles = wb.styles
        header = styles.add_style :bg_color => "FF", :sz => 16, :b => true, 
          :i => true, :alignment => {:horizontal => :center}, :underline => true
        gray_bg_bold_italic_font   = styles.add_style  :b => true, 
          :bg_color => "C0C0C0"
    
        bold_italic = styles.add_style :b => true, :i => true 
        bold        = styles.add_style :b => true
        yellow_bg   = styles.add_style :b => true, :bg_color => 'FFF60B',
          :alignment => { :horizontal => :left }
        gray_bg_align_right = styles.add_style :alignment => { 
          :horizontal => :right }, :bg_color => "C0C0C0"
        attest_style= styles.add_style :alignment => { :horizontal => :right }, 
          :sz => 16
    
    
        wb.add_worksheet do |sheet|
    
          sheet.add_image(:image_src => @logo,
                          :noSelect => true, :noMove => true) do |image|
            image.width=390
            image.height=60
            image.start_at 0,1
          end
    
          sheet.add_row
          sheet.add_row [nil, nil, nil, @header], :style => [nil, nil, nil, header], 
            :height => 23
          sheet.add_row
          sheet.add_row [nil, nil, nil]
          sheet.add_row ['År:', Time.now.year, "Pågår"],  
            :style => [bold_italic, yellow_bg, bold]
          sheet.add_row ['Uke:', @project.week_numbers, "Ferdigstilt"],    
            :style => [bold_italic, yellow_bg, bold]
          sheet.add_row ['Prosjekt nr:', @project.project_number ],  
            :style => [bold_italic, yellow_bg, bold]
          sheet.add_row ['Kunde:', @project.customer.name ], 
            :style => [bold_italic, yellow_bg, bold]
          sheet.add_row ['Adresse:',
                         (@project.execution_address || @project.customer.address), 
                         nil, nil, nil ], 
            :style => [bold_italic, yellow_bg, bold]
    
          # 5 blanks with C D E F G spanning from 7-11
          sheet.add_row [nil, nil, nil, nil, nil] 
          sheet.add_row [nil]
          sheet.add_row [nil]
          sheet.add_row [nil]
          sheet.add_row [nil]
          %w(C9:C14 D9:D14 E9:E14 F9:F14).each { |range| sheet.merge_cells(range) }
          
          sheet.add_row ['Dato:', nil, nil, nil, nil, nil, nil, nil], 
            :style => [gray_bg_bold_italic_font, gray_bg_bold_italic_font]


          # This is where all the hours registered on this project is listed
          # e.g @workers contain only carpenters 
          #
          i = 1
          ai = -1
          @workers.each do |user|
            ai += 1
            @project.hours_spents.where(user: user).each do |hours_spent|
              next unless (hours_spent.send(@overtime) > 0 rescue nil)
              sheet.add_row [I18n.l(hours_spent.created_at, format: :short_date), 
                hours_spent.description] + 
                offsett(ai) + [hours_spent.send(@overtime)]
              i += 1 
            end
          end
          sheet.add_row [nil]
          sheet.add_row [nil]
          sheet.add_row [nil]

          # Var Sum timer pr pers
          # Nå ant timer i gitt overtime verdi. eks bare 100%
          if @workers.present?
            sheet.add_row ['', 'Sum timer pr. pers: '] + 
              #[1,2,3] + [nil, nil, nil],
              ExcelProjectTools.hours_for_users(project: @project, 
                overtime: @overtime, of_kind: :billable,
                profession: @profession) + [nil, nil, nil, nil],
                :style => [gray_bg_align_right, gray_bg_align_right, 
                           gray_bg_align_right, gray_bg_align_right, 
                           gray_bg_align_right, gray_bg_align_right, 
                           gray_bg_align_right]    
          else
            sheet.add_row ['', 'INGEN OPPGAVER FINNES HER']
          end

          # Sum timer totalt
          sheet.add_row ['', 'Sum timer totalt: ',
                         @project.hours_spent_total(profession: @profession,
                           overtime: @overtime, of_kind: @of_kind), 
                           nil, nil, nil, nil, nil, nil, nil, 
                           nil, nil, nil, nil],
            :style => [gray_bg_align_right, gray_bg_align_right, 
                       gray_bg_align_right, gray_bg_align_right, 
                       gray_bg_align_right, gray_bg_align_right, 
                       gray_bg_align_right]    
            
    
          sheet.add_row [nil]
          sheet.add_row [nil, 'Attest', '……………', '……………', '……………', '……………'],   
            :style => [nil, attest_style]    
          sheet.add_row [nil]
          sheet.add_row [nil, 'BRUKTE MATERIALER']
    
          # The name of involved Artisans
          ExcelProjectTools.user_names(project: @project,
            profession_title: @profession.title).each_with_index do |user, index|
            (sheet.rows[8].cells[2+index].value = user) rescue nil
          end
    
          
          sheet.column_widths 20, 35, nil, nil #nil, nil, 2
        end
      end
      p.use_shared_strings = true
      p.serialize "tmp/daily_report.xls"
    end
    "tmp/daily_report.xls"
  end

  private
  def offsett(nr)
    r = []
    nr.times do 
      r << ''
    end
    r
  end
end

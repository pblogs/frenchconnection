class ExcelController < ApplicationController
  layout :resolve_layout
  
  require 'spreadsheet'

  def dagsrapport
    @project = Project.find(params[:project_id])
    file_name = Dagsrapport.new(@project).create_spreadsheet
    send_file file_name,
      filename:  "dagsrapport.xls"
  end

  def export
    @project = Project.find(params[:project_id])
                                                                                     
    ##########
    # FORMATS
    #
    yellow_bg = Spreadsheet::Format.new(:pattern => 1, 
                                        :pattern_fg_color => :yellow,
                                        :horizontal_align => :left
                                       )
    
    gray_bg = Spreadsheet::Format.new(:pattern => 1, color: :black,
                                      :pattern_fg_color => :gray)

    align_right_gray_bg = Spreadsheet::Format.new(
      horizontal_align: :right,
      pattern: 1, 
      pattern_fg_color: :gray, 
      color: :black
    )

    #
    # FORMATS END
    ##########
                                                                                     
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    sheet.name = "Dagsrapport #{@project.customer.name}"
    sheet.row(0) << nil 
    sheet.row(1).concat %W{LOGO Dagsrapport}
                                                                                     
    sheet.row(2).concat ['År: ', Time.now.year, 'Pågår']
    sheet.row(3).concat ['Uke: ', DateTime.now.cweek, 'Utført']
    sheet.row(4).concat ['Prosjekt nr: ', @project.project_number]
    sheet.row(5).concat ['Kunde: ', @project.customer.name ]
    4.times { |x| sheet.row(x+2).set_format(1, yellow_bg ) }

    # 5 blanks with C D E F G spanning from 7-11
    sheet.merge_cells(6, 2, 11, 2) # Col C
    sheet.merge_cells(6, 3, 11, 3) # Col D
    sheet.merge_cells(6, 4, 11, 4) # Col E
    sheet.merge_cells(6, 5, 11, 5) # Col F

    sheet.row(6).concat ['', '' ] + ExcelProjectTools.artisan_names(@project)
    
    # Make the C column wide
    sheet.column(1).width = 50
                                                                                     
    # Gray row with Dato:
    sheet.row(11).concat ['Dato: ', '' ]
    sheet.row(11).set_format(0, gray_bg )
    sheet.row(11).set_format(1, gray_bg )
                                                                                     

    i = 1
    ai = -1
    @project.artisans.each do |a|
      ai += 1
      @project.hours_spents.where(artisan: a).each do |h|
        sheet.row(12+i).concat [I18n.l(h.created_at, format: :short_date), h.description] +  offsett(ai) + [h.hour]
        i += 1 
      end
    end


    artisans = @project.artisans.all

    if artisans.present?
      # Sum timer pr pers
      sheet.row(12+i+5).concat ['', 'Sum timer pr. pers: '] + ExcelProjectTools.hours_for_artisans(@project)
      sheet.row(12+i+5).set_format(0, gray_bg )
      sheet.row(12+i+5).set_format(1, gray_bg )
      sheet.row(12+i+5).set_format(1, align_right_gray_bg )
    else
      sheet.row(13+i+5).concat ['', 'INGEN OPPGAVER FINNES HER']
    end
    

    # Sum timer totalt
    sheet.row(13+i+5).concat ['', 'Sum timer totalt: ', 
                              @project.hours_spent_total,
    ]
    sheet.row(13+i+5).set_format(0, gray_bg )
    sheet.row(13+i+5).set_format(1, gray_bg )
    sheet.row(13+i+5).set_format(1, align_right_gray_bg )

    # Attest
    sheet.row(sheet.rows.size+1).concat ['', 'Attest', '.....', '.....', '.....', '.....']
    sheet.row(sheet.rows.size+1).set_format(1, yellow_bg)

    spreadsheet = StringIO.new 
    book.write spreadsheet 
    send_data spreadsheet.string, 
      :filename => "Dagsrapport-#{@project.customer.name}.xls", 
      :type => "application/vnd.ms-excel"

  end

  def sallery
    @artisan = Artisan.find(params[:artisan_id])
    @project = Project.find(params[:project_id])

    require 'rubygems'
    require 'axlsx'
    
    Axlsx::Package.new do |p|
      p.workbook do |wb|
        styles = wb.styles
        header = styles.add_style :sz => 16, :b => true, 
          :i => true, :alignment => {:horizontal => :left}
    
        bold         = styles.add_style b: true, sz: 8
        bold_gray_bg = styles.add_style b: true, bg_color: 'C0C0C0'
        bold_small_text = styles.add_style :b => true, :sz => 8
    
    
        wb.add_worksheet do |sheet|
    
          sheet.add_image(:image_src => 'app/assets/images/Alliero.jpg',
                          :noSelect => true, :noMove => true) do |image|
            image.width=250
            image.height=42
            image.start_at 0,10
          end
    
          sheet.add_row ['Alliero Gruppen', 'Gjerdrums vei 12 A', 'Postboks 4681 Nydalen, 0405 Oslo']
          sheet.add_row ['TIMELISTE'], style: [header]
          sheet.add_row ['ANSATT NAVN:', 'ANSATT NUMMER:', 'FRA DATO: ', 'TIL DATO: '], style: [bold, bold, bold, bold, bold]
          sheet.add_row 
          sheet.add_row ['AVD NR: ', 'PROSJEKTNUMMER: ', 'PROSJEKTNAVN: ', 'PROSJEKTLEDER: '], style: [bold, bold, bold, bold, bold]
          sheet.add_row 
          sheet.add_row [nil, nil, nil, 'Arbeidene timer', 'Overtid', 'Reisepenger', 'Bom', 'Fravær/Ferie/Hellidager etc.']

        end
      end

      p.use_shared_strings = true
      p.serialize "tmp/export.xls"
      send_file "tmp/export.xls", 
        :filename => "Timeliste.xls"
      end
  end

  def html_export
    
    @artisan = Artisan.find(params[:artisan_id])
    @project = Project.find(params[:project_id])
  end

  private
  def offsett(nr)
    r = []
    nr.times do 
      r << ''
    end
    r
  end

  def resolve_layout
    case action_name
    when 'html_export'
      'excel'
    else
      'application'
    end
    
  end

end

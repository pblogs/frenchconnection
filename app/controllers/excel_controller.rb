class ExcelController < ApplicationController
  require 'spreadsheet'

  def export
    @project = Project.find(params[:project_id])
                                                                                     
    yellow_bg = Spreadsheet::Format.new(:pattern => 1, 
                                        :pattern_fg_color => :yellow)
    
    gray_bg = Spreadsheet::Format.new(:pattern => 1, color: :black,
                                      :pattern_fg_color => :gray)
                                                                                     
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet
    sheet.name = "Dagsrapport #{@project.customer.name}"
    sheet.row(0) << nil 
    sheet.row(1).concat %W{LOGO Dagsrapport}
                                                                                     
    sheet.row(2).concat ['År: ', '', 'Pågår']
    sheet.row(3).concat ['Uke: ', '', 'Utført']
    sheet.row(4).concat ['Prosjekt nr: ', '']
    sheet.row(5).concat ['Kunde: ', '', ]
    4.times { |x| sheet.row(x+2).set_format(1, yellow_bg ) }
                                                                                     
    # 5 blanks with C D E F G spanning from 7-11
    sheet.merge_cells(6, 2, 11, 2) # Col C
    sheet.merge_cells(6, 3, 11, 3) # Col D
    sheet.merge_cells(6, 4, 11, 4) # Col E
    sheet.merge_cells(6, 5, 11, 5) # Col F
                                                                                     
    # Make the C column wide
    sheet.column(1).width = 50
                                                                                     
    # Gray row with Dato:
    sheet.row(11).concat ['Dato: ', '' ]
    sheet.row(11).set_format(0, gray_bg )
    sheet.row(11).set_format(1, gray_bg )
                                                                                     
    # Her kommer rapporten
    i = 0
    @project.hours_spents.each do |h|
      sheet.row(12+i).concat [I18n.l(h.created_at, format: :short_date), h.description, h.hour]
      i +=1 
    end
                                                                                     
    #sheet.row(0).concat %w{Name Country Acknowlegement}
    #sheet[1,0] = 'Japan'
    #row = sheet.row(1)
    #row.push 'Creator of Ruby'
    #row.unshift 'Yukihiro Matsumoto'
    #sheet.row(2).replace [ 'Daniel J. Berger', 'U.S.A.',
    #                        'Author of original code for Spreadsheet::Excel' ]
    #sheet.row(3).push 'Charles Lowe', 'Author of the ruby-ole Library'
    #sheet.row(3).insert 1, 'Unknown'
    #sheet.update_row 4, 'Hannes Wyss', 'Switzerland', 'Author'
    
    spreadsheet = StringIO.new 
    book.write spreadsheet 
    send_data spreadsheet.string, 
      :filename => "dagsrapport-#{@project.customer.name}.xls", 
      :type => "application/vnd.ms-excel"
  end

end
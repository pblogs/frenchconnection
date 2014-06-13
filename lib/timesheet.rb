class Timesheet
  require 'rubygems'
  require 'axlsx'

  def initialize(project, user, hours)
    @project = project
    @user = user
    @hours   = hours

    @wday = {
      '1' => 'mandag',
      '2' => 'tirsdag', 
      '3' => 'onsdag',
      '4' => 'torsdag',
      '5' => 'fredag',
      '6' => 'lørdag',
      '7' => 'søndag',
    }
  end

  def create_spreadsheet
    Axlsx::Package.new do |p|
      p.workbook do |wb|

        # STYLES
        styles = wb.styles
        header = styles.add_style :sz => 18, :b => true
        gray_bg_bold_italic_font   = styles.add_style  :b => true, 
          :bg_color => "C0C0C0"
    
        bold_italic  = styles.add_style :b => true, :i => true 
        bold         = styles.add_style :b => true
        bold_center  = styles.add_style :b => true, :alignment => { :horizontal => :center }
        bold_pull_left = styles.add_style :b => true, :alignment => { :horizontal => :left }
        bold_pull_right = styles.add_style :b => true, :alignment => { :horizontal => :right }
        bold_gray_bg = styles.add_style :b => true, :bg_color => 'E2E2E2'
        border       = styles.add_style :border => { style: :medium, color: '000000' }
        bold_gray_bg_center = styles.add_style :b => true, 
          :bg_color => 'E2E2E2', :alignment => { :horizontal => :center }

        gray_bg_align_right = styles.add_style :alignment => { :horizontal => :right }, :bg_color => "E2E2E2"
        attest_style= styles.add_style :alignment => { :horizontal => :right }, :sz => 16
    
    
        # WORKSHEET
        wb.add_worksheet do |sheet|
    
          sheet.add_image(:image_src => 'app/assets/images/Alliero-logo-500x81.png',
                          :noSelect => true, :noMove => true) do |image|
            image.width=345
            image.height=50
            image.start_at 10,0
          end
    
          # HEADER
          sheet.add_row [nil, nil, nil], :style => [bold, bold, bold, bold, bold, bold]
          %w(A1:B1).each { |range| sheet.merge_cells(range) }
          sheet.rows[0].cells[0].value = 'Alliero Gruppen'
          sheet.rows[0].cells[2].value = 'Gjerdrums vei 12 A, Postboks 4681 Nydalen, 0405 Oslo '

          sheet.add_row ['T I M E L I S T E'], :style => [header]
          %w(A2:N2).each { |range| sheet.merge_cells(range) }


# Linje 3 - Ansatt navn
          sheet.add_row [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
            :style => [bold, bold, bold, bold, bold, bold, bold, 
                       bold, bold, bold, bold, bold, 
                       bold, bold, bold], 
                       height: 30

          # Ansatt navn
          %w(A3:E3).each { |range| sheet.merge_cells(range) }

          # Ansatt nr
          %w(F3:J3).each { |range| sheet.merge_cells(range) }

          # FRA DATO, TIL DATO
          %w(K3:O3).each { |range| sheet.merge_cells(range) }

          sheet.rows[2].cells[0].value = 'ANSATT NAVN:'
          sheet.rows[2].cells[5].value = 'ANSATT NR:'
          sheet.rows[2].cells[10].value = 'FRA DATO: __/__-__         TIL DATO: __/__-__'

# Linje 4 
          sheet.add_row [nil]

# Linje 5 
          sheet.add_row [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
            style: [bold, bold, bold, bold, bold, bold, bold, bold, bold, bold, bold, bold]
          # Merge avd nr
          %w(A5:B5).each { |range| sheet.merge_cells(range) }
          # Prosjekt nr
          %w(C5:D5).each { |range| sheet.merge_cells(range) }
          # Prosjekt navn
          %w(E5:J5).each { |range| sheet.merge_cells(range) }
          # Prosjekt leder
          %w(K5:N5).each { |range| sheet.merge_cells(range) }

          sheet.rows[4].cells[0].value = 'AVD. NR:'
          sheet.rows[4].cells[2].value = 'PROSJEKT NR:'
          sheet.rows[4].cells[4].value = 'PROSJEKT NAVN:'
          sheet.rows[4].cells[10].value = 'PROSJEKT LEDER:'


# Linje 6 # Blank
          sheet.add_row [nil]

# Linje 7 # Header
          nil_header = []; 14.times { nil_header.push nil }
          sheet.add_row  nil_header, style: [nil, nil, nil, 
            bold, bold_center, bold_center, bold_center, bold,
            bold, bold, bold, bold, bold]
          # Arbeidene timer
          %w(D7:E7).each { |range| sheet.merge_cells(range) }
          # Overtid
          %w(F7:G7).each { |range| sheet.merge_cells(range) }
          # Reisepenger
          %w(H7:K7).each { |range| sheet.merge_cells(range) }
          # Fravær/Ferie, etc
          %w(M7:N7).each { |range| sheet.merge_cells(range) }

          sheet.rows[6].cells[3].value = 'Arbeidene timer'
          sheet.rows[6].cells[5].value = 'Overtid'
          sheet.rows[6].cells[7].value = '                Reisepenger'
          sheet.rows[6].cells[11].value = 'Bom'
          sheet.rows[6].cells[12].value = 'Fravær/Ferie/Hellidager etc.'

# Linje 8 # Subheader top
          sheet.add_row ['Dato', 'Dag', 'Merknader', 
          'Akkord', 'Ordinære', '50%', '100%', 
          'Gr 1', 'Gr 2', 'Gr 3', 'Gr 4', 
          'Bom-', 'Fraværs-', 'Fraværsgrunn'], 
            style: [
              bold_gray_bg_center, bold_gray_bg_center, bold_gray_bg_center, 
              bold_gray_bg, bold_gray_bg, bold_gray_bg_center, bold_gray_bg_center, 
              bold_gray_bg_center, bold_gray_bg_center, bold_gray_bg_center, bold_gray_bg_center, 
              bold_gray_bg, bold_gray_bg, bold_gray_bg]

# Linje 9 # Subheader bottom
          sheet.add_row [nil, nil, nil, 'timer', 
          'timer', nil, nil, '7.5-15km', '15-30km', 
          '30-45km', '45-60km', 'penger', 'timer', nil], 
            style: [bold_gray_bg, bold_gray_bg, bold_gray_bg, bold_gray_bg, 
                    bold_gray_bg, bold_gray_bg, bold_gray_bg, bold_gray_bg, 
                    bold_gray_bg, bold_gray_bg, bold_gray_bg, bold_gray_bg, 
                    bold_gray_bg, bold_gray_bg, bold_gray_bg, bold_gray_bg, 
                    bold_gray_bg, bold_gray_bg, bold_gray_bg, bold_gray_bg]

# Line 10 # Hours for this user on this project
          @hours.each do |h|
            sheet.add_row  [h.date, @wday["#{h.date.wday}"], h.description, 
            h.piecework_hours, h.hour, h.overtime_50, h.overtime_100]
          end

# Sum
          sheet.add_row [nil]
          sheet.add_row [nil]
          sheet.add_row [nil]
          sheet.add_row [nil, nil, 'Sum',
            ExcelProjectTools.sum_piecework_hours(project: @project, user: @user), 
            ExcelProjectTools.sum_workhours(project: @project, user: @user), 
            ExcelProjectTools.sum_overtime_50(project: @project, user: @user), 
            ExcelProjectTools.sum_overtime_100(project: @project, user: @user), 
            nil, nil, nil, nil, nil, nil, nil],
            style: [nil, bold_gray_bg, bold_gray_bg,
            bold_gray_bg, bold_gray_bg,
            bold_gray_bg, bold_gray_bg,
            bold_gray_bg, bold_gray_bg,
            bold_gray_bg, bold_gray_bg, 
            bold_gray_bg, bold_gray_bg,
            ]

# Akkordoppgjør, kr
          #sheet.add_row ['Akkord-', 'oppgjør', nil, 'kr:', nil, nil, 
          #'Til informasjon: Timelistene skal leveres sist arbeidsdag i måneden.'], 
          #style: [bold_pull_left, bold_pull_right]
          #sheet.add_row [nil, nil, nil, nil]
          #sheet.add_row ['(Akkordseddel må vedlegges)'], style: [bold]



     
          ## Sum timer pr pers
          #users = @project.users.all
          #if users.present?
          #  sheet.add_row ['', 'Sum timer pr. pers: '] + ExcelProjectTools.hours_for_users(@project) + [nil, nil, nil, nil],
          #    :style => [gray_bg_align_right, gray_bg_align_right, 
          #               gray_bg_align_right, gray_bg_align_right, 
          #               gray_bg_align_right, gray_bg_align_right, 
          #               gray_bg_align_right]    
          #else
          #  sheet.add_row ['', 'INGEN OPPGAVER FINNES HER']
          #end

          ## Sum timer totalt
          #sheet.add_row ['', 'Sum timer totalt: ', @project.hours_spent_total, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
          #  :style => [gray_bg_align_right, gray_bg_align_right, 
          #             gray_bg_align_right, gray_bg_align_right, 
          #             gray_bg_align_right, gray_bg_align_right, 
          #             gray_bg_align_right]    
          #  


    
          #sheet.add_row [nil]
          #sheet.add_row [nil, 'Attest', '……………', '……………', '……………', '……………'],   
          #  :style => [nil, attest_style]    
          #sheet.add_row [nil]
          #sheet.add_row [nil, 'BRUKTE MATERIALER']
    
          #sheet.add_row [nil, "What's coming in this month.", nil, nil, "How am I doing"], 
          #:style => tbl_header
          #sheet.add_row [nil, "Item", "Amount", nil, "Item", "Amount"], 
          #:style => [nil, ind_header, col_header, nil, ind_header, col_header]
          #sheet.add_row [nil, "Estimated monthly net income", 500, nil, "Monthly income", "=C9"], 
          #:style => [nil, label, money, nil, label, money]
          #sheet.add_row [nil, "Financial aid", 100, nil, "Monthly expenses", "=C27"], 
          #:style =>  [nil, label, money, nil, label, money]
          #sheet.add_row [nil, "Allowance from mom & dad", 20000, nil, "Semester expenses", "=F19"], 
          #:style =>  [nil, label, money, nil, label, money]
          #sheet.add_row [nil, "Total", "=SUM(C6:C8)", nil, "Difference", "=F6 - SUM(F7:F8)"], 
          #:style => [nil, t_label, t_money, nil, t_label, t_money]
          #sheet.add_row
          #sheet.add_row [nil, "What's going out this month.", nil, nil, "Semester Costs"], 
          #:style => tbl_header
          #sheet.add_row [nil, "Item", "Amount", nil, "Item", "Amount"], 
          #:style => [nil, ind_header, col_header, nil, ind_header, col_header]
          #sheet.add_row [nil, "Rent", 650, nil, "Tuition", 200], 
          #:style =>  [nil, label, money, nil, label, money]
          #sheet.add_row [nil, "Utilities", 120, nil, "Lab fees", 50], 
          #:style =>  [nil, label, money, nil, label, money]
          #sheet.add_row [nil, "Cell phone", 100, nil, "Other fees", 10], 
          #:style =>  [nil, label, money, nil, label, money]
          #sheet.add_row [nil, "Groceries", 75, nil, "Books", 150], 
          #:style =>  [nil, label, money, nil, label, money]
          #sheet.add_row [nil, "Auto expenses", 0, nil, "Deposits", 0], 
          #:style =>  [nil, label, money, nil, label, money]
          #sheet.add_row [nil, "Student loans", 0, nil, "Transportation", 30], 
          #:style =>  [nil, label, money, nil, label, money]
          #sheet.add_row [nil, "Other loans", 350, nil, "Total", "=SUM(F13:F18)"], 
          #:style => [nil, label, money, nil, t_label, t_money]
          #sheet.add_row [nil, "Credit cards", 450], 
          #:style => [nil, label, money]
          #sheet.add_row [nil, "Insurance", 0], 
          #:style => [nil, label, money]
          #sheet.add_row [nil, "Laundry", 10], 
          #:style => [nil, label, money]
          #sheet.add_row [nil, "Haircuts", 0], 
          #:style => [nil, label, money]
          #sheet.add_row [nil, "Medical expenses", 0], 
          #:style => [nil, label, money]
          #sheet.add_row [nil, "Entertainment", 500], 
          #:style => [nil, label, money]
          #sheet.add_row [nil, "Miscellaneous", 0], 
          #:style => [nil, label, money]
          #sheet.add_row [nil, "Total", "=SUM(C13:C26)"], 
          #:style => [nil, t_label, t_money]
          #sheet.add_chart(Axlsx::Pie3DChart) do |chart|
          #  chart.title = sheet["B11"]
          #  chart.add_series :data => sheet["C13:C26"], :labels => sheet["B13:B26"]
          #  chart.start_at 7, 2
          #  chart.end_at 12, 15
          #end
          #sheet.add_chart(Axlsx::Bar3DChart, :barDir => :col) do |chart|
          #  chart.title = sheet["E11"]
          #  chart.add_series :labels => sheet["E13:E18"], :data => sheet["F13:F18"]
          #  chart.start_at 7, 16
          #  chart.end_at 12, 31
          #end
          
          # The name of involved Users
          #ExcelProjectTools.user_names(@project).each_with_index do |a, i|
          #  sheet.rows[8].cells[2+i].value = a
          #end
    
          #
          sheet.column_widths 7,7,nil,nil,9,7,7,7,7,7,7,7,8,15
        end
      end
      prng = Random.new
      @nr = prng.rand(100)       # => 42
      p.use_shared_strings = true
      p.serialize "tmp/timeliste#{@nr}.xls"
    end
    "tmp/timeliste#{@nr}.xls"
  end

  private
  def offsett(nr)
    r = []
    nr.times do 
      r << ''
    end
    r
  end

  def last_row(sheet)
    sheet.rows.size
  end
end

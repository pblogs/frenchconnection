module ApplicationHelper
  def body_id
    "#{controller.controller_name}_#{controller.action_name}"
  end

  def return_users_nr_in_array(array, user: user)
    array.find_index(user)
  end

  def add_remaining_tds(array, user: user)
    array.size - return_users_nr_in_array(@workers, user: user) -1
  end

  def nbsp
    "&nbsp;".html_safe
  end

  def pusher_id
    if ENV["PUSHER_URL"].present?
      ENV["PUSHER_URL"].scan(/\/\/(.{20})\:/).flatten.first
    end
  end

  def dictionary_url
    'http://alliero-dictionary.orwapp.com'
  end

  def alphabet_paginate_prev_next params
    output = ''
    links = ''

    output += javascript_include_tag 'alphabetical_paginate' if params[:js]

    if params[:paginate_all]
      range = params[:language].letters_range
      if params[:others]
        range += ['*']
      end
      if params[:enumerate] && params[:numbers]
        range = (0..9).to_a.map{|x| x.to_s} + range
      elsif params[:numbers]
        range = ['0-9'] + range
      end
      range.unshift 'All' if (params[:include_all] && !range.include?('All'))
      range.each do |l|
        value = params[:language].output_letter(l)
        if l == params[:currentField]
          links += '<li class="active"><a href="#" data-letter="' + l + '">' +
              value + '</a></li>'
        elsif params[:db_mode] or params[:availableLetters].include? l
          links += '<li><a href="?letter=' + l + '" data-letter="' + l + '">' +
                   value + '</a></li>'
        else
          links += '<li class="disabled"><a href="?letter=' + l +
                   '" data-letter="' + l + '">' + value + '</a></li>'
        end
      end
    else
      params[:availableLetters].sort!
      params[:availableLetters] = params[:availableLetters][1..-1] + ['*'] if
          params[:availableLetters][0] == '*'
      params[:availableLetters].unshift 'All' if (params[:include_all] &&
          !params[:availableLetters].include?('All'))
      params[:availableLetters] -= (1..9).to_a.map { |x| x.to_s } unless params[:numbers]
      params[:availableLetters] -= ['*'] unless params[:others]

      curr_letter_index = params[:availableLetters].index(params[:currentField])
      links += '<li><a href="?letter=' +
          params[:availableLetters][curr_letter_index - 1] +
          '" data-letter="' + params[:availableLetters][curr_letter_index - 1] +
          '">«</a></li>' if curr_letter_index > 0

      params[:availableLetters].each do |l|
        value = params[:language].output_letter(l)
        if l == params[:currentField]
          links += '<li class="active"><a href="?letter=' + l +
                   '" data-letter="' + l + '">' + value + '</a></li>'
        else
          links += '<li><a href="?letter=' + l + '" data-letter="' + l +
                   '">' + value + '</a></li>'
        end
      end

      curr_letter_index = params[:availableLetters].index(params[:currentField])
      links += '<li><a href="?letter=' +
          params[:availableLetters][curr_letter_index + 1] +
          '" data-letter="' + params[:availableLetters][curr_letter_index + 1] +
          '">»</a></li>' if
          curr_letter_index < params[:availableLetters].count - 1
    end

    element = params[:bootstrap3] ? 'ul' : 'div'
    (params[:pagination_class] != 'none') ?
        pagination = "<#{element} class='pagination %s alpha' style='height:35px;'>" %
                     params[:pagination_class] :
        pagination = "<#{element} class='pagination alpha' style='height:35px;'>"
    pagination +=
        (params[:bootstrap3] ? '' : '<ul>') +
            links +
            (params[:bootstrap3] ? '' : '</ul>') +
            (params[:bootstrap3] ? '</ul>' : '</div>')

    output += pagination
    output.html_safe
  end
end

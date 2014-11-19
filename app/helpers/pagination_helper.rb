module PaginationHelper
  def alphabet_paginate_prev_next(params)
    output = params[:js] ? javascript_include_tag('alphabetical_paginate') : ''
    output += pagination(links: gen_links(params), params: params)
    output.html_safe
  end

  def gen_links(params)
    params[:paginate_all] ? paginate_all(params) : paginate_without_all(params)
  end

  def paginate_all(params)
    links = ''

    prepare_range(params).each do |l|
      value = params[:language].output_letter(l)
      if l == params[:currentField]
        links += gen_link(letter: l, symbol: value, element_class: 'active')
      elsif params[:db_mode] or params[:availableLetters].include? l
        links += gen_link(letter: l, symbol: value)
      else
        links += gen_link(letter: l, symbol: value, element_class: 'disabled')
      end
    end

    links
  end

  def prepare_range(params)
    range = params[:language].letters_range
    range += ['*'] if params[:others]

    if params[:enumerate] && params[:numbers]
      range = (0..9).to_a.map { |x| x.to_s } + range
    elsif params[:numbers]
      range = ['0-9'] + range
    end

    range.unshift 'All' if (params[:include_all] && !range.include?('All'))
    range
  end

  def paginate_without_all(params)
    prepare_available_letters(params)
    gen_prev_link(params) + gen_letter_links(params) + gen_next_link(params)
  end

  def prepare_available_letters(params)
    params[:availableLetters].sort!
    params[:availableLetters] = params[:availableLetters][1..-1] + ['*'] if
        params[:availableLetters][0] == '*'
    params[:availableLetters].unshift 'All' if (params[:include_all] &&
        !params[:availableLetters].include?('All'))
    params[:availableLetters] -= (1..9).to_a.map { |x| x.to_s } unless
        params[:numbers]
    params[:availableLetters] -= ['*'] unless params[:others]
  end

  def pagination(links:, params:)
    element = params[:bootstrap3] ? 'ul' : 'div'
    pagination_class = (params[:pagination_class] == 'none') ? '' :
                       params[:pagination_class]

    "<#{element} class='pagination #{pagination_class} alpha'" +
        " style='height:35px;'>" +
        (params[:bootstrap3] ? '' : '<ul>') + links +
        (params[:bootstrap3] ? '' : '</ul>') +
        (params[:bootstrap3] ? '</ul>' : '</div>')
  end

  def gen_prev_link(params)
    return '' if params[:currentField].nil?
    curr_letter_index = params[:availableLetters].index(params[:currentField])
    prev_letter = params[:availableLetters][curr_letter_index - 1]
    (curr_letter_index > 0) ? gen_link(letter: prev_letter, symbol: '«') : ''
  end

  def gen_letter_links(params)
    links = ''
    params[:availableLetters].each do |l|
      value = params[:language].output_letter(l)
      links += (l == params[:currentField]) ?
          gen_link(letter: l, symbol: value, element_class: 'active') :
          gen_link(letter: l, symbol: value)
    end
    links
  end

  def gen_next_link(params)
    return '' if params[:currentField].nil?
    curr_letter_index = params[:availableLetters].index(params[:currentField])
    next_letter = params[:availableLetters][curr_letter_index + 1]
    curr_letter_index < params[:availableLetters].count - 1 ?
        gen_link(letter: next_letter, symbol: '»') : ''
  end

  def gen_link(letter:, symbol:, element_class: '')
    "<li class=\"#{element_class}\"><a href=\"?letter=#{letter}\"" +
        " data-letter=\"#{letter}\">#{symbol}</a></li>"
  end
end

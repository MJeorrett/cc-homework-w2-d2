require('pry-byebug')

class String

  def colourise(text_code, background_code, bold=false)
    bold_modifier = ''
    bold_modifier = '1;' if bold

    return "\e[#{bold_modifier}#{text_code};#{background_code}m#{self}\e[0m"
  end

  def colourise_chars(chars, text_code, background_code, bold=false)
    chars.each { |char| self.gsub!(/#{char}/, char.colourise(text_code, background_code, bold)) }
  end

end

class NumbersInWords::ToWord
  def initialize that, language=NumbersInWords.language
    @that = that
    @language = language
  end

  def in_words language=nil
    language ||= @language

    case language
    when "English" #allow for I18n
      in_english
    when "USD"
      in_usd
    end
  end

  def in_english
    NumbersInWords::English::LanguageWriterEnglish.new(@that).in_words
  end

  def in_usd
    post_process NumbersInWords::USD::LanguageWriterUSD.new(@that).in_words, 'USD'
  end

  def post_process(output, language)
    case language
    when 'USD'
      NumbersInWords::USD::LanguageWriterUSD.post_process(output)
    else
      output
    end
  end
end

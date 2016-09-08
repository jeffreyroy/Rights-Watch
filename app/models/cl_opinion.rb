# Class to represent a CourtListener opinion
class CLOpinion
  attr_reader :name, :cite, :year, :full_text

  def initialize( params = {} )
    @name=params[:name]
    @cite=params[:cite]
    date=params[:date_decided]
    if date
      @date_decided=Date.parse(date)
    end
    @full_text=params[:full_text]
  end

  # Return full Bluebook citation
  def full_citation
    "#{@name} #{@cite} (#{@date_decided.year})"
  end

end

# Class to represent a CourtListener opinion
class CLOpinion
  attr_reader :name, :cite, :date_decided, :full_text
  attr_accessor :id

  def initialize( params = {} )
    @id=params[:id]
    @name=params[:name]
    @cite=params[:cite]
    date=params[:date_decided]
    if date
      @date_decided=Date.parse(date)
    end
    @full_text=params[:full_text]
  end

  def init_from_id
    if @id
      c = CourtListener.new
      params = c.case_data_by_opinion_id(@id)
      p "*"*80
      p params
      @name=params[:name]
      @cite=params[:cite]
      date=params[:date_decided]
      if date
        @date_decided=Date.parse(date)
      end
      @full_text=params[:full_text]
    end
  end

  # Return full Bluebook citation
  def full_citation
    cite = @name
    cite += ", #{@cite}" if @cite
    cite += " #{@date_decided.year}" if @date_decided

  end

  def formatted_text
    @full_text.split("/n").join("</p><p>")
  end

end

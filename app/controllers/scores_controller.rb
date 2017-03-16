class ScoresController < ApplicationController
  def index
  end

  def csv
    csv_string = Score.sorted.map { |s| "\n#{s.points},\"#{s.character}\"" }.join
    render plain: csv_string
  end
end
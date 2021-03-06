class ScoresController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @scores = Score.sorted
  end

  def csv
    csv_string = Score.sorted.map { |s| "\n#{s.points},\"#{s.character}, #{s.entry}\"" }.join
    render plain: csv_string
  end

  def submit_score
    player = Player.find_by(name: params[:username],
                            auth_token: params[:auth_token])
    character, entry = params[:entry].split(", ", 2)
    version = Version.find_or_create_by(string: params[:version])
    score = Score.new(player: player, points: params[:score], character: character,
                      entry: entry, version: version)
    head(score.save ? :ok : :bad_request)
  end
end

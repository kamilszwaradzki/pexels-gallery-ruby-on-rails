require 'httparty'
class StaticPagesController < ApplicationController
  include HTTParty
  BASE_URL = "https://api.pexels.com/v1/collections"

  def home
    return unless params[:collection_id].present?

    response = HTTParty.get(
      "#{BASE_URL}/#{params[:collection_id]}",
      headers: { "Authorization" => Rails.application.credentials.pexels[:api_key] }
    )

    if response.success?
      @photos = response["media"] # Pexels returns "media" array for collections
    else
      flash.now[:alert] = "Unable to fetch collection. Check the ID."
    end
  end
end

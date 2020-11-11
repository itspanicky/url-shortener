class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    # Find top 100 most clicked short_urls and render their full_url
    @short_urls = ShortUrl.order(:click_count).limit(100).pluck(:full_url)
    render :json => {:urls => @short_urls }, :status => 200
  end

  def create
  end

  def show
  end

end

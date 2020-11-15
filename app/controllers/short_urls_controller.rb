class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    # Find top 100 most clicked short_urls and render their full_url
    @short_urls = ShortUrl.order(:click_count).limit(100).pluck(:full_url)
    render :json => {:urls => @short_urls }, :status => 200
  end

  def create
    @short_url = ShortUrl.new(url_params)
    if @short_url.save
      UpdateTitleJob.perform_later(@short_url.id)
      render :json => { :short_code => @short_url.short_code}, status => 200
    else
      # If full_url is not valid, render error message, "Full url is not a valid url"
      render :json => {:errors => @short_url.errors[:full_url]}, :status => 400
    end
  end

  def show
    @short_url = ShortUrl.find_by_short_code(params[:id])

    if @short_url
      @short_url.update(click_count: @short_url.click_count + 1)
      redirect_to @short_url.full_url
    else
      render :json => {:errors => "Url not-found"}, :status => 404
    end
  end

  private

  def url_params
    params.permit(:full_url)
  end

end

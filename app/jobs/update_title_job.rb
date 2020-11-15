require "mechanize"

class UpdateTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url_id)
    @short_url = ShortUrl.find_by(id: short_url_id)
    @short_url.title = Mechanize.new.get(@short_url.full_url).title
    @short_url.save!
  end
end

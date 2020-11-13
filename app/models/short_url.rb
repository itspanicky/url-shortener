class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url

  def short_code
    self[:id].to_s(26)
  end

  def update_title!
  end

  def public_attributes
    self[:full_url]
  end

  private

  def validate_full_url
  end

end

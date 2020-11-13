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
    if URI.parse(self[:full_url]) && URI.parse(self[:full_url]).host
      true
    else
      errors.add(:full_url, "Full url is not a valid url")
    end
  end

end

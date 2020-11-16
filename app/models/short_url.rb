require "mechanize"

class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url

  def short_code
    if validate_full_url
      (self[:id] * 512).to_s(26)
    else
      nil
    end
  end

  def update_title!
    self[:title] = Mechanize.new.get(self[:full_url]).title
  end

  def public_attributes
    self[:full_url]
  end

  def self.find_by_short_code(short_code)
    self.find_by(id: short_code.to_i(26) / 512)
  end

  private

  def validate_full_url
    if self[:full_url].blank?
      errors.add(:full_url, "can't be blank")
      false
    else
      encoded_uri = URI.encode(self[:full_url])
      if URI.parse(encoded_uri) && URI.parse(encoded_uri).host
        true
      else
        errors.add(:full_url, "Full url is not a valid url")
        errors.add(:full_url, "is not a valid url")
        false
      end
    end
  end

end

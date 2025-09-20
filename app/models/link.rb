# frozen_string_literal: true

class Link < ApplicationRecord
  before_validation :normalize_original_url, :generate_short_code

  validates :original_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :short_code, presence: true, uniqueness: true
  validates :clicks, numericality: { greater_than_or_equal_to: 0 }

  private

  def normalize_original_url
    return if original_url.blank?

    self.original_url = original_url.strip
  end

  def generate_short_code
    self.short_code ||= loop do
      code = SecureRandom.alphanumeric(6)
      break code unless Link.exists?(short_code: code)
    end
  end
end

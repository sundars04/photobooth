class Post < ApplicationRecord
  validates :image, presence: true
  validates :caption, presence:true, length: {minimum: 3}

  has_attached_file :image, styles: { medium: "640x", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates_attachment_size :image, :less_than => 2.megabytes
end

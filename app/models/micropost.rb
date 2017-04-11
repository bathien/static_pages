class Micropost < ApplicationRecord
  belongs_to :user
  default_scope ->{order created_at: :desc}
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.max_content_length}
  validate :validate_picture_size
  mount_uploader :picture, PictureUploader

  private

  def validate_picture_size
    if picture.size > Settings.picture.max_picture_size.megabytes
      errors.add :picture, I18n.t(".micropost.err_picture_size")
    end
  end
end

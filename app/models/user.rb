class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_and_belongs_to_many :publications
  mount_uploader :avatar, AvatarUploader
  after_save :log_storage_type
  enum :role, [:normal_user, :admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private
  def log_storage_type
    Rails.logger.debug "Storage: #{AvatarUploader.storage}"
  end
end

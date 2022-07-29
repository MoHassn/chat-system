class Application < ApplicationRecord
  after_initialize :init
  validates_presence_of :name, :token
  has_many :chats, dependent: :destroy

  def init
    self.token  ||= SecureRandom.uuid
  end
end

class Application < ApplicationRecord
  after_initialize :init
  validates_presence_of :name, :token

  def init
    self.token  ||= SecureRandom.uuid
  end
end

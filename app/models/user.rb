class User < ActiveRecord::Base
  attr_accessible :access, :auth_at, :auth_token, :email, :provider, :uid, :name
  
  def self.from auth
    User.where(uid: auth[:uid], provider: auth[:provider]).first_or_create!({
      email: auth[:info][:email],
      name: auth[:info][:name],
      access: true
    })
  end
  
  def update_auth_token
    self.auth_at = Time.now
    self.auth_token = SecureRandom.hex
    save!
    auth_token
  end
  
  def clear_auth_token
    self.auth_at = nil
    self.auth_token = nil
    save!
  end
  
  def auth_token_expired?
    auth_at < 1.day.ago
  end
end

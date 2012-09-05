class User < ActiveRecord::Base
  attr_accessible :oauth_token, :auth_at, :auth_token, :email, :provider, :uid, :name
  
  def self.from auth
    User.where(uid: auth[:uid], provider: auth[:provider]).first_or_create!({
      name: auth[:info][:name],
      oauth_token: auth[:credentials][:token]
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
  
  def has_access?
    is_admin? || is_allowed?
  end
  
  def is_admin?
    admin.id == id
  end
  
  def is_allowed?
    facebook = Koala::Facebook::API.new(admin.oauth_token)
    members = facebook.get_connections("10151006453916946", "members").map{|member| member["id"]}
    members.include? uid
  end
  
  def admin
    @admin ||= User.where(uid: "520391945").first
  end
end

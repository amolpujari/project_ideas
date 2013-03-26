class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :token, :uid, :user_id

  def self.welcomes req_auth
    auth = Authentication.find_by_provider_and_uid req_auth['provider'], req_auth['uid']

    auth ||= Authentication.create :provider=>req_auth['provider'], :uid=>req_auth['uid'], :token=> req_auth['credentials']['token']

    user = auth.user || User.find_or_create_by_email(req_auth.info.email)

    user.extract_and_assign_user_info req_auth
    user.save :validate => false

    auth.user_id = user.id
    return auth if auth.save
    
    nil
  end
end


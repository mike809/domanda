module UsersHelper

	def is_password?(password_digest, plain_text)
		BCrypt::Password.new(password_digest) == plain_text
	end

	def gravatar_for(user, options = { size: 100 })
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.username, class: "gravatar")
  end

end

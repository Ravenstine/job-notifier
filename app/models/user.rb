class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :agents, dependent: :destroy
  has_many :listings, through: :agents, dependent: :destroy
  has_one :identity, through: :destroy
  has_many :appointments

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)


    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

 # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          first_name: auth.info.first_name,
          last_name: auth.info.last_name,
          #username: auth.info.nickname || auth.uid,
          # email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          email: auth.info.email,
          image: auth.info.image,
          linked_in: auth.info.urls.public_profile,
          password: Devise.friendly_token[0,20]
        )
        # user.skip_confirmation!
        user.save
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user

  end

  def email_verified?
    # self.email && self.email !~ TEMP_EMAIL_REGEX
    true
  end

  def accepts_new_agents?
    !(agents.count == max_agents)
  end

  def agents_with_extra_data
    query = "
      SELECT agents.*, 
      (SELECT locations.city FROM locations WHERE id=agents.location_id) AS location_name, 
      (SELECT COUNT(*) FROM agents_listings WHERE agent_id=agents.id) AS jobs_found FROM agents
      WHERE user_id=#{id}
    "
    result = ActiveRecord::Base.connection.exec_query(query)
    result.map{|a| Agent.new(a)}
  end

end

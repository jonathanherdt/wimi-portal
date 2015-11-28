class User < ActiveRecord::Base
  before_create :default_values

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :holiday
  has_many :expense
  has_many :project_applications, dependent: :destroy
  has_many :trips
  # has_many :chairs_administrators
  # has_many :chairs, through: :chairs_administrators
  # has_many :chairs_wimis
  # has_many :chairs, through: :chairs_wimis
  # has_many :chairs_candidates
  # has_many :chairs, through: :chairs_candidates
  has_and_belongs_to_many :publications
  has_and_belongs_to_many :projects

  has_many :chair_admins;
  has_many :chairs, through: :chair_admins;

  has_many :chair_representatives;
  has_many :chairs, through: :chair_representatives;

  def name
    "#{first} #{last_name}"
  end

  def name=(fullname)
    first, last = fullname.split(' ')
    self.first = first
    self.last_name = last
  end

  enum role: [ :superadmin, :admin, :wimi, :hiwi, :user ]

  private
    def default_values
      self.role ||= :user
    end
end

class SettingsForm < Form

  attr_accessor :id, :username, :email, :language

  validates_inclusion_of :language, :in => %w( en cs ), :message => I18n.t("users.language_has_to_be")

  def initialize(attributes = {})
    return if attributes.blank?

    @user = User.find(attributes[:id])
    attributes.delete(:id)

    store(attributes)
    @user.update(attributes)
  end

  def submit
    valid? && @user.save
  end

end
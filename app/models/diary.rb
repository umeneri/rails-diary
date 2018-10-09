class Diary < ApplicationRecord
  has_many :characters

  def save_with_characters
    person_names = CotohaClient.get_person_names(body)

    ActiveRecord::Base.transaction do
      save!

      person_names.each do |name|
        self.characters.create!(name: name, user_id: user_id)
      end

      return true
    rescue ActiveRecord::RecordInvalid
      return false
    end
  end
end

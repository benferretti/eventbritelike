class Event < ApplicationRecord
    has_many :attendances
    has_many :users, through: :attendances
    belongs_to :user
    



    validates :start_date, presence: true
    validates :duration, numericality: { greater_than: 4, less_than_or_equal_to: 30 }
    validates :title, length: {minimum: 5, maximum: 140}, allow_blank: false
    validates :description, length: {minimum: 20, maximum: 1000}, allow_blank: false
    validates :price, numericality: { greater_than: 0, less_than_or_equal_to: 1000 }
    validates :location, presence: true


    validate :duration_multiple_of_five?
    validate :deadline_is_possible?



    def duration_multiple_of_five?
        if (duration % 5) != 0
        errors.add(:deadline, 'must be multiple of 5')
        end
    end

    def deadline_is_possible?
        if start_date < Time.now
        errors.add(:deadline, 'must be possible')
        end
    end

end

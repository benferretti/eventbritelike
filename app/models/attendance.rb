class Attendance < ApplicationRecord
    belongs_to :event
    belongs_to :user

    validates_uniqueness_of :event_id, scope: :user_id

    #after_create :attendance_send

  def attendance_send
    AttendanceMailer.event_admin_email(self).deliver_now
  end
end

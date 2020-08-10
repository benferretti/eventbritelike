class Attendance < ApplicationRecord
    belongs_to :event
    belongs_to :user

    after_create :attendance_send

  def attendance_send
    AttendanceMailer.event_admin_email(self).deliver_now
  end
end

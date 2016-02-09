class AddColumnDateTimeExpired < ActiveRecord::Migration
  def change
    add_column(:disponibilites, :date_time_expired, :datetime)
  end
end

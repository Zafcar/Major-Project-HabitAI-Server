class Streak < ApplicationRecord
  belongs_to :user

  def increment # rubocop:disable Metrics/AbcSize
    return update(count: count + 1) if created_at.to_date == Date.today && count.zero?

    return if Date.today == updated_at.to_date

    update(count: count + 1) if Date.today - 1 == updated_at.to_date
  end

  def reset
    update(count: 0) if updated_at.to_date < Date.today - 1
  end
end

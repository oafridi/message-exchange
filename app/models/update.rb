class Update < ActiveRecord::Base
  belongs_to :user
  validates :body, length: {minimum: 1, maximum: 140}

  def time_since
    current_time = Time.now.getlocal
    created_at = self.created_at.getlocal
    elapsed_seconds = (current_time - created_at).to_i
    days = elapsed_seconds / (24 * 60 * 60)
    hours = ( elapsed_seconds % (24 * 60 * 60) ) / (60 * 60)
    minutes = ( elapsed_seconds % (60 * 60 ) ) / (60)
    seconds = ( elapsed_seconds % 60 )

    if days == 1
      return "#{days} day"
    elsif days > 1
      return "#{days} days"
    elsif hours == 1
      return "#{hours} hour"
    elsif hours > 1
      return "#{hours} hours"
    elsif minutes == 1
      return "#{minutes} minute"
    elsif minutes > 1
      return "#{minutes} minutes"
    elsif seconds == 1
      return "#{seconds} second"
    else
      return "#{seconds} seconds"
    end
  end


  def hashtags
    matches = self.body.scan(/([#]\w+)/)
    if matches.empty?
      return nil
    else
      matches.flatten
    end
  end
end

class Admin < ApplicationRecord
  def self.check_for_access(resp)
    if Admin.where("email = ?", resp.info.email).first.nil?
      return false
    end
    return true
  end
end

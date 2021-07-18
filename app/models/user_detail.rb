class UserDetail < ApplicationRecord

  after_create :calculate_credibility_credit_limit

  def calculate_credibility_credit_limit
    CreditApprovalJob.perform_now(self)
  end

  def update_details(credit_limit, status)
    update_attributes(credit_limit: credit_limit, status: status)
  end
end

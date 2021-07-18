class CreditApprovalJob < ApplicationJob
  queue_as :default

  def perform(user)

   maximum_possible_emi = (user.mo_in_flow/2 - user.mo_out_flow)

    term_in_months = case maximum_possible_emi
      when 0..5000
        6
      when 5001..10000
        12
      when 10001..20000
        18
      when maximum_possible_emi > 20000
        24
      else
        0
      end

    credit_limit = maximum_possible_emi * term_in_months

    response = FullcontactService.get_fullcontact_api(user.email)
    point = 0
    unless response.blank?
      response[:socialProfiles].each do |profile|
        point = (point + 1) if profile && profile[:typeId].present?
      end

      if UserDetail.where(email: user.email, status: "APPROVE").count > 0
        point = point + 1
      end

      status = point > 2 ? "APPROVE" : "REJECT"
      user.update_details(credit_limit,status)
    end
  end
end
class EpaycoController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:confirmation]

  def result
    url =  "https://secure.epayco.co/validation/v1/reference/#{params[:ref_payco]}"
    response = HTTParty.get(url)

    parsed = JSON.parse(response.body)
    puts parsed
  end

  def confirmation
  end
end

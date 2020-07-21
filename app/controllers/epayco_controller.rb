class EpaycoController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:confirmation]

  def result
    url =  "https://secure.epayco.co/validation/v1/reference/#{params[:ref_payco]}"
    response = HTTParty.get(url)

    parsed = JSON.parse(response.body)
    if parsed["success"]
      @data = parsed["data"]
      @charge = Charge.where(uid: @data["x_id_invoice"]).take
    else
      @error = "No se pudo consultar la información"
    end
  end

  def confirmation
  end
end

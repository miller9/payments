class PayuController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:confirmation]

  def result
    @charge = Charge.where(uid: params[:referenceCode]).take
    if charge.nil?
      @error = "No se encontró la información del pago"
    else
      if params[:signature] != signature(@charge, params[:transactionState])
        @error = "La firma no es válida.."
      end
    end
  end

  def confirmation
    charge = Charge.where(uid: params[:reference_sale]).take
    # return code to PayU
    if charge.nil?
      head :unprocessable_entity
      return
    end
    if params[:sign] == signature(charge, params[:state_pol])
      head :ok
    else
      head :unprocessable_entity
    end
  end


  private
    def signature(charge)
      msg = "#{ENV["PAYU_API_KEY"]}~#{ENV["PAYU_MERCHANT_ID"]}~#{charge.uid}~#{charge.amount}~COP~#{state}"
      Digest::MD5.hexdigest(msg)
    end
end

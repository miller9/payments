class ChargesController < ApplicationController

  def index
    @charges = Charge.all
  end

  def new
    @charge = Charge.new
  end

  def create
    @charge = Charge.new(charge_params)
    if @charge.save
      @signature = signature(@charge)
      render :payu
    else
      # ..Pending -> show errors
      render :new
    end
  end

  private
    def charge_params
      params.require(:charge).permit(:amount)
    end

    def signature(charge)
      msg = "#{ENV["PAYU_API_KEY"]}~#{ENV["PAYU_MERCHANT_ID"]}~#{charge.uid}~#{charge.amount}~COP"
      Digest::MD5.hexdigest(msg)
    end

end

class EpaycoController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:confirmation]

  def result
  end

  def confirmation
  end
end

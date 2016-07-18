class ErrorsController < ApplicationController
  def forbidden
    render :status => 403
  end

  def not_found
    render :status => 404
  end

  def conflict
    render :status => 409
  end

  def unprocessable
    render :status => 422
  end

  def internal
    render :status => 500
  end
end

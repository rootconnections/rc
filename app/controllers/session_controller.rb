# frozen_string_literal: true

class SessionController < ApplicationController
  def new
    redirect_to customer_dashboard_path if current_customer
  end

  def create
    credentials = params[:session]
    result = API.authenticate_customer(credentials)

    if result.empty?
      redirect_to customer_sign_in_path, alert: t('authentication.bad_email_password')
    else
      session[:current_customers] = result.to_json
      redirect_to webstore_path
    end
  end

  def destroy
    sign_out
  end

private

  def current_webstore_id
    params[:webstore_id]
  end
end

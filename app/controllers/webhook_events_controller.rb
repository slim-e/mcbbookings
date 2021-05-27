# frozen_string_literal: true

class WebhookEventsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    unless valid_signatures?
      render json: {message: "Invalid sigs", status: 400}
      return # 200
    end

    # idempotent
    unless WebhookEvent.find_by(source: params[:source], external_id: external_id).nil?
      render json: {message: "Already processed event #{external_id}"}
      return # 200
    end

    event = WebhookEvent.create(webhook_params)
    ProcessEventsJob.perform_later(event.id)

    render json: params
  end

  private

  def valid_signatures?
    if params[:source] == "stripe"
      begin
        wb_secret = Rails.configuration.stripe[:wh]

        Stripe::Webhook.construct_event(
          request.body.read,
          request.env["HTTP_STRIPE_SIGNATURE"],
          wb_secret
        )
      rescue Stripe::SignatureVerificationError => e
        return false
      end
    end

    true
  end

  def webhook_params
    {
      source: params[:source],
      data: params.except(:source, :action, :controller).permit!,
      external_id: external_id,
      state: :pending
    }
  end

  def external_id
    return params[:id] if params[:source] == "stripe" # "evt_xxxx"

    SecureRandom.hex
  end
end

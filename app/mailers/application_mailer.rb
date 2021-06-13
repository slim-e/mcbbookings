# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "Thibault Marino <resa@mmacampbrazil.com>"
  layout "mailer"
end

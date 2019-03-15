require "rails_helper"

RSpec.describe FeedbackMailer, type: :mailer do
  describe "message" do
    let(:mail) { FeedbackMailer.message }

    it "renders the headers" do
      expect(mail.subject).to eq("Message")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end

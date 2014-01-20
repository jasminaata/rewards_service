require 'spec_helper'

describe AccountManagement::RewardsService do 
  describe "it checks customer rewards" do
    let(:account) { 000731 }
    let(:subscriptions) { ["Sports", "Kids", "Music"] }
    let(:rewards_service) { AccountManagement::RewardsService.new(account, subscriptions) }

    context "account is eligible" do
      let(:eligibility_service) { 
        double(CustomerStatus::EligibilityService, 
          output: "CUSTOMER_ELIGIBLE",
          description: "Customer is eligible") 
      } 
      it "outputs rewards data" do
        rewards_service.perform.should == ["CHAMPIONS_LEAGUE_FINAL_TICKET", "KARAOKE_PRO_MICROPHONE"]
      end
    end

    context "account is not eligible" do
      let(:eligibility_service) { 
        double(CustomerStatus::EligibilityService, 
          output: "CUSTOMER_INELIGIBLE",
          description: "Customer is not eligible")
      } 

      it "outputs ineligibility message" do
        rewards_service.perform.should == "Customer is not eligible"
      end
    end

    context "there is technical error" do
      let(:eligibility_service) { 
        double(CustomerStatus::EligibilityService, 
        output: "Technical failure exception",
        description: "Service technical failure") 
      } 

      it "outputs technical failure message" do
        rewards_service.perform.should == "Service technical failure"
      end
    end

    context "account is not valid" do
      let(:eligibility_service) { 
        double(CustomerStatus::EligibilityService, 
          output: "Invalid account number exception",
          description: "The supplied account number is invalid") 
      }

      it "outputs invalid account message" do
        rewards_service.perform.should == "The supplied account number is invalid"
      end
    end
  end  
end
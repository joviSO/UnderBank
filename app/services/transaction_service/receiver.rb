class TransactionService::Receiver < ApplicationService
  attr_accessor :account_id, :value

  def initialize(account_id, value)
    @account = Account.find(account_id)
    
    
  end
end
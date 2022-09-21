class TransactionService::Depositor < ApplicationService
  attr_reader :account_id, :value, :name, :phone

  def initialize(account_id, value, name, phone)
    @account = Account.find(account_id)
    @account_id = account_id
    @value = value
    @name = name
    @phone = phone
  end

  def call
    @transaction = Transaction.create(transaction_value: @value,
                                      depositor_name: @name,
                                      depositor_phone: @phone,
                                      account_id: @account_id,
                                      transaction_kind: "depositar")
    new_balance = @account.balance + @value.to_i
    @account.update(balance: new_balance)

    { success: true, message: "Deposito Realizado com sucesso", transaction: @transaction.account_id }
  rescue StandardError => e
    { success: false, error: e.message  }
  end
end

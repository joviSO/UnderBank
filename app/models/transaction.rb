class Transaction < ApplicationRecord
  belongs_to :account

  after_save :do_transaction_on_balance

  validates_numericality_of :transaction_value,
                            greater_than: 0,
                            message: "validos apenas numeros maiores que 0 (zero)"
  validates :depositor_name, :depositor_phone, 
            presence: { message: "campo não pode ficar em branco" },
            if: proc{ |p| p.transaction_kind == "depositar"}

  def do_transaction_on_balance
    if self.status == "efetuado"
      if self.transaction_kind == "depositar"
        account = Account.find(self.account_id)
        new_balance = account.balance + self.transaction_value
        account.update(balance: new_balance)
      elsif self.transaction_kind == "sacar"
        account = Account.find(self.account_id)
        new_balance = account.balance - self.transaction_value
        account.update(balance: new_balance)
      elsif self.transaction_kind == "transferir"
        give_account = Account.find(self.account_id)
        recive_account = Account.find(self.transfer_account)
        
        new_balance_give_account = give_account.balance - self.transaction_value
        new_balance_recive_account = (recive_account.balance + self.transaction_value) - tax
      end
    end
  end
end

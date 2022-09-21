class Transaction < ApplicationRecord
  belongs_to :account

  validates_numericality_of :transaction_value,
                            greater_than: 0,
                            message: "validos apenas numeros maiores que 0 (zero)"
  
  validates :depositor_name, :depositor_phone, 
            presence: { message: "campo não pode ficar em branco" },
            if: -> () { transaction_kind == "depositar" }

end

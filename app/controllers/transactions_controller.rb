class TransactionsController < ApplicationController
  skip_before_action :authenticate_client!, only: %i[ new_deposit create_deposit show ]
  
  def new_deposit
    @transaction = Transaction.new
  end
  
  def create_deposit
    deposit_service_response = TransactionService::Depositor.call(
      transaction_params[:account_id],
      transaction_params[:transaction_value],
      transaction_params[:depositor_name],
      transaction_params[:depositor_phone]
    )

    respond_to do |format|
      if deposit_service_response[:success]
        format.html { redirect_to transaction_url(id: deposit_service_response.transaction.id), notice: "transaction was successfully created." }
        format.json { render :show, status: :created, location: deposit_service_response.transaction } 
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }  
      end
    end
  end

  def show
  end

  def new_withdraw
    @transaction = Transaction.new
  end

  def create_withdraw
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transaction_url(@transaction), notice: "transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new_withdraw, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def transaction_params
      params.require(:transaction)
            .permit(:transaction_value, 
                    :transaction_kind, 
                    :depositor_name, 
                    :depositor_phone,
                    :transaction_status,
                    :transfer_account,
                    :account_id)
    end

    def account_params
      params.require(:account)
            .permit(:balance,
                    :agency,
                    :client_id)
    end
    
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end


    def client_logged
      unless @account.client_id == current_client.id
        render json: {error: { message: 'Cliente errado' }}, status: :unprocessable_entity
      end
    end    
end

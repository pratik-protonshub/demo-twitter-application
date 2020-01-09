class Api::V1::User::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.valid_password?(params[:user][:password])
      @token = Tiddle.create_and_return_token(user, request)
      render json: { message: 'User logged in successfully', auth_token: @token, status: 200 }
    end
  end

  # DELETE
  def destroy
    Tiddle.expire_token(current_user, request) if current_user
    render json: {}
  end
end

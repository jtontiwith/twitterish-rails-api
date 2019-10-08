class SessionsController < Devise::SessionsController
  def create
    puts 'i am getting hit!'
    user = User.find_by_email(sign_in_params[:email])
    puts user
    if user && user.valid_password?(sign_in_params[:password])
      @current_user = user
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end
end
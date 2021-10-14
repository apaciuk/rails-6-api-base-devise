module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      protect_from_forgery with: :exception, unless: :json_request?
      include Api::Concerns::ActAsApiRequest
      def new
        user = User.new sign_up_params
        if user.save
          render JSON("Signed up OK!")
        else
          render = render JSON("Sorry there is an error")
        end
      end

      private

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation,
                                     :username, :first_name, :last_name)
      end

      def render_create_success
        render :create
      end
    end
  end
end

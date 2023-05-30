class ProfilesController < ApplicationController
  def edit
  end

  def update
    if current_user.update_with_password(profile_params)
      bypass_sign_in(current_user)
      flash[:notice] = I18n.t('profile.password_updated')
      respond_to do |format|
        format.html { redirect_to profile_path }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace('user-form', partial: 'profiles/form', locals: { user: current_user }),
            turbo_stream.replace('flash', partial: 'components/flash', locals: { flash: flash })
          ]
        end
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('user-form', partial: 'profiles/form', locals: { user: current_user })
        end
      end
    end
  end

  private

  def profile_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end

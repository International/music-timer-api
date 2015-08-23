module RestControllable
  extend ActiveSupport::Concern
  included do

    before_action :find_object, only: [:update, :destroy, :show]

    def index
      render json: self.model_context
    end

    def show
      render json: self.current_instance
    end

    def destroy
      self.current_instance.destroy
      render nothing: true, status: :no_content
    end

    protected

    attr_accessor :current_instance

    def render_errors
      render(json: { errors: self.current_instance.errors },
        status: :unprocessable_entity)
    end

    def model_context
      raise NotImplementedError
    end

    def find_object
      self.current_instance = model_context.find_by_id(params[:id])
      if self.current_instance.blank?
        render(status: :not_found, nothing: true) and return false
      end
    end

  end
end

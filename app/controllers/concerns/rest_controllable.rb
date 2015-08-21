module RestControllable
  extend ActiveSupport::Concern
  included do

    before_action :find_object, only: [:update, :destroy, :show]

    def show
      render self.current_instance
    end

    def destroy
      self.current_instance.destroy
      render nothing: true, status: :no_content
    end

    protected

    attr_accessor :current_instance

    def model_class
      raise NotImplementedError
    end

    def find_object
      self.current_instance = model_class.find_by_id(params[:id])
      if obj.blank?
        render(status: :not_found, nothing: true) and return false
      end
    end

  end
end

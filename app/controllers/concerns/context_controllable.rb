module ContextControllable
  extend ActiveSupport::Concern
  included do
    prepend_before_action :set_context

    protected

    attr_accessor :current_session

    def current_user
      self.current_session.user
    end

    def filter_protected_session
      self.current_session = ContextStore.instance.current_session
      if self.current_session.blank?
        render(nothing: true, status: :forbidden) and return false
      end
    end

    def set_context
      ContextStore.instance.session_token = request.headers["X-Auth-Token"]
    end
  end
end

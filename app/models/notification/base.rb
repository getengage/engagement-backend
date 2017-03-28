module Notification
  class Base < ActiveRecord::Base
    self.table_name = "notifications"

    def message
      I18n.t("message", {scope: translation_scoping}.merge(data.symbolize_keys))
    end

    protected

    def translation_scoping
      [:notifications, model_name.i18n_key]
    end
  end
end

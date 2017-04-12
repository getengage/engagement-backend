module Dashboard
  class SettingsController < ApplicationController
    before_action :hide_subnav

    def index
      @api_keys = current_user.api_keys
      redux_store("SettingsStore", props: {
        user_id: current_user.id,
        source: v1_api_keys_path,
        data: @api_keys.map{ |x|
          x.attributes.merge(source: v1_api_key_path(x.uuid, user_id: current_user.id))
        }
      })
    end
  end
end

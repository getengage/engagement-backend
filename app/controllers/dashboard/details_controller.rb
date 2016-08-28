module Dashboard
  class DetailsController < ApplicationController
    def show
      if @api_key = ApiKey.find_by_uuid(api_key_param)
        @result = Event::Score.find(uid_param)
      end
      @data = {
        labels: ["January", "February", "March", "April", "May", "June", "July"],
        datasets: [
          {
              label: "My First dataset",
              backgroundColor: "rgba(220,220,220,0.2)",
              borderColor: "rgba(220,220,220,1)",
              data: [65, 59, 80, 81, 56, 55, 40]
          }
        ]
      }
      @options = { height: "200" }
    end

    def uid_param
      params.require(:id)
    end

    def api_key_param
      params.require(:event_id)
    end
  end
end

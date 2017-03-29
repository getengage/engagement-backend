describe Event::EventsProcessed do
  let(:api_key) { FactoryGirl.create(:api_key) }
  let(:source_url) { "http://example.com/source" }
  let(:other_source_url) { "http://example.com/other-source" }
  let(:final_score) { 200 }
  let(:other_final_score) { 100 }
  let(:attrs) {
    {
      api_key: api_key, source_url: source_url, final_score: final_score,
      referrer: source_url
    }
  }
  let(:other_attrs) {
    {
      api_key: api_key, source_url: other_source_url, final_score: other_final_score,
      referrer: other_source_url
    }
  }

  context "scopes" do

    before do
      travel_to("2017-01-01") do
        FactoryGirl.create_list(:events_processed, 20, attrs)
        FactoryGirl.create_list(:events_processed, 20, other_attrs)
      end
    end

    describe "#aggregate_counts" do
      let(:aggregs) { described_class.aggregate_counts(api_key.uuid)[0] }

      it "returns aggregate counts for given api_key" do
        expect(aggregs.uuid).to be_truthy
        expect(aggregs.source_url).to eq(source_url)
        expect(aggregs.top_score).to eq(final_score)
        expect(aggregs.source_url_ct).to eq(20)
        expect(aggregs.final_score_rk).to eq(1)
        expect(aggregs.referrer_rk).to eq(1)
        expect(aggregs.source_url_rk).to eq(1)
      end
    end

    describe "#top_scores_and_visits" do
      let(:aggregs) { described_class.top_scores_and_visits(api_key.uuid)[0] }

      it "returns top scores as JSON array" do
        expect(aggregs.top_scores).to eq(
          [
            {"source_url"=>source_url, "count"=>200},
            {"source_url"=>other_source_url, "count"=>100}
          ]
        )
      end

      it "returns top referrers as JSON array" do
        expect(aggregs.top_referrers).to eq(
          [
            {"source_url"=>source_url, "count"=>1},
            {"source_url"=>other_source_url, "count"=>2}
          ]
        )
      end

      it "returns top visits as JSON array" do
        expect(aggregs.top_visits).to eq(
          [
            {"source_url"=>source_url, "count"=>20},
            {"source_url"=>other_source_url, "count"=>20}
          ]
        )
      end

    end

    describe "#scores_from_past_days" do
      let(:aggregs) { described_class.scores_from_past_days(api_key.uuid, source_url) }

      before do
        travel_to("2017-01-2") do
          FactoryGirl.create_list(:events_processed, 20, attrs.merge(total_in_viewport_time: 150))
        end

        travel_to("2017-01-3") do
          FactoryGirl.create_list(:events_processed, 20, attrs.merge(total_in_viewport_time: 140, final_score: 100))
        end
      end

      it "returns aggregate scores from past 7 days with no gaps as array" do
        travel_to("2017-01-4") do
          expect(aggregs.map(&:day).to_s).to eq(
            "[Thu, 29 Dec 2016,
              Fri, 30 Dec 2016,
              Sat, 31 Dec 2016,
              Sun, 01 Jan 2017,
              Mon, 02 Jan 2017,
              Tue, 03 Jan 2017,
              Wed, 04 Jan 2017]".squish
          )
        end
      end

      it "returns either top score or nil for given days as array" do
        travel_to("2017-01-4") do
          expect(aggregs.map(&:mean_score).to_s).to eq(
            "[nil, nil, nil, 200.0, 200.0, 100.0, nil]"
          )
        end
      end

      it "returns mean viewport time for given days as array" do
        travel_to("2017-01-4") do
          expect(aggregs.map(&:mean_viewport_time).map(&:to_f).to_s).to eq(
            "[0.0, 0.0, 0.0, 200.0, 150.0, 140.0, 0.0]"
          )
        end
      end

      it "returns count of unique visits as integer" do
        travel_to("2017-01-4") do
          expect(aggregs.map(&:visits).to_s).to eq(
            "[0, 0, 0, 20, 20, 20, 0]"
          )
        end
      end

      it "returns count of engaged visits as integer" do
        travel_to("2017-01-4") do
          expect(aggregs.map(&:engaged_visits).to_s).to eq(
            "[0, 0, 0, 20, 20, 0, 0]"
          )
        end
      end

    end

    describe "#scores_from_past_week" do
    end

  end

end

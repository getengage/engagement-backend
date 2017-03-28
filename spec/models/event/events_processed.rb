describe Event::EventsProcessed do
  let(:api_key) { FactoryGirl.create(:api_key) }
  let(:source_url) { "http://example.com" }
  let(:other_source_url) { "http://example2.com" }
  let(:final_score) { 200 }
  let(:other_final_score) { 100 }
  let(:attrs) {
    { api_key: api_key, source_url: source_url, final_score: final_score }
  }
  let(:other_attrs) {
    { api_key: api_key, source_url: other_source_url, final_score: other_final_score }
  }

  describe "#aggregate_counts" do

    before do
      FactoryGirl.create_list(:events_processed, 20, attrs)
      FactoryGirl.create_list(:events_processed, 20, other_attrs)
      @aggregs = described_class.aggregate_counts(api_key.uuid)[0]
    end

    it "returns scores for given api_key" do
      expect(@aggregs).to be_truthy
      expect(@aggregs.uuid).to be_truthy
      expect(@aggregs.source_url).to eq(source_url)
      expect(@aggregs.top_score).to eq(final_score)
      expect(@aggregs.source_url_ct).to eq(20)
      expect(@aggregs.final_score_rk).to eq(1)
      expect(@aggregs.referrer_rk).to eq(1)
      expect(@aggregs.source_url_rk).to eq(1)
    end

  end

  describe "#top_scores_and_visits" do
  end

  describe "#scores_from_past_days" do
  end

  describe "#scores_from_past_week" do
  end

end

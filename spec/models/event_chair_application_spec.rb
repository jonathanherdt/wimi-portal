require 'rails_helper'

RSpec.describe EventChairApplication, type: :model do
  describe 'GET #index' do
    it 'sets defaults for seclevel and type' do
      @event = EventChairApplication.create(trigger_id: 1, chair_id: 1)
      expect(@event.seclevel).to eq('admin')
    end
  end
end

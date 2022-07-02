require 'rails_helper'

RSpec.describe 'Shifts' do
  let(:user) { create_user }
  let(:headers) { { 'Authorization': "Bearer #{user.token}" } }

  describe 'POST /api/v1/shifts/bulk_create' do
    let(:shift1) {{ user_id: user.id, starts_at: Time.current, ends_at: 3.hours.from_now }}  
    let(:shift2) {{ user_id: user.id, starts_at: 1.day.ago, ends_at: 23.hours.ago }}  
    
    it 'returns 200' do
      post '/api/v1/shifts/bulk_create', headers: headers, params: { shifts: [shift1, shift2] }

      expect(response).to have_http_status(200)

      expect(Shift.all).to contain_exactly(
        having_attributes(
          user_id: user.id, 
          starts_at: be_within(2.seconds).of(shift1[:starts_at]), 
          ends_at: be_within(2.seconds).of(shift1[:ends_at])
        ),
        having_attributes(
          user_id: user.id, 
          starts_at: be_within(2.seconds).of(shift2[:starts_at]), 
          ends_at: be_within(2.seconds).of(shift2[:ends_at])
        )
      )
    end
  end

  describe 'GET /api/v1/shifts' do
    xit 'returns 200' do
      get '/api/v1/shifts', headers: headers

      expect(response).to have_http_status(200)
    end

    # Add more tests below.
  end
end

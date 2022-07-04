require 'rails_helper'

RSpec.describe Api::V1::ShiftsController, type: :controller do
  render_views
  describe "index" do
    let!(:user) { FactoryBot.create(:user_with_shifts) }
    context "when authenticated" do
      it "displays the current user shifts" do
        sign_in user
        get :index, format: :json
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(JSON.parse(user.shifts.unscoped.order(start_at: :asc).to_json))
      end
    end
    context "when not authenticated" do
      it "returns unauthorized" do
        get :index, format: :json
        expect(response.status).to eq(401)
      end
    end
  end

  describe "show" do
    let!(:user) { FactoryBot.create(:user_with_shifts) }
    let!(:another_user) { FactoryBot.create(:user_with_shifts) }
    context "when authenticated" do
      it "returns a shift" do
        shift = user.shifts.first
        sign_in user
        get :show, format: :json, params: { id: shift.id }
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(JSON.parse(shift.to_json))
      end
      it "does not allow a user to view other's shifts" do
        shift = another_user.shifts.first
        sign_in user
        get :show, format: :json, params: { id: shift.id }
        expect(response.status).to eq(401)
      end
    end
    context "when not authenticated" do
      it "returns unauthorized" do
        shift = user.shifts.first
        get :show, format: :json, params: { id: shift.id }
        expect(response.status).to eq(401)
      end
    end
  end

  describe "create" do
    let!(:user) { FactoryBot.create(:user_with_shifts) }
    let!(:another_user) { FactoryBot.create(:user_with_shifts) }
    context "when authenticated" do
      it "returns a shift" do
        sign_in user
        shift_params = {"start_at"=>"2022-07-04T18:00:00.291Z", "end_at"=>"2022-07-04T19:00:00.291Z"}
        post :create, format: :json, params: { shift: shift_params }
        expect(response.status).to eq(201)
        expect(JSON.parse(response.body)["start_at"]).to eq(shift_params["start_at"])
        expect(JSON.parse(response.body)["end_at"]).to eq(shift_params["end_at"])
      end
      it "creates a shift" do
        sign_in user
        shift_params = {"start_at"=>"2022-07-04T18:00:00.291Z", "end_at"=>"2022-07-04T19:00:00.291Z"}
        expect { post :create, format: :json, params: { shift: shift_params } }.to change{ Shift.count }.by(1)
      end
      it "returns a message if invalid" do
        sign_in user
        shift_params = {"start_at"=>"test", "end_at"=>"test"}
        expect { post :create, format: :json, params: { shift: shift_params } }.to_not change{ Shift.count }
        expect(response.status).to eq(422)
      end
    end
    context "when not authenticated" do
      it "returns unauthorized" do
        shift_params = {"start_at"=>"2022-07-04T18:00:00.291Z", "end_at"=>"2022-07-04T19:00:00.291Z"}
        post :create, format: :json, params: { shift: shift_params }
        expect(response.status).to eq(401)
      end
    end
  end

  describe "destroy" do
    let!(:user) { FactoryBot.create(:user_with_shifts) }
    let!(:another_user) { FactoryBot.create(:user_with_shifts) }
    context "when authenticated" do
      it "returns no content" do
        sign_in user
        shift = user.shifts.first
        delete :destroy, format: :json, params: { id: shift.id }
        expect(response.status).to eq(204)
      end
      it "destroys a shift" do
        sign_in user
        shift = user.shifts.first
        expect{ delete :destroy, format: :json, params: { id: shift.id } }.to change{ Shift.count }.by(-1)
      end
      it "does not allow a user to destroy other's shifts" do
        sign_in user
        shift = another_user.shifts.first
        expect{ delete :destroy, format: :json, params: { id: shift.id } }.to_not change{ Shift.count }
      end
    end
    context "when not authenticated" do
      it "returns unauthorized" do
        shift = user.shifts.first
        delete :destroy, format: :json, params: { id: shift.id }
        expect(response.status).to eq(401)
      end
    end
  end
end

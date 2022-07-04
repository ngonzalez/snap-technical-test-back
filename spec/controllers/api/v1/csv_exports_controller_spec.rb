require 'rails_helper'

RSpec.describe Api::V1::CsvExportsController, type: :controller do
  render_views
  context "sidekiq is disabled" do
    setup do
      require 'sidekiq/testing'
      Sidekiq::Testing.fake!
    end

    describe "index" do
      let!(:user) { FactoryBot.create(:user_with_csv_exports) }
      context "when authenticated" do
        it "displays the current user csv exports" do
          sign_in user
          get :index, format: :json
          expect(response.status).to eq(200)
          expect(JSON.parse(response.body)).to eq(JSON.parse(user.csv_exports.unscoped.order(created_at: :asc).to_json))
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
      let!(:user) { FactoryBot.create(:user_with_csv_exports) }
      let!(:another_user) { FactoryBot.create(:user_with_csv_exports) }
      context "when authenticated" do
        it "returns a csv export" do
          csv_export = user.csv_exports.first
          sign_in user
          get :show, format: :json, params: { id: csv_export.id }
          expect(response.status).to eq(200)
        end
        it "does not allow a user to view other's csv exports" do
          csv_export = another_user.csv_exports.first
          sign_in user
          get :show, format: :json, params: { id: csv_export.id }
          expect(response.status).to eq(401)
        end
      end
      context "when not authenticated" do
        it "returns unauthorized" do
          csv_export = user.csv_exports.first
          get :show, format: :json, params: { id: csv_export.id }
          expect(response.status).to eq(401)
        end
      end
    end

    describe "create" do
      let!(:user) { FactoryBot.create(:user_with_csv_exports) }
      let!(:another_user) { FactoryBot.create(:user_with_csv_exports) }
      context "when authenticated" do
        it "returns a csv export" do
          sign_in user
          csv_export_params = {"format_name"=>"csv"}
          post :create, format: :json, params: { csv_export: csv_export_params }
          expect(response.status).to eq(201)
          expect(JSON.parse(response.body)["format_name"]).to eq(csv_export_params["format_name"])
        end
        it "creates a csv export" do
          sign_in user
          csv_export_params = {"format_name"=>"csv"}
          expect { post :create, format: :json, params: { csv_export: csv_export_params } }.to change{ CsvExport.count }.by(1)
        end
        it "returns a message if invalid" do
          sign_in user
          csv_export_params = {"format_name"=>"test"}
          expect { post :create, format: :json, params: { csv_export: csv_export_params } }.to_not change{ CsvExport.count }
          expect(response.status).to eq(422)
        end
      end
      context "when not authenticated" do
        it "returns unauthorized" do
          csv_export_params = {"format_name"=>"csv"}
          post :create, format: :json, params: { csv_export: csv_export_params }
          expect(response.status).to eq(401)
        end
      end
    end

    describe "destroy" do
      let!(:user) { FactoryBot.create(:user_with_csv_exports) }
      let!(:another_user) { FactoryBot.create(:user_with_csv_exports) }
      context "when authenticated" do
        it "returns no content" do
          sign_in user
          csv_export = user.csv_exports.first
          delete :destroy, format: :json, params: { id: csv_export.id }
          expect(response.status).to eq(204)
        end
        it "destroys a csv export" do
          sign_in user
          csv_export = user.csv_exports.first
          expect{ delete :destroy, format: :json, params: { id: csv_export.id } }.to change{ CsvExport.count }.by(-1)
        end
        it "does not allow a user to destroy other's csv exports" do
          sign_in user
          csv_export = another_user.csv_exports.first
          expect{ delete :destroy, format: :json, params: { id: csv_export.id } }.to_not change{ CsvExport.count }
        end
      end
      context "when not authenticated" do
        it "returns unauthorized" do
          csv_export = user.csv_exports.first
          delete :destroy, format: :json, params: { id: csv_export.id }
          expect(response.status).to eq(401)
        end
      end
    end
  end
end

require'rails_helper'

describe AchievementsController do 
    describe "GET new" do
        it "renders :new template" do
            get :new
            expect(response).to render_template(:new)
        end

        it "assigns new Achievement to @achievement" do
            get :new
            expect(assigns(:achievement)).to be_a_new(Achievement)
        end
    end

    describe "GET show" do
        let(:achievement) {FactoryBot.create(:public_achievement)}

        it "renders :show template" do
            get :show, params: { id: achievement.id }
            expect(response).to render_template(:show)
        end
        it "assigns requested achievement to @achievement" do
            get :show, params: { id: achievement.id }
            expect(assigns(:achievement)).to eq(achievement)
        end
    end
    
    describe "POST create" do
        context "valid data" do
            it "redirects to achievements#show" do
                post :create, params: { achievement: FactoryBot.attributes_for(:public_achievement) }
                expect(response).to redirect_to(achievement_path(assigns[:achievement]))
            end

            it "creates new achievement in database" do
                expect{
                    post :create, params: { achievement: FactoryBot.attributes_for(:public_achievement) }
                }.to change(Achievement, :count).by(1)
            end
        end

        context "invalid data" do
            let(:invalid_data) {}
            it "renders :new template" do
                post :create, params: { achievement: FactoryBot.attributes_for(:public_achievement, title: '') }
                expect(response).to render_template(:new)
            end

            it "doesn't create new achievement in the database" do 
                expect {
                    post :create, params: { achievement: FactoryBot.attributes_for(:public_achievement, title: '') }
            }.not_to change(Achievement, :count)
            end
        end
    end
end
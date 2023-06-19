# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CarsController do
  describe 'GET #index' do
    let(:car) { create(:car) }
    let(:another_make) { FFaker::Company.name }

    context 'without cars in db' do
      it 'returns empty array' do
        get :index
        expect(assigns(:cars)).to match_array([])
      end
    end

    context 'with cars in db' do
      before { create_list(:car, 3) }

      context 'without rules' do
        it 'returns all cars without sorting' do
          get :index
          expect(assigns(:cars)).to match_array(Car.all)
        end

        it 'returns all cars with sorting' do
          get :index, params: { sort_by: 'price_desc' }
          cars = assigns(:cars)
          expect(cars).to match_array(cars.order({ price: :desc }))
        end
      end

      context 'with rules' do
        before { car }

        it 'saves search parameters in session' do
          get :index, params: { make: car.make, model: car.model }
          expect(session[:previous_params]).not_to be_nil
        end

        context 'when empty rules' do
          it 'returns all cars without sorting' do
            get :index, params: { make: '', model: '', year: '' }

            expect(assigns(:cars)).not_to be_empty
          end
        end

        context 'when car found' do
          it 'returns founded car' do
            get :index,
                params: { make: car.make, model: car.model, year_from: car.year }
            expect(assigns(:cars)).to include(car)
          end
        end

        context 'when car not found' do
          it 'returns an empty array' do
            get :index, params: { make: another_make, model: car.model, year_from: car.year }

            expect(assigns(:cars)).to be_empty
          end
        end
      end

      context 'when sorting' do
        context 'with price_asc' do
          it 'returns cars sorted by price' do
            get :index, params: { sort_by: 'price_asc' }

            cars = assigns(:cars)
            expect(cars).to match_array(cars.order({ price: :asc }))
          end
        end

        context 'with date_added_desc' do
          it 'returns cars sorted by date_added' do
            get :index, params: { sort_by: 'date_added_desc' }

            cars = assigns(:cars)
            expect(cars).to match_array(cars.order({ date_added: :desc }))
          end
        end
      end
    end

    context 'when call SearchSaverService' do
      subject(:result) { SearchSaverService.call(search_params, user) }

      let(:user) { create(:user) }
      let(:search_params) { create(:search) }

      before do
        allow(SearchSaverService).to receive(:call).and_return(nil)
      end

      it 'calles SearchSaverService' do
        expect(result).to be_nil
      end
    end

    context 'when call SearchService' do
      subject(:result) { SearchService.call(search_params) }

      let(:search_params) { create(:search) }

      before do
        allow(SearchService).to receive(:call).and_return([car])
      end

      it 'calles SearchService' do
        expect(result).to eq [car]
      end
    end
  end

  describe 'logged user' do
    let(:user) { create(:user) }
    let(:search_params) { create(:search) }
    let(:car) { create(:car) }

    before do
      sign_in user
      car
    end

    context 'when GET #new' do
      it 'assigns a new car to @car' do
        get :new
        expect(assigns(:car)).to be_a_new(Car)
      end

      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context 'when POST #create' do
      context 'with valid attributes' do
        let(:valid_attributes) { attributes_for(:car) }

        before { valid_attributes }

        it 'saves the new car in the database' do
          expect do
            post :create, params: { car: valid_attributes }
          end.to change(Car, :count).by(1)
        end

        it 'redirects to the show page' do
          post :create, params: { car: valid_attributes }
          expect(response).to redirect_to(assigns(:car))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new car in the database' do
          expect do
            post :create, params: { car: attributes_for(:car, make: nil) }
          end.not_to change(Car, :count)
        end

        it 're-renders the new template' do
          post :create, params: { car: attributes_for(:car, make: nil) }
          expect(response).to render_template(:new)
        end
      end
    end

    context 'when DELETE #destroy' do
      it 'deletes the car' do
        expect do
          delete :destroy, params: { id: car.id }
        end.to change(Car, :count).by(-1)
      end

      it 'redirects to the cars index' do
        delete :destroy, params: { id: car.id }
        expect(response).to redirect_to(cars_url)
      end
    end

    context 'when PATCH #update' do
      let(:valid_attributes) { attributes_for(:car) }

      before { valid_attributes }

      context 'with valid attributes' do
        it 'updates the car in the database' do
          patch :update, params: { id: car.id, car: valid_attributes }
          car.reload
          expect(car.make).to eq(Car.first.make)
        end

        it 'redirects to the show page' do
          patch :update, params: { id: car.id, car: valid_attributes }
          expect(response).to redirect_to(assigns(:car))
        end
      end

      context 'with invalid attributes' do
        it 'does not update the car in the database' do
          patch :update, params: { id: car.id, car: { make: nil } }
          car.reload
          expect(car.make).not_to be_nil
        end

        it 're-renders the edit template' do
          patch :update, params: { id: car.id, car: { make: nil } }
          expect(response).to render_template(:edit)
        end
      end
    end
  end
end

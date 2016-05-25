require 'rails_helper'

RSpec.describe MovieRequestsController, :type => :controller do
	describe 'GET new' do
		it 'assigns @movie_request' do
			get :new
	    expect(assigns(:movie_request)).to be_a(MovieRequest) 
		end

		it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
	end

	describe 'POST create' do
		before(:each) do
			# stub HttpHelper class
			allow(HttpHelper).to receive(:get).and_return('poster' => 'poster.jpg')
		end

		context 'when the request has not been made before' do
			let(:req) { { movie_request: { title: 'New Movie', year: '2003' } } }

			it 'should call to the HttpHelper to get the poster' do
				post :create, req
				expect(HttpHelper).to have_received(:get).with(req[:movie_request])
			end

			it 'should assign @movie_request with the retrieved poster' do
				post :create, req
				expect(assigns(:movie_request).poster).to eq 'poster.jpg'
			end

			it 'renders the show template' do
	      post :create, req
	      expect(response).to render_template('show')
	    end
		end

		context 'when the request has been made before' do
			before(:all) do
				MovieRequest.delete_all
				MovieRequest.create!(title: 'Old Movie', year: '2001', poster: 'old.jpg')
			end

			let(:req) { { movie_request: { title: 'Old Movie', year: '2001' } } }

			it 'should not call to the HttpHelper to get the poster' do
				post :create, req
				expect(HttpHelper).to_not have_received(:get).with(req[:movie_request])
			end

			it 'should not create a new MovieRequest' do
				post :create, req
				expect(MovieRequest.count).to eq 1
			end

			it 'should assign @movie_request with the retrieved poster' do
				post :create, req
				expect(assigns(:movie_request)).to eq MovieRequest.first
			end
		end

		context 'when the response is an error' do
			before(:each) do
				allow(HttpHelper).to receive(:get).and_return('errorcode' => '404')
			end

			let(:req) { { movie_request: { title: 'New Movie', year: '2003' } } }

			it 'should add an error' do
				post :create, req
				expect(assigns(:movie_request).errors.size).to eq 1
			end

			it 'renders the new template' do
	      post :create, req
	      expect(response).to render_template('new')
	    end
		end
	end
end

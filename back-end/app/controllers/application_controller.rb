class ApplicationController < Sinatra::Base

before do
  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST', 'PUT', 'DELETE'],
          'Access-Control-Allow-Headers' => 'Content-Type'
end

    get '/restaurants' do
        Restaurant.all.to_json
    end

    get '/restaurants/:id' do
        Restaurant.find(params[:id]).to_json
    end

    get '/MyRestaurant/:id' do
        restaurant = Restaurant.find(params[:id])
        restaurant.to_json(include: { 
            reviews: { 
            only: [:comment], 
            include: { 
                user: { only: [:username] } 
            } 
            } 
        })
    end

    get '/restaurantsby' do
        pp params
        Restaurant.find_by(params).to_json
    end

    get '/users' do
        User.all.to_json
    end

    get '/users/:id' do
        User.find(params[:id]).to_json
    end

    get '/usersby' do
        pp params
        User.find_by(params).to_json
    end

    get '/reviews' do
        Review.all.to_json
    end

    get '/reviews/:id' do
        Review.find(params[:id]).to_json
    end

    get '/reviewsby' do
        pp params
        Review.find_by(params).to_json
    end

    get '/favorites' do
        Favorite.all.to_json
    end

    get '/favorites/:id' do
        Favorite.find(params[:id]).to_json
    end

    get '/app_reviews' do
        AppReview.all.to_json(only: [:comment], include: {user: {only: [:id, :username]}})
    end

    get '/app_reviews/:id' do
        AppReview.find(params[:id]).to_json
    end

    post '/users' do 
        username = params[:username]
        email = params[:email]
        password = params[:password]

        if(username.present? && email.present? && password.present?)
            check_email_exists = User.where(email:email).count()
            puts("....", check_email_exists)

            if check_email_exists < 1
                user = User.create(username:username, email:email, password:password)
                if user
                    message = {:success => "User created successfully"}
                    message.to_json
                else 
                    message = {:error => "Error saving user"}
                    message.to_json
                end
            else
                message = {:error => "Email already exists"}
                message.to_json
            end
        end
    end

    delete "/users/:id" do
        count_users = User.where(id: params[:id]).count()
        if count_users > 0
            user = User.find(params[:id])
            user.destroy
            message = {:success => "User deleted successfully"}
            message.to_json
        else
            message = {:error => "User does not exist"}
            message.to_json
        end
    end

    # delete '/app_reviews/:id' do
    #     user = User.find(params[:userId])
    #     review = user.app_reviews.find(params[:id])
    #     review.destroy
    # end

    delete "/reviews/:id" do
        count_reviews = Review.where(id: params[:id]).count()
        if count_reviews > 0
            review = Review.find(params[:id])
            review.destroy
            message = {:success => "Review deleted successfully"}
            message.to_json
        else
            message = {:error => "Review does not exist"}
            message.to_json
        end
    end

    delete "/favorites/:id" do
        count_favorites = Favorite.where(id: params[:id]).count()
        if count_favorites > 0
            favorite = Favorite.find(params[:id])
            favorite.destroy
            message = {:success => "Removed from favorites"}
            message.to_json
        else
            message = {:error => "Not a favorite"}
            message.to_json
        end
    end

    post '/app_reviews' do 
        comment = params[:comment]

        if(comment.present?)
            app_review = AppReview.create(comment: comment, user_id: user.id)
            if app_review
                message = {:success => "Review created successfully"}
                message.to_json
            else 
                message = {:error => "Error saving review"}
                message.to_json
            end
        else
            message = {:error => "cannot save an empty review"}
            message.to_json
        end
    end

    delete "/app_reviews/:id" do
        count_app_reviews = AppReview.where(id: params[:id]).count()
        if count_app_reviews > 0
            app_review = AppReview.find(params[:id])
            app_review.destroy
            message = {:success => "Review deleted successfully"}
            message.to_json
        else
            message = {:error => "Review does not exist"}
            message.to_json
        end
    end
end
class ApplicationController < Sinatra::Base

    get '/restaurants' do
        Restaurant.all.to_json
    end

    get '/restaurants/:id' do
        Restaurant.find(params[:id]).to_json
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

    post '/users' do 
        first_name = params[:first_name]
        last_name = params[:last_name]
        email = params[:email]

        if(first_name.present? && last_name.present? && email.present?)
            check_email_exists = User.where(email:email).count()
            puts("....", check_email_exists)

            if check_email_exists < 1
                user = User.create(first_name:first_name, last_name:last_name, email:email)
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
        count_users = User.where(id: params[:id]).count{}
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

    delete "/reviews/:id" do
        count_reviews = Review.where(id: params[:id]).count{}
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
        count_favorites = Favorite.where(id: params[:id]).count{}
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
end
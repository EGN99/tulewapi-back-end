class ApplicationController < Sinatra::Base
    set :default_content_type, 'application/json'
    # before do
    #   headers 'Access-Control-Allow-Origin' => '*',
    #           'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST', 'PUT', 'DELETE'],
    #           'Access-Control-Allow-Headers' => '*',
    #           'Access-Control-Allow-Credentials' => 'true'
    # end

    get '/restaurants' do
        Restaurant.all.to_json
    end

    get '/restaurants/:id' do
        Restaurant.find(params[:id]).to_json
    end

    get '/myrestaurant/:id' do
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

    get '/reservations' do
       Reservation.all.to_json
    end
    
    get '/tables' do
       Table.all.to_json
    end

    get '/tables/:id' do
        table = Table.find(params[:id])
        table.to_json
    end

    get '/tables/rest/:restaurant_id' do
        tables = Table.where(restaurant_id: params[:restaurant_id])
        tables.to_json
    end

    get '/tables/:table_id/reservations' do
        table = Table.find(params[:table_id])
        table.reservations.to_json
    end

    get '/reservations/:id' do
        reservation = Reservation.find(params[:id])
        reservation.to_json
    end

    get '/reservations/rest/:restaurant_id' do
        reservations = Reservation.where(restaurant_id: params[:restaurant_id])
        reservations.to_json
    end

    get '/reservations/user/:user_id' do
        reservations = Reservation.where(user_id: params[:user_id])
        reservations.to_json
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

    post "/favorites" do
        count_favorites = Favorite.where(id: params[:id]).count()
        if count_favorites == 0
            Favorite.create(user_id:user.id,restaurant_id:restaurant.id)
        else
            message = {:error => "favorite already exists"}
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

    delete '/reservations/:id' do
        count_reservations = Reservation.where(id: params[:id]).count()
        if count_reservations > 0
            reservation = Reservation.find(params[:id])
            reservation.destroy
            message = {:success => "Reservation deleted successfully"}
            message.to_json
        else
            message = {:error => "Reservation does not exist"}
            message.to_json
        end
    end

    delete '/tables/:id' do
        count_tables = Table.where(id: params[:id]).count()
        if count_tables > 0
            table = Table.find(params[:id])
            table.destroy
            message = {:success => "Table deleted successfully"}
            message.to_json
        else
            message = {:error => "Table does not exist"}
            message.to_json
        end
    end

    delete '/restaurants/:id' do
        count_restaurants = Restaurant.where(id: params[:id]).count()
        if count_restaurants > 0
            restaurant = Restaurant.find(params[:id])
            restaurant.destroy
            message = {:success => "Restaurant deleted successfully"}
            message.to_json
        else
            message = {:error => "Restaurant does not exist"}
            message.to_json
        end
    end

    post '/tables' do 
        name = params[:name]
        capacity = params[:capacity]
        description = params[:description]
        restaurant_id = params[:restaurant_id]

        if(name.present?)
            check_table_exists = Table.where(name:name).count()
            if check_table_exists < 1
                table = Table.create(name:name, capacity:capacity, description:description, restaurant_id: restaurant_id)
                if table
                    message = {:success => "table created successfully"}
                    message.to_json
                else 
                    message = {:error => "Error saving table"}
                    message.to_json
                end
            else
                message = {:error => "Table already exists"}
                message.to_json
            end
        end
    end

    post '/restaurants' do 
        name = params[:name]
        address = params[:address]
        image_url = params[:image_url]

        if(name.present? && address.present?)
            check_restaurant_exists = Restaurant.where(name:name).count()
            if check_table_exists < 1
                restaurant = Restaurant.create(name:name, address:address, image_url:image_url)
                if restaurant
                    message = {:success => "restaurant created successfully"}
                    message.to_json
                else 
                    message = {:error => "Error saving table"}
                    message.to_json
                end
            else
                message = {:error => "Restaurant already exists"}
                message.to_json
            end
        end
    end

    patch '/restaurants/:id' do 
        id = params[:id]
        restaurant = Restaurant.find_by(id: id)

        if restaurant
            name = params[:name] || restaurant.name
            address = params[:address] || restaurant.address
            image_url = params[:image_url] || restaurant.image_url

            if restaurant.update(name: name, address: address, image_url: image_url)
            message = { success: 'Restaurant updated successfully' }
            message.to_json
            else 
            message = { error: 'Error updating restaurant' }
            message.to_json
            end
        else
            message = { error: 'Restaurant not found' }
            message.to_json
        end
    end
end
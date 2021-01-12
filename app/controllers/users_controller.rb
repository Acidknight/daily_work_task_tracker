class UsersController < ApplicationController


    get '/login' do
        erb :login
    end

    post '/login' do 
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password]) && params[:email] != "" && params[:password] != ""
            session[:user_id] = user.id
            puts session
            redirect "users/#{user.id}"

        else
            flash[:message] = "Your email address or password were incorrect, please try again, or sign up."
            redirect '/login'

        end
    end


    get '/signup' do
        erb :signup
    end

    post '/users' do
        if params[:name] != "" && params[:email] != "" && params[:password] != ""
            @user = User.create(params)
            name = params[:name]
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            flash[:dupe] = "Fields cannot be left empty, please fill out your information."
            redirect '/signup'
        end

    end

    get '/users/:id' do
        set_users
        if logged_in?
            if @user == current_user
               erb :'/users/show'
            else
                flash[:dupe] = "Action not allowed."
                redirect "users/#{current_user.id}"
            end
        end
    end

    get '/users/:id/edit' do 
        set_users
        if logged_in?
         if @user == current_user
            erb :'/users/edit'
         else 
            redirect "users/#{current_user.id}"
         end
        else
            redirect '/'
        end
    end

    patch '/users/:id' do 
        set_users
        if logged_in?
            if @user == current_user && params[:name] != "" && params[:email] != ""
              @user.update(name: params[:name])
              @user.update(email: params[:email])
              redirect "/users/#{@user.id}"
            else
                flash[:edit] = "Edit not allowed, fields must not be empty."
                redirect "users/#{current_user.id}"
            end
            else
                redirect '/'
        end

    end

    delete '/users/:id' do 
        set_users
        if logged_in?
         if @user == current_user
            @user.destroy
            redirect '/'
         else
            redirect "/users/#{@current_user}"
         end 
        end
    end

    get '/logout' do 
        session.clear
        redirect '/'
    end

    private

    def set_users
        @user = User.find_by(id: params[:id])
    end

end

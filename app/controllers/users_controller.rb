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
        @user = User.find_by(id: params[:id])
        erb :'/users/show'
    end

    get '/logout' do 
        session.clear
        redirect '/'
    end

end

class DailyTasksController < ApplicationController

    get '/daily_task_entries/new' do
        erb :'/daily_task_entries/new'
    end

    post '/daily_task_entries' do 
        if !logged_in?
            redirect '/'
        end
        if params[:title] && params[:date] && params[:description] && params[:time] && params[:notes] != ""
            @daily_task_entries = DailyTaskEntry.create(params)
            @user_id = current_user.id
            redirect "/daily_task_entries/#{@daily_task_entries.id}"
        else
            redirect '/daily_task_entries/new'
        end   
    end

    get '/daily_task_entries/:id' do 
        @daily_task_entries = DailyTaskEntry.find(params[:id])
        erb :'/daily_task_entries/show'
    end

    get '/daily_task_entries/:id/edit' do 
        erb :'/daily_task_entries/edit'
    end



end
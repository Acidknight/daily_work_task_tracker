class DailyTasksController < ApplicationController

    get '/daily_task_entries' do
        @daily_task_entries = DailyTaskEntries.all
        erb :'daily_task_entries/index'
    end


    get '/daily_task_entries/new' do
        erb :'/daily_task_entries/new'
    end

    post '/daily_task_entries' do 
        if !logged_in?
            redirect '/'
        end
        if params[:title] && params[:date] && params[:description] && params[:time] && params[:notes] != ""
            @daily_task_entries = DailyTaskEntries.create(title: params[:title], date: params[:date], description: params[:description], time: params[:time], notes: params[:notes], user_id: current_user.id)
            redirect "/daily_task_entries/#{@daily_task_entries.id}"
        else
            redirect '/daily_task_entries/new'
        end   
    end

    get '/daily_task_entries/:id' do 
        set_daily_task_entry
        erb :'/daily_task_entries/show'
    end

    get '/daily_task_entries/:id/edit' do 
        set_daily_task_entry
        if logged_in?
         if @daily_task_entries.user == current_user
            erb :'/daily_task_entries/edit'
         else 
            redirect "users/#{current_user.id}"
         end
        else
            redirect '/'
        end
    end

    patch '/daily_task_entries/:id' do 
        set_daily_task_entry
        if logged_in?
            if @daily_task_entries.user == current_user && params[:title] != ""
              @daily_task_entries.update(title: params[:title], date: params[:date], description: params[:description], time: params[:time], notes: params[:notes])
              redirect "/daily_task_entries/#{@daily_task_entries.id}"
            else
                redirect "users/#{current_user.id}"
            end
            else
                redirect '/'
        end

    end

    delete '/daily_task_entries/:id' do 
        set_daily_task_entry
        if authorized_to_edit?(@daily_task_entries)
            @daily_task_entries.destroy
            redirect '/daily_task_entries'
        else
            redirect '/daily_task_entries'
        end
    end

    private

    def set_daily_task_entry
        @daily_task_entries = DailyTaskEntries.find(params[:id])
    end



end
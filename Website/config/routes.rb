Rails.application.routes.draw do
	root to: 'welcome#index'
	get '/user/login', to: 'user#login', as: 'user_login'
	post '/user/login', to: 'user#login_post'
	get '/user/register', to: 'user#register', as: 'user_register'
	post '/user/register', to: 'user#register_post'
	get '/user', to: 'user#my_info', as: 'user_my_info'
	get '/user/modify', to: 'user#modify', as: 'user_modify'
	post '/user/modify', to: 'user#modify_post'
	get '/user/messages', to: 'user#messages', as: 'user_messages'
	post '/user/messages', to: 'user#messages_post'
	get '/user/logout', to: 'user#logout', as: 'user_logout'
	get '/user/entries', to: 'user#entries', as: 'user_entries'
	
	get '/user/:user_id', to: 'user#show', as: 'user'
	get '/user/messages/:message_id', to: 'user#show_message', as: 'user_show_message'
	
	
	get '/course/list', to: 'course#list', as: 'course_list'
	get '/course/choose/:course_id', to: 'course#choose', as: 'course_choose'
	get '/course/my_list', to: 'course#my_list', as: 'course_my_list'
	
	get '/course/:course_id', to: 'course#show', as: 'course'
	get '/course/:course_id/join', to: 'course#join', as: 'course_join'
	get '/course/:course_id/revoke', to: 'course#revoke', as: 'course_revoke'
	get '/course/:course_id/exit', to: 'course#exit', as: 'course_exit'
	get '/course/:course_id/user_list', to: 'course#user_list', as: 'course_user_list'
end

require 'sinatra'
require 'sinatra/flash'
require 'intercom'

enable :sessions

def intercom
  @intercom ||= Intercom::Client.new(app_id: ENV['APP_ID'], api_key: ENV['API_KEY'])
end

get '/' do
  erb :index
end

post '/customers/tags' do
  users = params[:emails].split(/[,\s]+/).map {|email| {email: email}}.uniq
  tag_name = params[:tag_name]

  begin
    intercom.tags.tag(users: users, name: tag_name)
    flash[:notice] = "#{users.size} users tagged with \"#{tag_name}\""
  rescue Intercom::IntercomError => e
    flash[:error] = "#{e.message}"
  end

  redirect to('/')
end

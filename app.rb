require 'sinatra'
require 'intercom'

def intercom
  @intercom ||= Intercom::Client.new(app_id: ENV['APP_ID'], api_key: ENV['API_KEY'])
end

get '/' do
  erb :index
end

post '/customers/tags' do
  users = params[:emails].split(/[,\s]+/).map {|email| {email: email}}.uniq
  tag_name = params[:tag_name]

  intercom.tags.tag(users: users, name: tag_name)
  logger.info "#{users.size} users tagged with #{tag_name} (#{users.join(', ')})"

  redirect to('/')
end

__END__

@@ layout
<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,300,500">
<link rel="stylesheet" href="/styles.css">
<title>Intercom Web Interface</title>
<h1>Intercom Web Interface</h1>
<%= yield %>

@@ index
<form method="post" action="/customers/tags">
  <label>
    Customer e-mails <small>(separated by comma or line-breaks)</small>
    <textarea class="text-input" name="emails"></textarea>
  </label>

  <label>
    Name of tag <small>(to tag customers with)</small>
    <input class="text-input" type="text" name="tag_name">
  </label>

  <div class="u-text-center">
    <input class="button" type="submit" value="Tag customers">
  </div>
</form>

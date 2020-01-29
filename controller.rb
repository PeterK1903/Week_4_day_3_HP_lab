require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('./models/student.rb')
also_reload('./models/*')

get '/allstudents' do
  @students = Student.all()
  erb(:index)
end

get '/allstudents/new' do
  erb(:new)
end

post '/allstudents' do
  @student = Student.new(params)
  @student.save()
  erb(:create)
end

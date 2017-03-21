class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def home
  	if !current_user.nil?
  	 enrolled_ids = User.find_by(id: current_user.id).enrollments
	 @enrolled_courses = []
	  	enrolled_ids.each_with_index  do |i, index|
	  	
	  		@enrolled_courses[index] =  Course.find_by(id: i.course_id).name 
		end
	end
  end
  def not_found
  end
end

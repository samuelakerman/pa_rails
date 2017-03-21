class DataloadController < ApplicationController
	def instructors
		Instructor.delete_all
		total_ins_start = Instructor.count
		ins_array = JSON.parse File.read(Dir.pwd+"/db/instructor.json")
		ins_array.each do |ins|
			curr_ins = Instructor.new
			curr_ins.fname = ins["first"]
			curr_ins.lname = ins["last"]
			curr_ins.email = ins["email"]
			curr_ins.brandeis_id = ins["id"]
			curr_ins.save
		end
		total_ins_end = Instructor.count
		if (total_ins_end - total_ins_start) > 0
			render html: "Instructors were created and saved to the database."
		else
			render html: "No instructors were created."
		end
	end
	def subjects
		Subject.delete_all
		total_subj_start = Subject.count
		sub_array = JSON.parse File.read(Dir.pwd+"/db/subject.json")
		sub_array.each do |subj|
			curr_subj = Subject.new
			curr_subj.brandeis_id = subj["id"]
			curr_subj.name = subj["name"]
			curr_subj.save
		end
		total_subj_end = Subject.count
		if (total_subj_end - total_subj_start) > 0
			render html: "Subjects were created and saved to the database."
		else
			render html: "No subjects were created."
		end
	end
	def courses
		Course.delete_all
		total_course_start = Course.count
		int = 0
		course_array = JSON.parse File.read(Dir.pwd+"/db/course.json")
		course_array.each do |cour|
			curr_course = Course.new
			curr_course.brandeis_code = cour["code"]
			curr_course.name = cour["name"]
			curr_course.save

			#Subject.find_by(brandeis_id: chiapo[0]["subjects"][0]["id"]).id

			cour["subjects"].each do |subject|
				subj = CourseSubject.new
				subj.course_id = curr_course.id
				
				if !Subject.find_by(brandeis_id: subject["id"]).nil?
					subj.subject_id = Subject.find_by(brandeis_id: subject["id"]).id
					subj.save
				end
			end


			int++
			if int==1000
				render html: "Still working...."
				int=0
			end

		end

		total_course_end = Course.count
		if (total_course_end - total_course_start) > 0
			render html: "Courses were created and saved to the database."
		else
			render html: "No courses were created."
		end

	end
end

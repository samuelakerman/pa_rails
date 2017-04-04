class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    if session[:user_id].nil?
      redirect_to '/', :flash => { :error => 'Please, log in or create an account to access the system.' }
    else
        @courses = Course.all
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  def search
    if session[:user_id].nil?
      redirect_to '/', :flash => { :error => 'Please, log in or create an account to access the system.' }
    else
       @subjects = Subject.all
    end
  end

  def results
    subject_id = params["search_criteria"]["subject_id"]
    course_criteria = params["search_criteria"]["course_criteria"]
    if subject_id.empty?
      @results = Course.where('lower(name) LIKE ?', '%' + course_criteria + '%')
    else
      @results = Subject.find_by(id: subject_id).courses.where('lower(name) LIKE ?', '%' + course_criteria + '%')
    end
  end

  def resultsjson
    subject_id = params["subject_id"]
    course_criteria = params["course_criteria"]
    if subject_id.nil?
      @results = Course.where('lower(name) LIKE ?', '%' + course_criteria + '%')
    elsif course_criteria.nil?
      @results = Subject.find_by(id: subject_id).courses
    else
      @results = Subject.find_by(id: subject_id).courses.where('lower(name) LIKE ?', '%' + course_criteria + '%')
    end
    render :json => @results
  end

  def enroll
    selection = params["course_selection"].to_a
    @enrolled=[]
    selection.each do |course|
      if course[1]=="1"
        course = Course.find_by(id: course[0])
        enrollin = Enrollment.new
        enrollin.course_id = course.id
        enrollin.user_id = current_user.id
        if enrollin.save
          @enrolled[@enrolled.count] = course.name
        end
      end
    end
  end

  def enrollajax
    course = Course.find_by(id: params.to_a[0][0])
    enrollin = Enrollment.new
    enrollin.course_id = course.id
    enrollin.user_id = current_user.id

    users_courses = User.find_by(id: current_user.id).courses

    test = false
    users_courses.each do |x|
      if x.id == course.id
        test =true
        break
      end
    end
    if test==true
      render :json => ["course already enrolled"]
      return
    end

    if enrollin.save
      render :json => ["success"]
      return
    else
      render :json => ["failure"]
    end
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :brandeis_code)
    end
end

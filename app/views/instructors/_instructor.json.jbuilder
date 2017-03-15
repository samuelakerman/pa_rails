json.extract! instructor, :id, :fname, :lname, :email, :brandeis_id, :type, :created_at, :updated_at
json.url instructor_url(instructor, format: :json)

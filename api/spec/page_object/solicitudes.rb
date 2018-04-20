
def in_microseconds
  return "%Q"
end

def in_english_format
  return "%Y-%m-%d"
end

def post_create_solicitude(body_created)
  post '/api/create-solicitude', body_created
end

def retrieve_date(information)
  return information['date']
end

def retrieve_first_date(response)
  retrieve_date(response['data'][0])
end

def retrieve_second_date(response)
  retrieve_date(response['data'][1])
end

def retrieve_creation_moment(information)
  return information['creation_moment']
end

def retrieve_first_creation_moment(response)
  retrieve_creation_moment(response['data'][0])
end

def retrieve_second_creation_moment(response)
  retrieve_creation_moment(response['data'][1])
end

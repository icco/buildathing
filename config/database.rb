##
# Database config for relational db.
connections = {
  :development => "postgres://localhost/buildathing",
  :test => "postgres://postgres@localhost/buildathing_test",
  :production => ENV['DATABASE_URL']
}

# Setup our logger
ActiveRecord::Base.logger = logger

if ActiveRecord::VERSION::MAJOR.to_i < 4
  # Raise exception on mass assignment protection for Active Record models.
  ActiveRecord::Base.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL).
  ActiveRecord::Base.auto_explain_threshold_in_seconds = 0.5
end

# Doesn't include Active Record class name as root for JSON serialized output.
ActiveRecord::Base.include_root_in_json = false

# Store the full class name (including module namespace) in STI type column.
ActiveRecord::Base.store_full_sti_class = true

# Use ISO 8601 format for JSON serialized times and dates.
ActiveSupport.use_standard_json_time_format = true

# Don't escape HTML entities in JSON, leave that for the #json_escape helper
# if you're including raw JSON in an HTML page.
ActiveSupport.escape_html_entities_in_json = false

# Timestamps are in the utc by default.
ActiveRecord::Base.default_timezone = :utc

# Now we can estabilish connection with our db
if connections[Padrino.env]
  url = URI(connections[Padrino.env])
  options = {
    :adapter => url.scheme,
    :host => url.host,
    :port => url.port,
    :database => url.path[1..-1],
    :username => url.user,
    :password => url.password
  }

  case url.scheme
  when "sqlite"
    options[:adapter] = "sqlite3"
    options[:database] = url.host + url.path
  when "postgres"
    options[:adapter] = "postgresql"
  end

  # Log what we are connecting to.
  logger.push " DB: #{options.inspect}", :devel

  ActiveRecord::Base.establish_connection(options)
else
  logger.push("No database configuration for #{Padrino.env.inspect}", :fatal)
end

databases = Database.all
databases.each do |db|
  description = CGI.unescapeHTML(db.description).strip
  db.description = description 
  db.save(validate: false)
end

databases = Database.all
databases.each do |db|
  unless db.created_date.nil?
    date = DateTime.strptime(db.created_date.to_s, '%s')
    db.created_at = date
    db.save(validate: false)
    puts 'Updating Created At Date'
  end

  unless db.updated_date.nil?
    date = DateTime.strptime(db.updated_date.to_s, '%s')
    db.updated_at = date
    db.save(validate: false)
    puts 'Updating Update Date'
  end

  next if db.trial_expire_date.nil?

  date = DateTime.strptime(db.trial_expire_date.to_s, '%s')
  db.trial_expiration_date = date
  db.save(validate: false)
  puts 'Updating Expiration Date'
end

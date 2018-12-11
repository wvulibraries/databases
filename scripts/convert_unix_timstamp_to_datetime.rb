databases = Database.all
databases.each do |db|
  unless db.created_date.nil?
    date = DateTime.strptime(db.created_date.to_s, '%s')
    db.update(created_at: date)
    puts "Updating Created At Date"
  end

  unless db.updated_date.nil?
    date = DateTime.strptime(db.updated_date.to_s, '%s')
    db.update(updated_at: date)
    db.save!
    puts "Updating Update Date"
  end
  
  unless db.trial_expire_date.nil?
    date = DateTime.strptime(db.trial_expire_date.to_s, '%s')
    db.update(trial_expiration_date: date)
    db.save!
    puts "Updating Expiration Date"
  end
end

require 'rails_helper'

describe Database::ExpirationDate do
  let(:database) { FactoryBot.create :database_basic }

  context '.expired?' do
    it 'returns false if date has not passed' do
      d = Database::ExpirationDate.new
      date = Date.today + 5.days
      expect(d.expired?(date)).to be false 
    end 
    
    it  'returns true if date has passed' do
      d = Database::ExpirationDate.new
      date = Date.today - 5.days
      expect(d.expired?(date)).to be true
    end

    it 'returns true if date matches as expiration date is technically exceeded' do
      d = Database::ExpirationDate.new
      date = Date.today
      expect(d.expired?(date)).to be true
    end 
  end

  context '.set_hidden_expired' do
    it 'changes the status to hidden because the data is expired' do
      database.status = 'production'
      database.trial_expiration_date = (Date.today - 3.days)
      database.trial_database = true
      database.save!

      d = Database::ExpirationDate.new
      d.set_hidden_expired(database)

      expect(database.status).to eq 'hidden'
    end 

    it 'keeps the status as production because data is 3 days before expiration' do
      database.status = 'production'
      database.trial_expiration_date = (Date.today + 3.days)
      database.trial_database = true
      database.save!

      d = Database::ExpirationDate.new
      d.set_hidden_expired(database)

      expect(database.status).to eq 'production'
    end 

    it 'dates are equal make it hidden' do
      database.status = 'production'
      database.trial_expiration_date = Date.today
      database.trial_database = true
      database.save!
      database.reload

      d = Database::ExpirationDate.new
      d.set_hidden_expired(database)
      expect(database.status).to eq 'hidden'
    end 
  end 

  context '.evaluate_trials' do  
    it 'sets 2 of 3 to hidden' do
      db1 = FactoryBot.create :database_basic
      db2 = FactoryBot.create :database_basic
      db3 = FactoryBot.create :database_basic

      db1.status = 'production'
      db1.trial_expiration_date = (Date.today + 3.days)
      db1.trial_database = true
      db1.save!

      db2.status = 'production'
      db2.trial_expiration_date = (Date.today - 3.days)
      db2.trial_database = true
      db2.save!

      db3.status = 'production'
      db3.trial_expiration_date = (Date.today - 7.days)
      db3.trial_database = true
      db3.save!
      
      d = Database::ExpirationDate.new
      d.evaluate_trials

      db1.reload
      db2.reload
      db3.reload

      expect(db1.status).to eq 'production'
      expect(db2.status).to eq 'hidden'
      expect(db3.status).to eq 'hidden'
    end 
  end 


end

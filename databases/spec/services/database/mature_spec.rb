require 'rails_helper'

describe Database::Mature do
  let(:database) { FactoryBot.create :database_basic }

  context '.newest_date' do
    it 'should use the updated date because it is newer' do
      database.created_at = (DateTime.now.beginning_of_day - 8.months)
      database.updated_at = (DateTime.now.beginning_of_day - 6.months) 
      
      d = Database::Mature.new
      date = (DateTime.now.beginning_of_day - 6.months)
      expect(d.newest_date(database)).to eq(date)
    end 
    
    it 'should use the created date because it is newer' do
      database.created_at = (DateTime.now.beginning_of_day - 4.months)
      database.updated_at = (DateTime.now.beginning_of_day - 8.months) 
      
      d = Database::Mature.new
      date = (DateTime.now.beginning_of_day - 4.months)
      expect(d.newest_date(database)).to eq(date)
    end

    it 'should use either because they are the same' do
      database.created_at = (DateTime.now.beginning_of_day - 4.months)
      database.updated_at = (DateTime.now.beginning_of_day - 4.months) 
      
      d = Database::Mature.new
      date = (DateTime.now.beginning_of_day - 4.months)
      expect(d.newest_date(database)).to eq(date)
    end 
  end

  context '.six_months_old?' do
    it 'should return true because it is 6 months old' do
      database.created_at = (DateTime.now.beginning_of_day - 6.months)
      database.updated_at = (DateTime.now.beginning_of_day - 6.months) 
      
      d = Database::Mature.new
      expect(d.six_months_old?(database)).to be true
    end 

    it 'should return false because it is only 3 months old' do
      database.created_at = (DateTime.now.beginning_of_day - 3.months)
      database.updated_at = (DateTime.now.beginning_of_day - 3.months) 
      
      d = Database::Mature.new
      expect(d.six_months_old?(database)).to be false
    end 
    
    it 'should return true because it is 8 months old' do
      database.created_at = (DateTime.now.beginning_of_day - 8.months)
      database.updated_at = (DateTime.now.beginning_of_day - 8.months) 
      
      d = Database::Mature.new
      expect(d.six_months_old?(database)).to be true
    end 
  end 
  
  context '.modify_new' do
    it 'should be false because it is older than 6 months' do
      database.new_database = true 
      database.created_at = (DateTime.now.beginning_of_day - 8.months)
      database.updated_at = (DateTime.now.beginning_of_day - 8.months) 
      database.save! 

      d = Database::Mature.new
      expect(d.modify_new(database)).to be true
      database.reload 
      expect(database.new_database).to be false
    end 

    it 'should not modify the database because it is less than 6 months old' do
      database.new_database = true 
      database.created_at = (DateTime.now.beginning_of_day - 3.months)
      database.updated_at = (DateTime.now.beginning_of_day - 3.months) 
      database.save! 

      d = Database::Mature.new
      expect(d.modify_new(database)).to be true
      database.reload 
      expect(database.new_database).to be true
    end 
  end
  
  context '.evaluate_list' do
    it '2 items should be new' do
      immature_date =  DateTime.now.beginning_of_day - 3.months 
      mature_date = DateTime.now.beginning_of_day - 6.months

      db1 = FactoryBot.create :database_basic
      db2 = FactoryBot.create :database_basic
      db3 = FactoryBot.create :database_basic

      db1.new_database = true 
      db2.new_database = true 
      db3.new_database = true 

      db1.created_at = immature_date
      db1.updated_at = immature_date

      db2.created_at = immature_date
      db2.updated_at = immature_date

      db3.created_at = mature_date
      db3.updated_at = mature_date

      db1.save!
      db2.save!
      db3.save! 

      d = Database::Mature.new
      d.evaluate_list

      expect(Database.new_list.count).to eq(2)
    end 

    it '3 items should be new' do
      immature_date =  DateTime.now.beginning_of_day - 3.months 
      mature_date = DateTime.now.beginning_of_day - 6.months

      db1 = FactoryBot.create :database_basic
      db2 = FactoryBot.create :database_basic
      db3 = FactoryBot.create :database_basic

      db1.new_database = true 
      db2.new_database = true 
      db3.new_database = true 

      db1.created_at = immature_date
      db1.updated_at = immature_date

      db2.created_at = immature_date
      db2.updated_at = immature_date

      db3.created_at = immature_date
      db3.updated_at = immature_date

      db1.save!
      db2.save!
      db3.save! 

      d = Database::Mature.new
      d.evaluate_list

      expect(Database.new_list.count).to eq(3)
    end 

    it '0 items should be new' do
      immature_date =  DateTime.now.beginning_of_day - 3.months 
      mature_date = DateTime.now.beginning_of_day - 6.months

      db1 = FactoryBot.create :database_basic
      db2 = FactoryBot.create :database_basic
      db3 = FactoryBot.create :database_basic

      db1.new_database = true 
      db2.new_database = true 
      db3.new_database = true 

      db1.created_at = mature_date
      db1.updated_at = mature_date

      db2.created_at = mature_date
      db2.updated_at = mature_date

      db3.created_at = mature_date
      db3.updated_at = mature_date

      db1.save!
      db2.save!
      db3.save! 

      d = Database::Mature.new
      d.evaluate_list

      expect(Database.new_list.count).to eq(0)
    end 
  end
end


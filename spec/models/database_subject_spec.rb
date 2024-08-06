require 'rails_helper'

RSpec.describe DatabaseSubject, type: :model do
  context 'join table, should only have associations' do
    it { should belong_to(:database) }
    it { should belong_to(:subject) }
  end
end

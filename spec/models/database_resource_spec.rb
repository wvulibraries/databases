require 'rails_helper'

RSpec.describe DatabaseResource, type: :model do
  context 'join table, should only have associations' do
    it { should belong_to(:database) }
    it { should belong_to(:resource) }
  end
end

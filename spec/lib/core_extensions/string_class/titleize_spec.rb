require 'rails_helper'

describe 'CoreExtensions::String' do
  context '.titleize' do
    it 'returns a capialized string for snaked cased words' do
      str = 'something_cool'
      expect(str.better_titleize).to eq('Something Cool')
    end

    it 'returns a capitalied string for a single word' do
      str = 'monkey'
      expect(str.better_titleize).to eq('Monkey')
    end

    it 'returns the string as is without dropping the id' do
      str = 'monkey_patch_id'
      expect(str.better_titleize).to eq('Monkey Patch Id')
    end
  end
end

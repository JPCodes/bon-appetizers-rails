require 'rails_helper'

describe Product do
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :price }
end

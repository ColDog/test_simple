require 'spec_helper'

describe TestSimple do
  it 'has a version number' do
    expect(TestSimple::VERSION).not_to be nil
  end

  should { true }
  should { assert true, true }
  should { assert_not true, false }
  results
end

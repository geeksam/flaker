require 'rspec'
RSpec.configure do |config|
  config.order = :defined
end

require 'faker'
Faker::Config.random = Random.new(42)

RSpec.describe "order-dependent tests" do

  EXPECTED_VALUES = [
    "expedite impactful systems",
    "enhance plug-and-play vortals",
    "expedite viral paradigms",
    "facilitate wireless web-readiness",
    "disintermediate bleeding-edge applications",
    "utilize holistic vortals",
    "deliver visionary supply-chains",
    "innovate out-of-the-box e-markets",
    "redefine turn-key e-commerce",
    "recontextualize one-to-one methodologies",
  ]

  def fail_on_last?
    !ENV['FAIL_ON_LAST'].to_s.strip.empty?
  end

  EXPECTED_VALUES.each.with_index do |bs, i|
    n = i + 1

    specify "test ##{n}: #{bs}" do
      if bs == EXPECTED_VALUES.last && fail_on_last?
        expect( Faker::Company.bs ).to_not eq( bs )
      else
        expect( Faker::Company.bs ).to eq( bs )
      end
    end
  end

end

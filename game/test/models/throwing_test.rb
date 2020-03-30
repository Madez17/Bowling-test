require 'test_helper'

class ThrowingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Strike" do
      roll = Throwing.new(entrada: "XXXXXXXXXXXX")      
      assert roll.save
  end

  test "Spare" do
      roll = Throwing.new(entrada: "5/5/5/5/5/5/5/5/5/5/5")
      assert roll.save
  end

  test "miss" do
      roll = Throwing.new(entrada: "9-9-9-9-9-9-9-9-9-9-")
      assert roll.save
  end

  test "Throwing test options" do
      roll = Throwing.new(entrada: "X814---XX34118-XXX")
      assert roll.save
  end

  test "Throwing test cero" do
      roll = Throwing.new(entrada: "--------------------")
      assert roll.save
  end

end

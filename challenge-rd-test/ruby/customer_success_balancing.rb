require 'minitest/autorun'
require 'timeout'

class CustomerSuccessBalancing
  def initialize(customer_success, customers, away_customer_success)
    @customer_success = customer_success
    @customers = customers
    @away_customer_success = away_customer_success
  end

  # Returns the ID of the customer success with most customers
  def execute
    # Write your solution here
    customer_success_attending = @away_customer_success.any? ? fetch_customer_success_attending : @customer_success

    ordered_customer_success = order_by_score(customer_success_attending)

    ordered_customers = @customers.empty? ? [] : order_by_score(@customers)

    distribute_customers_per_customer_success(ordered_customer_success, ordered_customers)

    customer_success_with_most_customers = group_by_most_attendings(ordered_customer_success)

    return 0 unless customer_success_with_most_customers[1].count == 1

    customer_success_with_most_customers[1].first[:id]
  end
  private

  def fetch_customer_success_attending
    @customer_success.reject! { |customer_success| @away_customer_success.include?(customer_success[:id]) }
  end

  def order_by_score(objects)
    objects.sort_by { |object| object[:score] }
  end

  def distribute_customers_per_customer_success(ordered_customer_success, ordered_customers)
    ordered_customer_success.each_with_index do |customer_success, index|
      customers = find_customers(ordered_customers, customer_success, index, ordered_customer_success)
      customer_success[:customers_attending] = customers.empty? ? [] : customers
    end
  end

  def find_customers(ordered_customers, customer_success, index, ordered_customer_success)
    return ordered_customers.select { |customer| customer[:score] <= customer_success[:score] } if index.zero?

    ordered_customers.select do |customer|
      customer[:score] <= customer_success[:score] && customer[:score] > ordered_customer_success[index - 1][:score]
    end
  end

  def group_by_most_attendings(customer_success)
    return [] if customer_success.empty?

    customer_success.group_by { |i| i[:customers_attending].count }.sort.reverse.first
  end
end

class CustomerSuccessBalancingTests < Minitest::Test
  def test_scenario_one
    balancer = CustomerSuccessBalancing.new(
      build_scores([60, 20, 95, 75]),
      build_scores([90, 20, 70, 40, 60, 10]),
      [2, 4]
    )
    assert_equal 1, balancer.execute
  end

  def test_scenario_two
    balancer = CustomerSuccessBalancing.new(
      build_scores([11, 21, 31, 3, 4, 5]),
      build_scores([10, 10, 10, 20, 20, 30, 30, 30, 20, 60]),
      []
    )
    assert_equal 0, balancer.execute
  end

  def test_scenario_three
    balancer = CustomerSuccessBalancing.new(
      build_scores(Array(1..999)),
      build_scores(Array.new(10000, 998)),
      [999]
    )
    result = Timeout.timeout(1.0) { balancer.execute }
    assert_equal 998, result
  end

  def test_scenario_four
    balancer = CustomerSuccessBalancing.new(
      build_scores([1, 2, 3, 4, 5, 6]),
      build_scores([10, 10, 10, 20, 20, 30, 30, 30, 20, 60]),
      []
    )
    assert_equal 0, balancer.execute
  end

  def test_scenario_five
    balancer = CustomerSuccessBalancing.new(
      build_scores([100, 2, 3, 6, 4, 5]),
      build_scores([10, 10, 10, 20, 20, 30, 30, 30, 20, 60]),
      []
    )
    assert_equal 1, balancer.execute
  end

  def test_scenario_six
    balancer = CustomerSuccessBalancing.new(
      build_scores([100, 99, 88, 3, 4, 5]),
      build_scores([10, 10, 10, 20, 20, 30, 30, 30, 20, 60]),
      [1, 3, 2]
    )
    assert_equal 0, balancer.execute
  end

  def test_scenario_seven
    balancer = CustomerSuccessBalancing.new(
      build_scores([100, 99, 88, 3, 4, 5]),
      build_scores([10, 10, 10, 20, 20, 30, 30, 30, 20, 60]),
      [4, 5, 6]
    )
    assert_equal 3, balancer.execute
  end

  private

  def build_scores(scores)
    scores.map.with_index do |score, index|
      { id: index + 1, score: score }
    end
  end
end

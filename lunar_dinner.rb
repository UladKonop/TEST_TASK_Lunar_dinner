# frozen_string_literal: true

require_relative('table')
require_relative('person')

class LunarDinner
  def initialize
    @tables_amount = 5
    @seats_amount = 6
    @courses_amount = 3
    @people_amount = @tables_amount * @seats_amount
  end

  def start
    make_seating_plan
    print_seating_plan
  end

  private

  def create_dinner_instances
    @people = Array.new(@people_amount) { Person.new }
    @tables = Array.new(@tables_amount) { Table.new(@seats_amount) }
  end

  def subsequent_course
    @people.each do |person|
      free_tables = @tables.reject(&:full?)
      neighbors_at_tables = free_tables.map { |table| person.neighbors_amount_at(table) }
      best_table_index = neighbors_at_tables.index(neighbors_at_tables.min)
      person.take_seat_at(free_tables[best_table_index])
    end
    @tables.map(&:clear)
  end

  def print_seating_plan
    @courses_amount.times do |course|
      puts '= ' * @seats_amount * 2
      @tables.each { |table| puts table.history[course].map(&:id).to_s }
    end
  end

  def make_seating_plan
    create_dinner_instances
    @courses_amount.times { subsequent_course }
  end
end

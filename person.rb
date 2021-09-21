# frozen_string_literal: true

require_relative('instance_counter')
require_relative('table')

class Person
  include InstanceCounter

  attr_reader :id, :neighbors

  def initialize
    @id = register_instance
    @neighbors = []
  end

  def take_seat_at(table)
    add_neighbors_at(table)
    table.people = self
  end

  def neighbors_amount_at(table)
    neighbors_amount = 0
    table.people.each { |person| neighbors_amount += 1 if @neighbors.include?(person) }
    neighbors_amount
  end

  private

  def neighbors=(person)
    @neighbors.include?(person) ? nil : @neighbors << person
  end

  def add_neighbors_at(table)
    table.people.each do |person|
      self.neighbors = person
      person.send(:neighbors=, self)
    end
  end
end

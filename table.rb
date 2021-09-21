# frozen_string_literal: true

require_relative('instance_counter')

class Table
  include InstanceCounter

  attr_reader :id, :history, :people

  def initialize(seats_amount)
    @id = register_instance
    @seats_amount = seats_amount
    @history = []
    @people = []
  end

  def people=(person)
    @people << person
  end

  def full?
    @people.size.eql?(@seats_amount)
  end

  def clear
    @history << @people.clone
    @people.clear
  end
end

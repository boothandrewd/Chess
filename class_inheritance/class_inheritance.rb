# class_inheritance.rb

class Employee
  attr_reader :salary
  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end


class Manager < Employee
  attr_reader :employee_list
  def initialize(name, title, salary, boss)
    super
    @employee_list = []
  end

  def add_employee(employee)
    @employee_list << employee
  end

  def bonus(multiplier)
    @employee_list.map(&:salary).inject(:+) * multiplier
  end
end

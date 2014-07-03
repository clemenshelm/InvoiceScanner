class Vector
  def initialize(components)
    @components = components
  end

  def self.[](*components)
    Vector.new components
  end

  # define operators
  [:+, :-, :*].each do |operator|
    define_method operator do |other_vector|
      # Applies the operator element-wise
      Vector.new [@components, other_vector.to_a].transpose
        .map { |dimension| dimension.reduce(operator) }
    end
  end

  def /(scalar)
    Vector.new self.to_a.map { |component| component / scalar }
  end

  def normalize
    length = Math.sqrt @components.map { |component| component ** 2 }.reduce(:+)
    self / length
  end

  def inner_product(other_vector)
    (self * other_vector).to_a.inject(:+)
  end

  def to_a
    @components
  end

  def ==(other_vector)
    @components == other_vector.to_a
  end
end

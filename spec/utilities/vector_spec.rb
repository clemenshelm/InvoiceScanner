describe Vector do
  def components number=rand(10)
    number.times.map { rand(10) }
  end

  it "accepts a number of components" do
    vector_components = components

    vector = Vector[*vector_components]

    vector.class.should.equal Vector
    vector.to_a.should.equal vector_components
  end

  context "adding two vectors" do
    it "sums up a 2-dimensional vector" do
      vector1 = Vector[4, 2]
      vector2 = Vector[0, -7]

      added_vector = vector1 + vector2

      added_vector.should.equal Vector[4, -5]
    end

    it "sums up a 4-dimensional vector" do
      vector1 = Vector[-1, 8, 0, 3]
      vector2 = Vector[3, 4, 1, 0]

      added_vector = vector1 + vector2

      added_vector.should.equal Vector[2, 12, 1, 3]
    end
  end

  context "dividing a vector by a scalar" do
    it "divides a 2-dimensional vector" do
      vector1 = Vector[4, 2]
      scalar = 2

      divided_vector = vector1 / scalar

      divided_vector.should.equal Vector[2, 1]
    end

    it "divides a 4-dimensional vector" do
      vector1 = Vector[6, 12, 15, 18]
      scalar = 3

      divided_vector = vector1 / scalar

      divided_vector.should.equal Vector[2, 4, 5, 6]
    end
  end

  context "subtractiong two vectors" do
    it "subtracts a 2-dimensional vector" do
      vector1 = Vector[4,2]
      vector2 = Vector[0,-7]

      subtracted_vector = vector1 - vector2

      subtracted_vector.should.equal Vector[4,9]
    end

    it "subtracts a 4-dimensional vector" do
      vector1 = Vector[-1, 8, 0, 3]
      vector2 = Vector[3, 4, 1, 0]

      subtracted_vector = vector1 - vector2

      subtracted_vector.should.equal Vector[-4, 4, -1, 3]
    end
  end

  context "multiplying two vectors" do
    it "multiplying a 2-dimensional vector" do
      vector1 = Vector[4,2]
      vector2 = Vector[0,-7]

      multiplied_vector = vector1 * vector2

      multiplied_vector.should.equal Vector[0,-14]
    end

    it "multiplying a 4-dimensional vector" do
      vector1 = Vector[-1, 8, 0, 3]
      vector2 = Vector[3, 4, 1, 0]

      multiplied_vector = vector1 * vector2

      multiplied_vector.should.equal Vector[-3, 32, 0, 0]
    end
  end

  context "normalizing a vector" do
    it "normalizes a 2-dimensional vector" do
      vector = Vector[2, 0]

      vector.normalize.should.equal Vector[1, 0]
    end

    it "normalizes a 3-dimensional vector" do
      vector = Vector[1, 2, 3]
      length = Math.sqrt(1 + 4 + 9)

      vector.normalize.should.equal Vector[1/length, 2/length, 3/length]
    end
  end

  context "inner product" do
    it "calculates the inner product of two 2-dimensional vectors" do
      vector1 = Vector[1, 2]
      vector2 = Vector[3, 4]

      inner_product = vector1.inner_product vector2

      inner_product.should.equal 1 * 3 + 2 * 4
    end

    it "calculates the inner product of two 3-dimensional vectors" do
      vector1 = Vector[1, 2, 3]
      vector2 = Vector[4, 5, 6]

      inner_product = vector1.inner_product vector2

      inner_product.should.equal 1 * 4 + 2 * 5 + 3 * 6
    end
  end
end

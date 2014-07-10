# encoding: UTF-8

class QuadView < UIView
  COLOR = "#114488".uicolor
  PIN_POSITIONS = [
    [100, 150], [650, 150], [100, 900], [650, 900]
  ]
  attr_reader :points

  def initWithFrame(frame)
    super

    @pins = PIN_POSITIONS.each_with_index.map do |position, index|
      UIButton.alloc.initWithFrame([position, [20, 20]]).tap do |pin|
        pin.backgroundColor = COLOR
      end
    end

    @pins.each &method(:addSubview)

    @pins.each do |pin|
      pin.on(:touch_drag_inside, :touch_drag_outside) do |pin, event|
        touch = event.allTouches.anyObject
        pin.center = touch.locationInView(self)
        setNeedsDisplay
      end
    end

    self
  end

  def points
    @pins.map(&:center)
  end

  def drawRect(rect)
    return unless @pins
    points = sorted_points
    context = UIGraphicsGetCurrentContext()
    CGContextSetStrokeColorWithColor(context, COLOR.CGColor)
    CGContextSetLineWidth(context, 2.0)

    line_points = points + [points.first]
    line_points.each_cons(2) do |from, to|
      CGContextMoveToPoint(context, from.x, from.y)
      CGContextAddLineToPoint(context, to.x, to.y)
    end

    CGContextStrokePath(context)
  end

  private

  def sorted_points
    center_vector = points_center
    points.sort_by! do |point|
      vector_from_center = (Vector[*point] - center_vector)
      Math.atan2 *vector_from_center.normalize.to_a
    end
  end

  def points_center
    points.map { |point| Vector[*point] }.reduce(:+) / points.size.to_f
  end
end

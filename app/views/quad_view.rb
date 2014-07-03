# encoding: UTF-8

class QuadView < UIView
  COLOR = "#114488".uicolor
  attr_reader :points

  def points=(points)
    @points = points
    sort_points!
    setNeedsDisplay
  end

  def drawRect(rect)
    @points ||= []
    context = UIGraphicsGetCurrentContext()
    CGContextSetStrokeColorWithColor(context, COLOR.CGColor)
    CGContextSetLineWidth(context, 2.0)

    line_points = @points + [@points.first]
    line_points.each_cons(2) do |from, to|
      CGContextMoveToPoint(context, from.x, from.y)
      CGContextAddLineToPoint(context, to.x, to.y)
    end

    CGContextStrokePath(context)
  end

  private

  def sort_points!
    center_vector = points_center
    @points.sort_by! do |point|
      vector_from_center = (Vector[*point] - center_vector)
      Math.atan2 *vector_from_center.normalize.to_a
    end
  end

  def points_center
    @points.map { |point| Vector[*point] }.reduce(:+) / @points.size.to_f
  end
end

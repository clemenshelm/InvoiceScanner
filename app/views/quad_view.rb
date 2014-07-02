class QuadView < UIView
  attr_reader :points

  def points=(points)
    @points = points
    setNeedsDisplay
  end

  def drawRect(rect)
    @points ||= []
    context = UIGraphicsGetCurrentContext()
    #color = UIColor.colorWithRed(0.0039, green:0.2314, blue:0.4667, alpha:1).CGColor
    #CGContextSetStrokeColorWithColor(context, "#114488".uicolor)
    CGContextSetStrokeColorWithColor(context, "#114488".uicolor.CGColor)
    CGContextSetLineWidth(context, 2.0)

    line_points = @points + [@points.first]
    line_points.each_cons(2) do |from, to|
      CGContextMoveToPoint(context, from.x, from.y)
      CGContextAddLineToPoint(context, to.x, to.y)
    end

    CGContextStrokePath(context)
  end
end

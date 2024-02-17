CollisionHelper = object
  // Rect collisions
  
  rectOverlapsPoint = function(rectCenterX, rectCenterY, rectWidth, rectHeight, x, y)
  // Calculate the left, right, top, and bottom bounds of the rectangle
    local left = rectCenterX - rectWidth / 2
    local right = rectCenterX + rectWidth / 2
    local top = rectCenterY - rectHeight / 2
    local bottom = rectCenterY + rectHeight / 2
  
    // Check if the point is within these bounds
    if x >= left and x <= right and y >= top and y <= bottom then
      return true
    else
      return false
    end
  end
  
  rectOverlapsRect = function(rect1CenterX, rect1CenterY, rect1Width, rect1Height, rect2CenterX, rect2CenterY, rect2Width, rect2Height)
    // Calculate the horizontal and vertical distances between the rects' centers
    local dx = abs(rect1CenterX - rect2CenterX)
    local dy = abs(rect1CenterY - rect2CenterY)
  
    // Calculate the sum of half-widths and half-heights
    local widthSumHalf = (rect1Width / 2) + (rect2Width / 2)
    local heightSumHalf = (rect1Height / 2) + (rect2Height / 2)
  
    // If the horizontal distance is less than the sum of half-widths and the vertical distance is less than the sum of half-heights, the rectes overlap
    if dx < widthSumHalf and dy < heightSumHalf then
      return true
    else
      return false
    end
  end
  
  rectOverlapsCircle = function(rectCenterX, rectCenterY, rectWidth, rectHeight, circleCenterX, circleCenterY, circleRadius)
    // Find the horizontal and vertical distances from the circle's center to the rect's center
    local dx = abs(circleCenterX - rectCenterX)
    local dy = abs(circleCenterY - rectCenterY)
  
    // Check if the circle's center is outside of the rect's bounds, including the radius
    if dx > (rectWidth / 2 + circleRadius) then return false end
    if dy > (rectHeight / 2 + circleRadius) then return false end
  
    // Check if the circle's center is inside the rect's bounds
    if dx <= (rectWidth / 2) then return true end
    if dy <= (rectHeight / 2) then return true end
  
    // Check if the circle's center is within the corner regions of the rect
    local cornerDistance_sq = (dx - rectWidth / 2)^2 + (dy - rectHeight / 2)^2
  
    return cornerDistance_sq <= (circleRadius^2)
  end
  
  rectOverlapsOval = function(rectCenterX, rectCenterY, rectWidth, rectHeight, ovalCenterX, ovalCenterY, ovalWidth, ovalHeight)
    // Normalize distances by dividing by oval radii
    local ovalRadiusX = ovalWidth / 2
    local ovalRadiusY = ovalHeight / 2
    
    // Find the distance from the oval's center to the rect's center, normalized by the oval's radii
    local dx = abs(ovalCenterX - rectCenterX) / ovalRadiusX
    local dy = abs(ovalCenterY - rectCenterY) / ovalRadiusY
    
    // Half dimensions of the rect, for comparison with normalized distances
    local halfWidth = rectWidth / 2 / ovalRadiusX
    local halfHeight = rectHeight / 2 / ovalRadiusY
    
    // Check if the oval's center is outside the extended bounds of the rect
    if dx > halfWidth + 1 then return false end
    if dy > halfHeight + 1 then return false end
    
    // Check if the oval's center is within the rect's bounds (considering normalization)
    if dx <= halfWidth then return true end
    if dy <= halfHeight then return true end
    
    // For corner cases, check if the closest point in the rect to the oval's center lies within the oval
    // This is equivalent to checking if the point is within a unit circle from the oval's center, after normalization.
    local cornerDistanceSq = ((dx - halfWidth)^2 + (dy - halfHeight)^2)
    
    // Since everything is normalized, comparing with 1 (the radius of our "unit circle") is sufficient
    return cornerDistanceSq <= 1
  end


  // Circle collisions
  
  circleOverlapsPoint = function(circleCenterX, circleCenterY, circleRadius, x, y)
    // Calculate the distance from the point to the circle's center
    local dx = x - circleCenterX
    local dy = y - circleCenterY
    local distance = math.sqrt(dx^2 + dy^2)
  
    // Check if the distance is within the circle's radius
    if distance <= circleRadius then
      return true
    else
      return false
    end
  end


  circleOverlapsCircle = function(circle1CenterX, circle1CenterY, circle1Radius, circle2CenterX, circle2CenterY, circle2Radius)
    // Calculate the distance between the centers of the two circles
    local dx = circle2CenterX - circle1CenterX
    local dy = circle2CenterY - circle1CenterY
    local distance = sqrt(dx^2 + dy^2)
  
    // Calculate the sum of the radii of the two circles
    local radiiSum = circle1Radius + circle2Radius
  
    // If the distance between centers is less than or equal to the sum of the radii, the circles overlap
    if distance <= radiiSum then
      return true
    else
      return false
    end
  end
  
  circleOverlapsOval = function(circleCenterX, circleCenterY, circleRadius, ovalCenterX, ovalCenterY, ovalWidth, ovalHeight)
    // Normalize the oval to a circle by adjusting the coordinate scale
    local normalizedCircleX = (circleCenterX - ovalCenterX) / (ovalWidth / 2)
    local normalizedCircleY = (circleCenterY - ovalCenterY) / (ovalHeight / 2)
    
    // Calculate the distance from the normalized circle center to the normalized oval (now circle) center
    local distance = sqrt(normalizedCircleX^2 + normalizedCircleY^2)
    
    // Normalize the circle's radius by the average of the oval's radii (for a uniform scale comparison)
    local averageOvalRadius = (ovalWidth + ovalHeight) / 4
    local normalizedRadius = circleRadius / averageOvalRadius
    
    // Check if the distance is less than or equal to the sum of the radii (considering the oval as a unit circle after normalization)
    if distance <= (1 + normalizedRadius) then
      return true
    else
      return false
    end
  end
  
  // Oval collisions
  
  ovalOverlapsPoint = function(ovalCenterX, ovalCenterY, ovalWidth, ovalHeight, x, y)
    // Calculate the radii along the x and y axes
    local radiusX = ovalWidth / 2
    local radiusY = ovalHeight / 2
  
    // Normalize the point's coordinates relative to the oval's center
    local dx = x - ovalCenterX
    local dy = y - ovalCenterY
  
    // Check if the point is within the oval using the ellipse equation
    if (dx^2) / (radiusX^2) + (dy^2) / (radiusY^2) <= 1 then
      return true
    else
      return false
    end
  end

  ovalOverlapsOval = function(oval1CenterX, oval1CenterY, oval1Width, oval1Height, oval2CenterX, oval2CenterY, oval2Width, oval2Height)
    // Approximate both ovals to circles by using their average radii
    local oval1Radius = (oval1Width + oval1Height) / 4
    local oval2Radius = (oval2Width + oval2Height) / 4
    
    // Calculate the distance between the centers of the two ovals
    local dx = oval2CenterX - oval1CenterX
    local dy = oval2CenterY - oval1CenterY
    local distance = sqrt(dx^2 + dy^2)
    
    // Check if the distance is less than the sum of the approximate radii
    return distance <= (oval1Radius + oval2Radius)
  end
end















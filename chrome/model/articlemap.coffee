class @Rect
  constructor: (@x = 0, @y = 0, @width = 0, @height = 0) ->

  isEqual: (other) ->
    return @x == other.x and @y == other.y and @width == other.width and @height == other.height

  copy: () ->
    return new Rect(@x, @y, @width, @height)

  area: ()->
    return @width * @height

  ratio: () ->
    return @width / @height

  vec4: () ->
    return [@x, @y, @width, @height]

class RectType
  constructor: (@ratio, @minAlign = 1) ->

@rectTypes =
  'image': [
    new RectType(0.9, 1)
    new RectType(1.6, 1)
    new RectType(3.0, 2)
    new RectType(3.8, 2)
  ]
  'text': [
    new RectType(3.8, 1)
    new RectType(1.0, 1)
  ]

class @Page
  constructor: (@priority, @type, @name = null) ->
    @originalPriority = @priority
    @rect = new Rect()
    @id = Math.random()
    @idealArea = 0

  isEqual: (other)->
    return if other.id then @id == other.id else false


@pageUtils =
  isGroup: (pageSet) ->
    return pageSet instanceof Array

  prioritySum: (pageSets) ->
    if !pageUtils.isGroup(pageSets)
      return pageSets.priority

    s = 0
    for i in [0...pageSets.length]
      s += pageUtils.prioritySum(pageSets[i])
    return s

  length: (pageSets) ->
    if not pageUtils.isGroup(pageSets)
      return 1

    s = 0
    for i in [0...pageSets.length]
      s += pageUtils.length(pageSets[i])
    return s

  avg: (pageSets) ->
    return pageUtils.prioritySum(pageSets) / pageUtils.length(pageSets)

  max: (pageSets) ->
    if !pageUtils.isGroup(pageSets)
      return pageSets
    maxi = 0
    maxIndex = 0
    for i in [0...pageSets.length]
      v = pageUtils.avg[pageSets[i]]
      if maxi < v
        maxi = v
        maxIndex = i
    return pageSets[maxIndex]

  sort: (pageSets, reverse = false, key = null) ->
    if !key
      key = (a, b) -> pageUtils.prioritySum(a) - pageUtils.prioritySum(b)
    pageSets.sort(key)
    if reverse
      pageSets.reverse()


  idealSum: (pageSets) ->
    if !pageUtils.isGroup(pageSets)
      return pageSets.idealArea

    s = 0
    for i in [0...pageSets.length]
      s += pageUtils.idealSum(pageSets[i])
    return s

  grouping: (pageSets, range = 1.3) ->
    # Grouping pages whose type is same and priority difference is within range.
    # args:
    #   pageSets: Flat array. ( ex. [new Page(1, "text"), new Page(2, "text")] )
    pageSets = [].concat(pageSets)

    pageUtils.sort(pageSets)

    top = pageSets.pop()
    groups = [[top]]

    for rectType of rectTypes
      # Get pageSets whose type is same.
      pages = (pageSet for pageSet in pageSets when pageSet.type == rectType)
      pageUtils.sort(pages, reverse = true)


      while pages.length > 0
        base = pages.pop()
        group = [base]

        if pages.length > 0 and pages[pages.length - 1].originalPriority <= Math.ceil(base.originalPriority * range)
          group.push(pages.pop())
        groups.push(group)

    pageUtils.sort(groups, reverse = true, key = (a, b)-> pageUtils.avg(a) - pageUtils.avg(b))
    return groups

  getOptimumSet: (pageSets, rect) ->
    s = Infinity
    #    match = Infinity | 1000000000000
    optimumSet = null
    #    for i in [1..4] # Change value depends on pageSet length.
    #      dict = pageUtils.combination(pageSets, i, s, match, optimumSet)
    #      match = dict.match
    #      optimumSet = dict.optimumSet

    # TODO:// Implement combination function!

    for i in [1...1 << pageSets.length]
      bit = 0
      j = i
      set = []
      idealSum = 0
      for k in [0...pageSets.length]
        if j % 2 == 1
          idealSum += pageUtils.idealSum(pageSets[k])
          set.push(pageSets[k])
          bit++
        j = j >> 1

      if bit < 3 and Math.abs(rect.area() - idealSum) < s
        s = Math.abs(rect.area() - idealSum)
        optimumSet = set
    return optimumSet

  combination: (pageSets, n, s, match, optimumSet) ->
    if pageSets.length < n
      return {"match": match, "optimumSet": optimumSet}

    for pageSet in pageUtils.nCombination(pageSets, n)
      areaSum = pageUtils.sum(pageSet, (x) -> pageUtils.idealSum(x))
      if Math.abs(s - areaSum) < Math.abs(s - match)
        optimumSet = pageSet
        match = areaSum
    return {"match": match, "optimumSet": optimumSet}

  nCombination: (sets, n) ->
    if sets.length < n or n <= 0
      return []

    if sets.length == n
      return [sets]

    if n == 1
      return (c for c in sets)

    combs = []
    for i in [0...sets.length - n + 1]
      head = sets.slice(i, i + 1);
      tailcombs = pageUtils.nCombination(sets.slice(i + 1), n - 1)
      for j in [0...tailcombs.length]
        combs.push(head.concat(tailcombs[j]))
    return combs

  deformPriorities: (pageSets, area, min_width, min_height) ->
    prioritySum = pageUtils.prioritySum(pageSets)
    areaMin = min_height * min_height
    x = (area / areaMin) / prioritySum

    for pageSet in pageSets
      if pageUtils.isGroup(pageSet)
        for page in pageSet
          page.priority = Math.ceil(x * page.priority)
      else
        pageSet.priority = Math.ceil(x * pageSet.priority)


  debug: (pageSets) ->
    if !pageUtils.isGroup(pageSets)
      return pageSets.priority
    return (pageUtils.debug(pageSet) for pageSet in pageSets)

  diffRatio: (rect, rectType, align = 0) ->
    minRatio = 10000
    for t in rectTypes[rectType]
      if align > 0 and align < t.minAlign
        continue
      ratio = rect.width / rect.height
      minRatio = Math.min(minRatio, if t.ratio < ratio then ratio / t.ratio else t.ratio / ratio)
    return minRatio

  isFlat: (pageSets) ->
    for page in pageSets
      if pageUtils.isGroup(page)
        return false
    return true

  sum: (array, f = null) ->
    if !f
      f = (x) -> return x
    s = 0
    for a in array
      s += f(a)
    return s


DEFAULT_WIDTH = 500
DEFAULT_HEIGHT = 500
class @Base
  constructor: (data = null, @pageSets = null, @width = DEFAULT_WIDTH, @height = DEFAULT_HEIGHT, @minWidth = 100, @minHeight = 60) ->
    if !pageSets
      @pageSets = @createPageSets(data)
    @layoutOrder = []

  createPageSets: (data) ->
    return (new Page(d.priority, d.type, d.name) for d in data)

  setIdealArea: (pageSets) ->
    prioritySum = pageUtils.prioritySum(pageSets)
    area = @width * @height

    @calcIdealArea(pageSets, area, prioritySum)

  calcIdealArea: (pageSets, area, prioritySum) ->
    if !pageUtils.isGroup(pageSets)
      pageSets.idealArea = pageSets.priority * area / prioritySum
    else
      for pageSet in pageSets
        @calcIdealArea(pageSet, area, prioritySum)

  newSets: (pageSets, targets) ->
    if !pageUtils.isGroup(target)
      targets = [targets]

    for target in targets
      @layoutOrder.push(target)

    sets = []
    for pageSet in pageSets
      isSame = false
      for target in targets
        if target == pageSet
          isSame = true
          break
      if !isSame
        sets.push(pageSet)
    return sets

class @GreedyLayout extends Base
  layout: () ->
    pageUtils.sort(@pageSets)
    groupSets = pageUtils.grouping(@pageSets)
    pageUtils.deformPriorities(groupSets, @width * @height, @minWidth, @minHeight)
    @setIdealArea(groupSets)
    pageUtils.sort(groupSets, true, pageUtils.avg)
    @arrange(groupSets, new Rect(0, 0, @width, @height))

  arrange: (pageSets, rect) ->
    if pageSets.length < 1
      return
    else if pageSets.length < 3
      @split(pageSets, rect)
    else
      @arrangeTopLeft(pageSets, rect)

  split: (pageSets, rect) ->
    verticalRects = @splitPageSetsArea(pageSets, rect, true, false)
    diff = 0
    for verticalRect, i in verticalRects
      ratioType = if pageUtils.isGroup(pageSets[i]) then pageSets[i][0].type else pageSets[i].type
      diff += pageUtils.diffRatio(verticalRect, ratioType)

    minDiff = diff
    isVertical = true
    horizontalRects = @splitPageSetsArea(pageSets, rect, false, false)

    diff = 0
    for horizontalRect, i in horizontalRects
      ratioType = if pageUtils.isGroup(pageSets[i]) then pageSets[i][0].type else pageSets[i].type
      diff += pageUtils.diffRatio(horizontalRect, ratioType)

    if diff < minDiff
      isVertical = false

    @splitPageSetsArea(pageSets, rect, isVertical, true)

  arrangeTopLeft: (pageSets, rect) ->
    tops = pageUtils.max(pageSets)
    remainingSets = @newSets(pageSets, tops)

    optimalTopRect = null
    optimalSets = []
    minDiff = 100000000000000
    idealArea = pageUtils.idealSum(tops)
    isVertical = false

    for rectType in rectTypes[tops[0].type]
      if tops.length < rectType.minAlign
        continue

      d = @fixTopLeftRect(remainingSets, rect, idealArea, rectType.ratio / tops.length)
      if d.diff < minDiff
        minDiff = d.diff
        optimalTopRect = d.topRect
        optimalSets = d.pageSets
        isVertical = true

      d = @fixTopLeftRect(remainingSets, rect, idealArea, rectType.ratio * tops.length)
      if d.diff < minDiff
        minDiff = d.diff
        optimalTopRect = d.topRect
        optimalSets = d.pageSets

    width = (pageUtils.idealSum(tops) + pageUtils.idealSum(optimalSets)) / rect.height
    optimalTopRect.height = optimalTopRect.area() / width
    optimalTopRect.width = width

    bottomSetsRect = @bottomRect(rect, optimalTopRect)
    remainingRect = rect.copy()
    remainingRect.x += width
    remainingRect.width -= width

    for target in optimalSets
      remainingSets = @newSets(remainingSets, target)

    @split(tops, optimalTopRect)
    @arrange(optimalSets, bottomSetsRect)
    @arrange(remainingSets, remainingRect)


  fixTopLeftRect: (remainingSets, parentRect, idealArea, ratio) ->
    topRect = parentRect.copy()

    topRect.height = Math.sqrt(idealArea / ratio)
    topRect.width = ratio * topRect.height

    if parentRect.width - topRect.width < @minWidth
      topRect.width = parentRect.width
      topRect.height = idealArea / topRect.width
      return  {diff: 0.5* pageUtils.length(remainingSets), pageSets: remainingSets, topRect: topRect}

    if parentRect.height - topRect.height < @minHeight
      topRect.height = parentRect.height
      topRect.width = idealArea / topRect.height
      return  {diff: 0, pageSets: [], topRect: topRect}

    bottomRect = @bottomRect(parentRect, topRect)
    diff_dict = @diffFromIdealArea(remainingSets, bottomRect)
    diff_dict['topRect'] = topRect
    return diff_dict


  diffFromIdealArea: (remainingSets, bottomRect) ->
    bottomSets = pageUtils.getOptimumSet(remainingSets, bottomRect)
    closest_area = pageUtils.idealSum(bottomSets)
    return {diff: Math.abs(bottomRect.area() - closest_area), pageSets: bottomSets}


  bottomRect: (parentRect, topRect) ->
    return new Rect(parentRect.x,
      parentRect.y + topRect.height,
      topRect.width,
      parentRect.height - topRect.height)


  splitPageSetsArea: (pageSets, rect, isVertical = true, fix = true) ->
    idealSum = pageUtils.idealSum(pageSets)
    isFlat = pageUtils.isFlat(pageSets)
    tmpRect = rect.copy()
    tmpRects = []

    if isFlat
      tmpRect.height = rect.height / pageSets.length if isVertical
      tmpRect.width = rect.width / pageSets.length if !isVertical

    for page in pageSets
      if !isFlat
        tmpRect.height = rect.height * (pageUtils.idealSum(page) / idealSum) if isVertical
        tmpRect.width = rect.width * (pageUtils.idealSum(page) / idealSum) if !isVertical

      pageRect = tmpRect.copy()
      tmpRect.y += tmpRect.height if isVertical
      tmpRect.x += tmpRect.width if !isVertical

      if !fix
        tmpRects.push(pageRect)
        continue

      if pageUtils.isGroup(page)
        @arrange(page, pageRect)
      else
        page.rect = pageRect

    return tmpRects

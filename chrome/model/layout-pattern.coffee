class @LayoutPattern
  constructor: ()->
    @patterns = [
      new Pattern(200, new AspectRatio(1.4, 1.6), new ImageRatio(1.0, 0.7)),
      new Pattern(180, new AspectRatio(0.5, 0.7), new ImageRatio(1.0, 0.4)),
      new Pattern(100, new AspectRatio(1.8, 2.0), new ImageRatio(0.5, 1)),
      new Pattern(100, new AspectRatio(1.0, 1.2), null)
    ]

class Pattern
  construnctor: (@minWidth, @aspectRatio, @imageRatio)->

class AspectRatio
  constructor:(@minRatio, @maxRaio)->

class ImageRatio
  constructor:(@width, @height)->
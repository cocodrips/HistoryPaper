#import TinySegmentator / Util
class @Content
  constructor: (plain_text)->
    @keywords = @extractKeyword(plain_text)

  extractKeyword: (plain_text) ->
    words = @extractWords(plain_text)
    keywords = []
    for word in words
      if Utils.isKeyword(word) then keywords.push(word)
    return keywords

  extractWords: (plain_text)->
    segmenter = new TinySegmenter()
    return segmenter.segment(plain_text)


plain_text =  document.documentElement.innerText
segmenter = new TinySegmenter()
words = segmenter.segment(plain_text)
console.log isKeyword(word) for word in words
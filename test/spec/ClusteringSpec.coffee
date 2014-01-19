describe "Clustering", ->
  beforeEach ->
    @clustering = new Clustering(histories)

  afterEach ->
    # do something

  it "historiesにキーワード要素を追加", () ->
    @clustering.addKeys2Histories()

  it "TOPキーワードの決定", () ->
    expect(@clustering.selectTopKeywords(5)).toEqual([ 'JavaScript', 'js', 'Underscore', '配列', 'オブジェクト' ]);

  it "キーワードであるかどうかを判定する", () ->
    target = "楽しい"
    expect(@clustering.isKeyword(target)).toBeTruthy()
    target = "あ"
    expect(@clustering.isKeyword(target)).toBeFalsy()
    target = "今回"
    expect(@clustering.isKeyword(target)).toBeFalsy()


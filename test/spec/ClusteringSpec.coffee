describe "Clustering", ->
  beforeEach ->
    @clustering = new Clustering(histories)

#  afterEach ->

  it "historiesにキーワード要素を追加", () ->
    @clustering.setWords2Histories()
    @clustering.setKeys2Histories()
    expect(@clustering.histories[0].words).toEqual([ 'Jasmine', ' ', 'Spec', ' ', 'Runner', ' ', 'v', '2', '.', '0', '.', '0' ]);
    expect(@clustering.histories[0].keywords).toEqual(["Jasmine","Spec","Runner"]);

  it "selectTopKeywords: TOPキーワードの決定", () ->
    expect(@clustering.selectTopKeywords(5)).toEqual([ 'JavaScript', 'js', 'Underscore', '配列', 'オブジェクト' ]);

  it "isKeyword: キーワードであるかどうかを判定する", () ->
    target = "楽しい"
    expect(@clustering.isKeyword(target)).toBeTruthy()
    target = "あ"
    expect(@clustering.isKeyword(target)).toBeFalsy()
    target = "今回"
    expect(@clustering.isKeyword(target)).toBeFalsy()


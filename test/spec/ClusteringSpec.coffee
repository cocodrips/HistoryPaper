describe "Clustering", ->
  beforeEach ->
    @clustering = new Clustering(histories)

  afterEach ->
    # do something

  it "TOPキーワードの決定", () ->
    expect(@clustering.selectTopKeywords(5)).toEqual(['array', 'Google', '検索', '改行', '削除']);

  it "キーワードであるかどうかを判定する", () ->
    target = "楽しい"
    expect(@clustering.isKeyword(target)).toBeTruthy()
    target = "あ"
    expect(@clustering.isKeyword(target)).toBeFalsy()
    target = "今回"
    expect(@clustering.isKeyword(target)).toBeFalsy()


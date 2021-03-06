describe "Clustering", ->
  beforeEach ->
    @clustering = new Clustering(histories)

  it "constructor", () ->
    expect(@clustering.histories.length).toEqual(68)


  it "historiesにTopワードを追加", () ->
    @clustering.setWords2Histories()
    expect(@clustering.histories[0].words).toEqual([ 'Jasmine', ' ', 'Spec', ' ', 'Runner', ' ', 'v', '2', '.', '0', '.', '0' ]);

  it "historiesにキーワード要素を追加", () ->
    @clustering.setWords2Histories()
    @clustering.setKeys2Histories()
    expect(@clustering.histories[0].coordinate).toEqual({"JavaScript":0,"js":0,"Underscore":0,"配列":0,"オブジェクト":0,"連想":0,"cocodrips":0,"ソート":0,"MDN":0,"Object":0,"javascript":0,"リファレンス":0,"HistoryPaper":0,"Jasmine":1,"Twitter":0,"Gists":0,"Qiita":0,"キータ":0,"日記":0,"Developer":0,"リスト":0,"sort":0,"Array":0,"Runner":1,"要素":0,"reverse":0,"Spec":1,"doremi":0,"Room":0,"PHP":0,"DOM":0,"key":0,"form":0,"値":0,"ライブラリ":0,"タプル":0,"Textarea":0,"library":0,"compatible":0,"Dash":0,"Lo":0,"jQuery":0,"weight":0,"aerogel":0,"map":0,"Zepto":0,"標準":0,"diary":0,"or1ko":0,"関数":0,"zip":0,"のせき":0,"ライブラリUnderscore":0,"満載":0,"機能":0,"便利":0,"作る":0,"サービス":0,"Web":0,"OAuth":0,"MongoDB":0,"NodeJS":0,"Wikibooks":0,"AngularJS":0,"クリエイターズブログ":0,"公式":0,"サイバーエージェント":0,"pixel":0,"高める":0,"効率":0,"開発":0,"documentation":0,"Tips":0,"Script":0,"Java":0,"使用":0,"Javascriptメモ":0,"You":0,"Look":0,"Too":0,"Cool":0,"取得":0,"【JavaScript":0,"Set":0,"Network":0,"Mozilla":0,"Drawer":0,"WEB":0,"順番":0,"特定":0,"．":0,"返す":0,"asort":0,"arsort":0,"toguni":0,"たい":0,"Thousand":0,"Years":0,"nacika":0,"yomukaku":0} );


  it "selectTopKeywords: TOPキーワードの決定", () ->
    @clustering.setWords2Histories()
    expect(@clustering.selectTopKeywords(5)).toEqual([ 'JavaScript', 'js', 'Underscore', '配列', 'オブジェクト' ]);

  it "isKeyword: キーワードであるかどうかを判定する", () ->
    target = "楽しい"
    expect(Utils.isKeyword(target)).toBeTruthy()
    target = "あ"
    expect(Utils.isKeyword(target)).toBeFalsy()
    target = "今回"
    expect(Utils.isKeyword(target)).toBeFalsy()

  it "getClusterHistories: クラスタのHistoryを配列にして返す", () ->
    @clustering.clusteringHistories()
    histories = @clustering.getClusterHistories(0)
    expect(histories[0].id).toEqual("15113")



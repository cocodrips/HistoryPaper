var stopwords = {"":1,"!":1,"$":1,"%":1,"&":1,"'":1,"(":1,")":1,"*":1,"+":1,",":1,"-":1,".":1,"/":1,"0":1,"1":1,"2":1,"3":1,"4":1,"5":1,"6":1,"7":1,"8":1,"9":1,":":1,"=":1,"?":1,"@":1,"[":1,"\"":1,"]":1,"^":1,"_":1,"a":1,"a's":1,"able":1,"about":1,"above":1,"according":1,"accordingly":1,"across":1,"actually":1,"after":1,"afterwards":1,"again":1,"against":1,"ain't":1,"all":1,"allow":1,"allows":1,"almost":1,"alone":1,"along":1,"already":1,"also":1,"although":1,"always":1,"am":1,"among":1,"amongst":1,"an":1,"and":1,"another":1,"any":1,"anybody":1,"anyhow":1,"anyone":1,"anything":1,"anyway":1,"anyways":1,"anywhere":1,"apart":1,"appear":1,"appreciate":1,"appropriate":1,"are":1,"aren't":1,"around":1,"as":1,"aside":1,"ask":1,"asking":1,"associated":1,"at":1,"automatically":1,"available":1,"away":1,"awfully":1,"b":1,"be":1,"became":1,"because":1,"become":1,"becomes":1,"becoming":1,"been":1,"before":1,"beforehand":1,"behind":1,"being":1,"believe":1,"below":1,"beside":1,"besides":1,"best":1,"better":1,"between":1,"beyond":1,"both":1,"brief":1,"but":1,"by":1,"c":1,"c'mon":1,"c's":1,"came":1,"can":1,"can't":1,"cannot":1,"cant":1,"cause":1,"causes":1,"certain":1,"certainly":1,"changes":1,"clearly":1,"co":1,"com":1,"come":1,"comes":1,"concerning":1,"consequently":1,"consider":1,"considering":1,"contain":1,"containing":1,"contains":1,"corresponding":1,"could":1,"couldn't":1,"course":1,"current":1,"currently":1,"d":1,"definitely":1,"described":1,"despite":1,"did":1,"didn't":1,"different":1,"do":1,"does":1,"doesn't":1,"doing":1,"don't":1,"done":1,"down":1,"downwards":1,"during":1,"e":1,"each":1,"edu":1,"eg":1,"eight":1,"either":1,"else":1,"elsewhere":1,"enough":1,"entirely":1,"especially":1,"et":1,"etc":1,"even":1,"ever":1,"every":1,"everybody":1,"everyone":1,"everything":1,"everywhere":1,"ex":1,"exactly":1,"example":1,"except":1,"f":1,"far":1,"few":1,"fifth":1,"file":1,"files":1,"first":1,"five":1,"followed":1,"following":1,"follows":1,"for":1,"former":1,"formerly":1,"forth":1,"four":1,"from":1,"further":1,"furthermore":1,"g":1,"get":1,"gets":1,"getting":1,"given":1,"gives":1,"go":1,"goes":1,"going":1,"gone":1,"got":1,"gotten":1,"greetings":1,"h":1,"had":1,"hadn't":1,"happens":1,"hardly":1,"has":1,"hasn't":1,"have":1,"haven't":1,"having":1,"he":1,"he's":1,"hello":1,"help":1,"hence":1,"her":1,"here":1,"here's":1,"hereafter":1,"hereby":1,"herein":1,"hereupon":1,"hers":1,"herself":1,"hi":1,"him":1,"himself":1,"his":1,"hither":1,"hopefully":1,"how":1,"howbeit":1,"however":1,"i":1,"i'd":1,"i'll":1,"i'm":1,"i've":1,"ie":1,"if":1,"ignored":1,"immediate":1,"in":1,"inasmuch":1,"inc":1,"indeed":1,"indicate":1,"indicated":1,"indicates":1,"inner":1,"insofar":1,"instead":1,"into":1,"inward":1,"is":1,"isn't":1,"it":1,"it'd":1,"it'll":1,"it's":1,"its":1,"itself":1,"j":1,"just":1,"k":1,"keep":1,"keeps":1,"kept":1,"know":1,"known":1,"knows":1,"l":1,"last":1,"lately":1,"later":1,"latter":1,"latterly":1,"least":1,"less":1,"lest":1,"let":1,"let's":1,"like":1,"liked":1,"likely":1,"little":1,"look":1,"looking":1,"looks":1,"ltd":1,"m":1,"mainly":1,"manual":1,"many":1,"may":1,"maybe":1,"me":1,"mean":1,"meanwhile":1,"merely":1,"might":1,"more":1,"moreover":1,"most":1,"mostly":1,"much":1,"must":1,"my":1,"myself":1,"n":1,"name":1,"namely":1,"nd":1,"near":1,"nearly":1,"necessary":1,"need":1,"needs":1,"neither":1,"never":1,"nevertheless":1,"new":1,"next":1,"nine":1,"no":1,"nobody":1,"non":1,"none":1,"noone":1,"nor":1,"normally":1,"not":1,"nothing":1,"novel":1,"now":1,"nowhere":1,"o":1,"obviously":1,"of":1,"off":1,"often":1,"oh":1,"ok":1,"okay":1,"old":1,"on":1,"once":1,"one":1,"ones":1,"only":1,"onto":1,"or":1,"other":1,"others":1,"otherwise":1,"ought":1,"our":1,"ours":1,"ourselves":1,"out":1,"outside":1,"over":1,"overall":1,"own":1,"p":1,"particular":1,"particularly":1,"per":1,"perhaps":1,"placed":1,"please":1,"plus":1,"possible":1,"presumably":1,"probably":1,"programmer's":1,"provides":1,"q":1,"que":1,"quite":1,"qv":1,"r":1,"rather":1,"rd":1,"re":1,"really":1,"reasonably":1,"regarding":1,"regardless":1,"regards":1,"relatively":1,"respectively":1,"return":1,"returned":1,"returns":1,"right":1,"s":1,"said":1,"same":1,"saw":1,"say":1,"saying":1,"says":1,"second":1,"secondly":1,"see":1,"seeing":1,"seem":1,"seemed":1,"seeming":1,"seems":1,"seen":1,"self":1,"selves":1,"sensible":1,"sent":1,"serious":1,"seriously":1,"seven":1,"several":1,"shall":1,"she":1,"should":1,"shouldn't":1,"since":1,"six":1,"so":1,"some":1,"somebody":1,"somehow":1,"someone":1,"something":1,"sometime":1,"sometimes":1,"somewhat":1,"somewhere":1,"soon":1,"sorry":1,"specified":1,"specify":1,"specifying":1,"still":1,"sub":1,"such":1,"sup":1,"sure":1,"t":1,"t's":1,"take":1,"taken":1,"tell":1,"tends":1,"th":1,"than":1,"thank":1,"thanks":1,"thanx":1,"that":1,"that's":1,"thats":1,"the":1,"their":1,"theirs":1,"them":1,"themselves":1,"then":1,"thence":1,"there":1,"there's":1,"thereafter":1,"thereby":1,"therefore":1,"therein":1,"theres":1,"thereupon":1,"these":1,"they":1,"they'd":1,"they'll":1,"they're":1,"they've":1,"think":1,"third":1,"this":1,"thorough":1,"thoroughly":1,"those":1,"though":1,"three":1,"through":1,"throughout":1,"thru":1,"thus":1,"to":1,"together":1,"too":1,"took":1,"toward":1,"towards":1,"tried":1,"tries":1,"truly":1,"try":1,"trying":1,"twice":1,"two":1,"u":1,"un":1,"under":1,"unfortunately":1,"unix":1,"unless":1,"unlikely":1,"until":1,"unto":1,"up":1,"upon":1,"us":1,"use":1,"used":1,"useful":1,"uses":1,"using":1,"usually":1,"uucp":1,"v":1,"value":1,"various":1,"very":1,"via":1,"viz":1,"vs":1,"w":1,"want":1,"wants":1,"was":1,"wasn't":1,"way":1,"we":1,"we'd":1,"we'll":1,"we're":1,"we've":1,"welcome":1,"well":1,"went":1,"were":1,"weren't":1,"what":1,"what's":1,"whatever":1,"when":1,"whence":1,"whenever":1,"where":1,"where's":1,"whereafter":1,"whereas":1,"whereby":1,"wherein":1,"whereupon":1,"wherever":1,"whether":1,"which":1,"while":1,"whither":1,"who":1,"who's":1,"whoever":1,"whole":1,"whom":1,"whose":1,"why":1,"will":1,"willing":1,"wish":1,"with":1,"within":1,"without":1,"won't":1,"wonder":1,"would":1,"wouldn't":1,"x":1,"y":1,"yes":1,"yet":1,"you":1,"you'd":1,"you'll":1,"you're":1,"you've":1,"your":1,"yours":1,"yourself":1,"yourselves":1,"z":1,"zero":1,"{":1,"|":1,"}":1,"”":1,"、":1,"。":1,"「":1,"」":1,"『":1,"』":1,"【":1,"】":1,"ぁ":1,"あ":1,"あそこ":1,"あたり":1,"あちら":1,"あっち":1,"あと":1,"あな":1,"あなた":1,"あれ":1,"ぃ":1,"い":1,"いくつ":1,"いつ":1,"いま":1,"いや":1,"いろいろ":1,"ぅ":1,"う":1,"うち":1,"ぇ":1,"え":1,"ぉ":1,"お":1,"おおまか":1,"おまえ":1,"おれ":1,"か":1,"かく":1,"かたち":1,"かやの":1,"から":1,"が":1,"がい":1,"がら":1,"き":1,"きた":1,"ぎ":1,"く":1,"くせ":1,"ぐ":1,"け":1,"げ":1,"こ":1,"ここ":1,"こちら":1,"こっち":1,"こと":1,"これ":1,"これら":1,"ご":1,"ごっちゃ":1,"ごと":1,"ごろ":1,"さ":1,"さまざま":1,"さらい":1,"さん":1,"ざ":1,"し":1,"しかた":1,"しよう":1,"じ":1,"す":1,"すか":1,"すね":1,"すべて":1,"する":1,"ず":1,"ずつ":1,"せ":1,"ぜ":1,"ぜんぶ":1,"そ":1,"そう":1,"そこ":1,"そちら":1,"そっち":1,"そで":1,"その後":1,"それ":1,"それぞれ":1,"それなり":1,"ぞ":1,"た":1,"たくさん":1,"たち":1,"たび":1,"ため":1,"だ":1,"だめ":1,"ち":1,"ちゃ":1,"ちゃん":1,"ぢ":1,"っ":1,"つ":1,"づ":1,"て":1,"てん":1,"で":1,"です":1,"と":1,"とおり":1,"とき":1,"ところ":1,"ど":1,"どこ":1,"どこか":1,"どちら":1,"どっか":1,"どっち":1,"どれ":1,"な":1,"なか":1,"なかば":1,"など":1,"なに":1,"なん":1,"に":1,"ぬ":1,"ね":1,"の":1,"は":1,"はじめ":1,"はず":1,"はるか":1,"ば":1,"ぱ":1,"ひ":1,"ひと":1,"ひとつ":1,"び":1,"ぴ":1,"ふ":1,"ふく":1,"ぶ":1,"ぶり":1,"ぷ":1,"へ":1,"へん":1,"べ":1,"べつ":1,"ぺ":1,"ぺん":1,"ほ":1,"ほう":1,"ほか":1,"ぼ":1,"ぽ":1,"ま":1,"まさ":1,"まし":1,"まとも":1,"まま":1,"み":1,"みたい":1,"みつ":1,"みなさん":1,"みんな":1,"む":1,"め":1,"も":1,"もと":1,"もの":1,"もん":1,"ゃ":1,"や":1,"やつ":1,"ゅ":1,"ゆ":1,"ょ":1,"よ":1,"よう":1,"よそ":1,"ら":1,"り":1,"る":1,"れ":1,"ろ":1,"わ":1,"わけ":1,"わたし":1,"を":1,"ん":1,"カ所":1,"カ月":1,"ハイ":1,"レ":1,"ヵ所":1,"ヵ月":1,"ヶ所":1,"ヶ月":1,"・":1,"ー":1,"一":1,"一つ":1,"七":1,"万":1,"三":1,"上":1,"上記":1,"下":1,"下記":1,"中":1,"九":1,"事":1,"二":1,"五":1,"人":1,"今":1,"今回":1,"他":1,"以上":1,"以下":1,"以前":1,"以後":1,"以降":1,"会":1,"伸":1,"体":1,"何":1,"何人":1,"作":1,"例":1,"係":1,"俺":1,"個":1,"億":1,"元":1,"兆":1,"先":1,"全部":1,"八":1,"六":1,"内":1,"円":1,"冬":1,"分":1,"列":1,"別":1,"前":1,"前回":1,"力":1,"化":1,"匹":1,"区":1,"十":1,"千":1,"半ば":1,"口":1,"台":1,"右":1,"各":1,"同じ":1,"名":1,"名前":1,"向こう":1,"哀":1,"品":1,"員":1,"喜":1,"器":1,"四":1,"回":1,"国":1,"土":1,"地":1,"場":1,"場合":1,"境":1,"士":1,"夏":1,"外":1,"多く":1,"女":1,"奴":1,"婦":1,"子":1,"字":1,"室":1,"家":1,"屋":1,"左":1,"市":1,"席":1,"年":1,"年生":1,"幾つ":1,"店":1,"府":1,"度":1,"式":1,"形":1,"彼":1,"彼女":1,"後":1,"怒":1,"性":1,"情":1,"感":1,"感じ":1,"我々":1,"所":1,"手":1,"手段":1,"扱い":1,"数":1,"文":1,"新た":1,"方":1,"方法":1,"日":1,"春":1,"時":1,"時点":1,"時間":1,"書":1,"月":1,"木":1,"未満":1,"本当":1,"村":1,"束":1,"枚":1,"校":1,"楽":1,"様":1,"様々":1,"次":1,"歳":1,"歴":1,"段":1,"毎":1,"毎日":1,"気":1,"水":1,"法":1,"火":1,"点":1,"玉":1,"用":1,"男":1,"町":1,"界":1,"略":1,"百":1,"的":1,"目":1,"県":1,"確か":1,"私":1,"秋":1,"秒":1,"第":1,"等":1,"箇所":1,"箇月":1,"簿":1,"系":1,"紀":1,"結局":1,"線":1,"者":1,"自体":1,"自分":1,"行":1,"見":1,"観":1,"話":1,"誌":1,"誰":1,"課":1,"論":1,"輪":1,"近く":1,"通":1,"連":1,"週":1,"道":1,"達":1,"違い":1,"部":1,"都":1,"金":1,"間":1,"関係":1,"際":1,"集":1,"面":1,"頃":1,"類":1,"首":1,"高":1,"！":1,"＃":1,"＄":1,"％":1,"＆":1,"（":1,"）":1,"＊":1,"＋":1,"０":1,"１":1,"２":1,"３":1,"４":1,"５":1,"６":1,"７":1,"８":1,"９":1,"：":1,"；":1,"＜":1,"＝":1,"＞":1,"？":1,"＠":1,"＾":1,"＿":1,"｛":1,"｜":1,"｝":1,"￥":1,}
//paramsからurlを作る
var encodeUrl = function(params){
    url = "?";
    for(key in params){
        url += key + "=" + encodeURI(params[key]) + "&";
    }
    return url;
}
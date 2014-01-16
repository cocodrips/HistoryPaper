sortedWordListByTimes = function(titles){
    return titles.sort(
        function(a, b){
            return ( a.times < b.times ? 1 : -1)
        }
    );
}
// Generated by CoffeeScript 1.6.3
(function() {
  this.HistoryController = (function() {
    function HistoryController() {
      this.history = new History();
    }

    HistoryController.prototype.firstDate = function() {
      var now;
      now = new Date();
      return this.changeDate(now);
    };

    HistoryController.prototype.changeDate = function(date) {
      this.clearView();
      return this.history.changeDate(date);
    };

    HistoryController.prototype.clearView = function() {
      console.log("clear");
      return $("#main-container").innerHTML = '';
    };

    return HistoryController;

  })();

}).call(this);

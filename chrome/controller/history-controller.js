// Generated by CoffeeScript 1.6.3
(function() {
  console.log("dev version");

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
      return this.history.changeDate(date);
    };

    return HistoryController;

  })();

}).call(this);
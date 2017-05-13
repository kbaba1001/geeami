var printWorksMessage = function printWorksMessage () {
  console.log("It works!");
};

var print = function print () {
  printWorksMessage();
};

module.exports = {
  print: print
};

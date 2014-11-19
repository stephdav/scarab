
// use scarab
db = db.getSiblingDB("scarab");

print("=== show collections ===");
db.getCollectionNames().forEach(function(collection) {
  print(" > " + collection);
});

print("=== userStory ===");
var myCursor = db.userStory.find();
myCursor.forEach(printjson);

// === End of File ===

// use scarab
db = db.getSiblingDB("scarab");

db.userStory.drop();

db.userStory.insert ([
{
	"_id" : "b30405f0-1f01-4bd3-8470-836804cc2faa",
	"_class" : "org.kik.scarab.model.UserStory",
	"code" : "US-1",
	"title" : "US creation",
	"description" : "Patrick wants to create new user stories, so that he can initialize the product backlog.",
	"accCrit" : "A US is specified by a mandatory title and an optional description.",
	"accTest" : "N.A.",
	"creationDate" : ISODate("2014-11-07T11:00:00.000Z"),
	"modificationDate" : ISODate("2014-11-09T11:00:00.000Z")
},
{
	"_id" : "5c4cc63a-2a02-4e0f-9ba2-1da790dc630a",
	"_class" : "org.kik.scarab.model.UserStory",
	"code" : "US-2",
	"title" : "US list",
	"description" : "Patrick wants to view all existing US, so that he knows what US are not yet created.",
	"accCrit" : "US are shown in a simple list.",
	"accTest" : "N.A.",
	"creationDate" : ISODate("2014-11-07T11:00:00.000Z"),
	"modificationDate" : ISODate("2014-11-09T11:00:00.000Z")
},
{
	"_id" : "d17c81ea-0345-4fa2-b44d-95ca4ab784d2",
	"_class" : "org.kik.scarab.model.UserStory",
	"code" : "US-3",
	"title" : "US update & delete",
	"description" : "Patrick wants to edit or delete existing US in order to adjust backlog content.",
	"accCrit" : " - US will be editable in a popin.<br> - Action will be triggered by icons in the US list.<br> - A confirmation popin will avoid mistakes on deletion.",
	"accTest" : "N.A.",
	"creationDate" : ISODate("2014-11-10T11:00:00.000Z"),
	"modificationDate" : ISODate("2014-11-11T11:00:00.000Z")
},
{
	"_id" : "8b9a56ee-9b51-406a-8414-2c6b2853ea7e",
	"_class" : "org.kik.scarab.model.UserStory",
	"code" : "US-4",
	"title" : "New fields for US",
	"description" : "Sarah wants Patrick to specify acceptance criteria & test in the User Stories to help the team understanding the story purpose.",
	"accCrit" : " - These criteria are shown by default in the US list.<br> - An identifier can be specified with the US title.",
	"accTest" : "N.A.",
	"creationDate" : ISODate("2014-11-10T11:00:00.000Z"),
	"modificationDate" : ISODate("2014-11-10T11:00:00.000Z")
},
{
	"_id" : "fb22b365-d695-4633-b396-cb8408fce17e",
	"_class" : "org.kik.scarab.model.UserStory",
	"code" : "US-5",
	"title" : "Filter US",
	"description" : "Florence wants to find quickly a story, based on its code.",
	"accCrit" : "A search input enables to filter displayed user stories.",
	"accTest" : "N.A.",
	"creationDate" : ISODate("2014-11-11T11:00:00.000Z"),
	"modificationDate" : ISODate("2014-11-11T11:00:00.000Z")
},
{
	"_id" : "efe675f8-7c99-4578-9321-85fbc5f6f116",
	"_class" : "org.kik.scarab.model.UserStory",
	"code" : "US-6",
	"title" : "Sort US by date or code",
	"description" : "Sarah wants to know the last user stories that were updated, so that she knows what Patrick has changed.",
	"accCrit" : "The product backlog is sortable :<br>- by date<br>- by code",
	"accTest" : "N.A.",
	"creationDate" : ISODate("2014-11-23T11:00:00.000Z"),
	"modificationDate" : ISODate("2014-11-24T11:00:00.000Z")
}
]);

// === End of File ===
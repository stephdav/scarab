
// use scarab
db = db.getSiblingDB("scarab");

db.userStory.drop();

db.userStory.insert ([
{
	"_id" : "b30405f0-1f01-4bd3-8470-836804cc2faa",
	"_class" : "org.kik.scarab.model.UserStory",
	"code" : "US-001",
	"title" : "US creation",
	"description" : "Patrick wants to create new user stories, so that he can initialize the product backlog.",
	"accCrit" : "A US is specified by a mandatory title and an optional description.",
	"accTest" : "N.A.",
	"creationDate" : ISODate("2014-11-07T11:00:00.000Z"),
	"modificationDate" : ISODate("2014-11-09T11:00:00.000Z"),
    "value" : 5,
    "estimate" : 2,
    "status" : "completed"
},
{
	"_id" : "5c4cc63a-2a02-4e0f-9ba2-1da790dc630a",
	"_class" : "org.kik.scarab.model.UserStory",
	"code" : "US-002",
	"title" : "US list",
	"description" : "Patrick wants to view all existing US, so that he knows what US are not yet created.",
	"accCrit" : "US are shown in a simple list.",
	"accTest" : "N.A.",
	"creationDate" : ISODate("2014-11-07T11:00:00.000Z"),
	"modificationDate" : ISODate("2014-11-09T11:00:00.000Z"),
    "value" : 10,
    "estimate" : 1,
    "status" : "completed"
},
{
	"_id" : "d17c81ea-0345-4fa2-b44d-95ca4ab784d2",
	"_class" : "org.kik.scarab.model.UserStory",
	"code" : "US-003",
	"title" : "US update & delete",
	"description" : "Patrick wants to edit or delete existing US in order to adjust backlog content.",
	"accCrit" : " - US will be editable in a popin.<br> - Action will be triggered by icons in the US list.<br> - A confirmation popin will avoid mistakes on deletion.",
	"accTest" : "N.A.",
	"creationDate" : ISODate("2014-11-10T11:00:00.000Z"),
	"modificationDate" : ISODate("2014-11-11T11:00:00.000Z"),
    "value" : 5,
    "estimate" : 2,
    "status" : "completed"
},
{
	"_id" : "8b9a56ee-9b51-406a-8414-2c6b2853ea7e",
	"_class" : "org.kik.scarab.model.UserStory",
	"code" : "US-004",
	"title" : "New fields for US",
	"description" : "Sarah wants Patrick to specify acceptance criteria & test in the User Stories to help the team understanding the story purpose.",
	"accCrit" : " - These criteria are shown by default in the US list.<br> - An identifier can be specified with the US title.",
	"accTest" : "N.A.",
	"creationDate" : ISODate("2014-11-10T11:00:00.000Z"),
	"modificationDate" : ISODate("2014-11-10T11:00:00.000Z"),
    "value" : 15,
    "estimate" : 2,
    "status" : "completed"
},
{
	"_id" : "fb22b365-d695-4633-b396-cb8408fce17e",
	"_class" : "org.kik.scarab.model.UserStory",
	"code" : "US-005",
	"title" : "Filter US",
	"description" : "Florence wants to find quickly a story, based on its code.",
	"accCrit" : "A search input enables to filter displayed user stories.",
	"accTest" : "N.A.",
	"creationDate" : ISODate("2014-11-11T11:00:00.000Z"),
	"modificationDate" : ISODate("2014-11-11T11:00:00.000Z"),
    "value" : 5,
    "estimate" : 1,
    "status" : "completed"
},
{
	"_id" : "efe675f8-7c99-4578-9321-85fbc5f6f116",
	"_class" : "org.kik.scarab.model.UserStory",
	"code" : "US-006",
	"title" : "Sort US by date or code",
	"description" : "Sarah wants to know the last user stories that were updated, so that she knows what Patrick has changed.",
	"accCrit" : "The product backlog is sortable :<br>- by date<br>- by code",
	"accTest" : "N.A.",
	"creationDate" : ISODate("2014-11-23T11:00:00.000Z"),
	"modificationDate" : ISODate("2014-11-24T11:00:00.000Z"),
    "value" : 5,
    "estimate" : 1,
    "status" : "completed"
},
{
	"_id" : "19639ee0-d6a9-4656-b532-e0d8d1362b8f",
	"_class" : "org.kik.scarab.model.UserStory",
	"code" : "US-007",
	"title" : "Backlog refinement view",
	"description" : "Sarah wants a Backlog refinement view, so that she has support for discussions with Patrick and the team.",
	"accCrit" : "- Possibility to switch standard/refinement view <br>- US in a simple list (code/title) on the left side<br>- A click to edit US details on the right part<br>- New user stories are not created in a popin",
	"accTest" : "N.A.",
	"creationDate" : ISODate("2014-12-12T17:11:04.135Z"),
	"modificationDate" : ISODate("2014-12-12T17:11:04.135Z"),
    "value" : 10,
    "estimate" : 8,
    "status" : "completed"
},
{
    "_id" : "9c53a61a-5dc3-4ab5-8c3d-2b88efa9e9b5",
    "_class" : "org.kik.scarab.model.UserStory",
    "code" : "US-008",
    "title" : "US estimate & value",
    "description" : "Sarah wants the US to have an estimate and a value indicator, so that these values helps to sort the user stories",
    "accCrit" : "- Estimate are based on adjusted fibonacci values (0, 1, 2, 3, 5, 8, 13, 21, 50, 100)<br>- A numeric value can be set to represent functional benefit<br>",
    "accTest" : "N.A.",
    "creationDate" : ISODate("2014-12-19T17:22:25.604Z"),
    "modificationDate" : ISODate("2014-12-19T17:22:25.604Z"),
    "value" : 10,
    "estimate" : 2,
    "status" : "completed"
},
{
    "_id" : "c99ee31e-e6f5-4ab0-bcac-a475d97c9f1e",
    "_class" : "org.kik.scarab.model.UserStory",
    "code" : "US-009",
    "title" : "Estimate tool",
    "description" : "Sarah needs a tool during the backlog refinement, so that she can easily determine the team's estimate and compare the user story with other one that have same estimate.",
    "accCrit" : "- a table allows to record voting with single click<br>- the 3 most recent stories with same voting are displayed automatically in a list",
    "accTest" : "N.A.",
    "creationDate" : ISODate("2014-12-19T17:26:25.761Z"),
    "modificationDate" : ISODate("2014-12-19T17:26:25.761Z"),
    "value" : 10,
    "estimate" : 5,
    "status" : "implementing"
},
{
    "_id" : "c4309a54-2780-4bfb-b7ff-f72c588d6695",
    "_class" : "org.kik.scarab.model.UserStory",
    "code" : "US-010",
    "title" : "User stories status",
    "description" : "Before starting the new sprint, the team wants to know which stories are ready.",
    "accCrit" : "- possible status are : none, ready, implementing and complete<br>- status is displayed in backlog views where the column is displayed by default, is sortable and can be hidden",
    "accTest" : "N.A.",
    "creationDate" : ISODate("2015-03-23T20:31:02.642Z"),
    "modificationDate" : ISODate("2015-03-23T20:31:02.642Z"),
    "value" : 15,
    "estimate" : 5,
    "status" : "ready"
}
]);

// === End of File ===
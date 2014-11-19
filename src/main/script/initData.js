
// use scarab
db = db.getSiblingDB("scarab");

db.userStory.drop();

db.userStory.insert ([
	{
		"code" : "US-1",
		"title" : "title1",
		"description" : "Patrick wants to create new user stories, so that he can initialize the product backlog.",
		"accCrit" : "A US is specified by a mandatory title and an optional description.",
		"accTest" : "N.A."
	},
	{
		"code" : "US-2",
		"title" : "title2",
		"description" : "Patrick wants to view all existing US, so that he knows what US are not yet created.",
		"accCrit" : "US are shown in a simple list.",
		"accTest" : "N.A."
	},
	{
		"code" : "US-3",
		"title" : "title3",
		"description" : "Patrick wants to edit or delete existing US in order to adjust backlog content.",
		"accCrit" : "- US will be editable in a popin.<br>- Action will be triggered by icons in the US list.<br>- A confirmation popin will avoid mistakes on deletion.",
		"accTest" : "N.A."
	},
	{
		"code" : "US-4",
		"title" : "title4",
		"description" : "Sarah wants Patrick to specify acceptance criteria & test in the User Stories to help the team understanding the story purpose.",
		"accCrit" : "- These criteria are shown by default in the US list.<br>- An identifier can be specified with the US title.",
		"accTest" : "N.A."
	},
	{
		"code" : "US-5",
		"title" : "title5",
		"description" : "Florence wants to find quickly a story, based on its code.",
		"accCrit" : "A search input enables to filter displayed user stories.",
		"accTest" : "N.A."
	},
]);

// === End of File ===
// Using an object literal for a jQuery feature
var dndFeature = {
	init : function(settings) {
		dndFeature.config = {
			attributeSelector : 'id',
			dndContainer : '.board',
			dragSelector : '.task',
			dropSelector : '.column',
			draggingClass : 'dragPending',
			onStart : function(obj, event) {},
			onEnter : function(obj, event) {},
			onDrop : function(obj, event) {},
			onLeave : function(obj, event) {}
		};

		// Allow overriding the default config
		$.extend(dndFeature.config, settings);

		dndFeature.setup();
	},

	setup : function() {
		// ajoute la propriété pour le drop et le transfert de données
		$.event.props.push('dataTransfer');

		$(dndFeature.config.dndContainer).on({
			dragstart : function(event) { dndFeature.dragZoneStart(this, event); },
			dragend : function(event) { dndFeature.dragZoneEnd(this, event); }
		}, dndFeature.config.dragSelector);
		
		$(dndFeature.config.dndContainer).on({
			dragenter : function(event) { event.preventDefault(); dndFeature.dropZoneEnter(this, event); },
			dragleave : function(event) { event.preventDefault(); dndFeature.dropZoneLeave(this, event); },
			dragover : function(event) { event.preventDefault(); return false; },
			dragend : function(event) { event.preventDefault(); dndFeature.dropZoneEnd(this, event); },
			drop : function(event) { event.preventDefault(); dndFeature.dropZoneDrop(this, event); },
		}, dndFeature.config.dropSelector);
	},
	
	dragZoneStart : function(obj, event) {
		var data = $(obj).attr(dndFeature.config.attributeSelector);
		event.dataTransfer.setData("text", data);
		event.dataTransfer.effectAllowed = "move";
		$(obj).addClass(dndFeature.config.draggingClass);
		dndFeature.config.onStart(obj, event);
	},

	dragZoneEnd : function(obj, event) {
		$(obj).removeClass(dndFeature.config.draggingClass);
	},

	dropZoneDrop : function(obj, event) {
		var id = event.dataTransfer.getData("text");
		dndFeature.config.onDrop(obj, event, id);
		dndFeature.dropZoneLeave(obj);
	},

	dropZoneEnter : function(obj, event) {
		dndFeature.config.onEnter(obj, event);
	},

	dropZoneEnd : function(obj, event) {
		dndFeature.dropZoneLeave(obj, event);
	},

	dropZoneLeave : function(obj, event) {
		dndFeature.config.onLeave(obj, event);
	}
};
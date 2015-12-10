// Drag & Drop jQuery Plugin
// version 1.0, December 10th, 2015
// by stephane.david@soprasteria.com

// Based on jQuery Plugin Boilerplate

(function($) {

	$.dnd = function(element, options) {

		// plugin's default options
		// this is private property and is accessible only from inside the plugin
		var defaults = {
			attributeSelector : 'id',
			dragSelector : '.task',
			dropSelector : '.column',
			draggingClass : 'dragPending',
            onStart : function(obj, event) {},
            onEnter : function(obj, event) {},
            onDrop : function(obj, event) {},
            onLeave : function(obj, event) {}
        };

		// to avoid confusions, use "plugin" to reference the
		// current instance of the object
		var plugin = this;

		// this will hold the merged default, and user-provided options
		// plugin's properties will be available through this object like:
		// plugin.settings.propertyName from inside the plugin or
		// element.data('dnd').settings.propertyName from outside the plugin,
		// where "element" is the element the plugin is attached to;
		plugin.settings = {};

		var $element = $(element); // reference to the jQuery version of DOM element
		var element = element;    // reference to the actual DOM element

		// the "constructor" method that gets called when the object is created
		plugin.init = function() {
			// the plugin's final properties are the merged default and
			// user-provided options (if any)
			plugin.settings = $.extend({}, defaults, options);

            // code goes here
			// ajoute la propriété pour le drop et le transfert de données
			$.event.props.push('dataTransfer');

			$element.on({
				dragstart : function(event) { dragZoneStart(this, event); },
				dragend : function(event) { dragZoneEnd(this, event); }
			}, plugin.settings.dragSelector);
			
			$element.on({
				dragenter : function(event) { event.preventDefault(); dropZoneEnter(this, event); },
				dragleave : function(event) { event.preventDefault(); dropZoneLeave(this, event); },
				dragover : function(event) { event.preventDefault(); return false; },
				dragend : function(event) { event.preventDefault(); dropZoneEnd(this, event); },
				drop : function(event) { event.preventDefault(); dropZoneDrop(this, event); },
			}, plugin.settings.dropSelector);

		};

		// === public methods ===

		// these methods can be called like:
		// plugin.methodName(arg1, arg2, ... argn) from inside the plugin or
		// element.data('dnd').publicMethod(arg1, arg2, ... argn) from outside 
		// the plugin, where "element" is the element the plugin is attached to;

		// a public method. for demonstration purposes only - remove it!
		//plugin.foo_public_method = function() {
		//	// code goes here
		//};

		// === private methods ===

		// these methods can be called only from inside the plugin like:
		// methodName(arg1, arg2, ... argn)

		var dragZoneStart = function(obj, event) {
			var data = $(obj).attr(plugin.settings.attributeSelector);
			event.dataTransfer.setData("text", data);
			event.dataTransfer.effectAllowed = "move";
			$(obj).addClass(plugin.settings.draggingClass);
			plugin.settings.onStart(obj, event);
		};

		var dragZoneEnd = function(obj, event) {
			$(obj).removeClass(plugin.settings.draggingClass);
		};

		var dropZoneDrop = function(obj, event) {
			var id = event.dataTransfer.getData("text");
			plugin.settings.onDrop(obj, event, id);
			dropZoneLeave(obj);
		};

		var dropZoneEnter = function(obj, event) {
			plugin.settings.onEnter(obj, event);
		};

		var dropZoneEnd = function(obj, event) {
			dropZoneLeave(obj, event);
		};

		var dropZoneLeave = function(obj, event) {
			plugin.settings.onLeave(obj, event);
		};

		// fire up the plugin!
		// call the "constructor" method
		plugin.init();
    };

	// add the plugin to the jQuery.fn object
	$.fn.dnd = function(options) {
		// iterate through the DOM elements we are attaching the plugin to
		return this.each(function() {
			// if plugin has not already been attached to the element
			if (undefined == $(this).data('dnd')) {
				// create a new instance of the plugin
				// pass the DOM element and the user-provided options as arguments
				var plugin = new $.dnd(this, options);
				// in the jQuery version of the element
				// store a reference to the plugin object
				// you can later access the plugin and its methods and properties like
				// element.data('dnd').publicMethod(arg1, arg2, ... argn) or
				// element.data('dnd').settings.propertyName
				$(this).data('dnd', plugin);
            }
        });
    };
})(jQuery);
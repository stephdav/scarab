Product = Backbone.Model.extend({

	urlRoot: 'rest/product',
	
	defaults: {
		name: ''
	},

	initialize: function(){
    },

});

ProductView = Backbone.View.extend({
    tagName: 'li',
    className: 'list-group-item',
    initialize: function(){
        this.render();
    },
    template: _.template("<span><%= name %></span><button type='button' class='btn btn-danger btn-xs pull-right'><span class='glyphicon glyphicon-remove'></span></button>"),
    render: function(){
        this.$el.html(this.template(this.model.attributes));
        return this;
    },
    events: {
        "click .btn"	: "deleteProduct",
    },
    deleteProduct: function() {
    	this.model.destroy({
    		success: function(product, response) {
    	        alert("deleted");
    		}
    	});
    },
});

ProductsCollection = Backbone.Collection.extend({
    model: Product,
    url: 'rest/products',
});

ProductsCollectionView = Backbone.View.extend({

	tagName:'ul',
    className: 'list-group',
	initialize:function () {
		// console.log('ProductsCollectionView.initialize()')
		// this.collection.bind("reset", this.render, this);
		// this.collection.fetch();
		// console.log(' - collection.size() : ' + this.collection.size())
	},

	render:function (eventName) {
		console.log('ProductsCollectionView.render()')
		console.log(' - collection.size() : ' + this.collection.size())
		_.each(this.collection.models, function (item) {
			var itemView = new ProductView({model:item});
			$(this.el).append(itemView.el);
		}, this);
	    return this;
	}
});
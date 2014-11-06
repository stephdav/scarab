<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="Sopra Group">
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
	
	<title>scarab</title>
	
	<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/scarab.css" rel="stylesheet">
</head>

<body>

	<div class="navbar navbar-default navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="${pageContext.request.contextPath}/">scarab</a>
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4">
				<h3>all products <button type="button" class="btn btn-info btn-xs pull-right" data-toggle="modal" data-target="#createProductModal"><span class="glyphicon glyphicon-plus"></span></button></h3>
 				<div id="products" ></div>
 			</div>
			<div class="col-md-8">
				<h3>all cards <button type="button" class="btn btn-info btn-xs pull-right" data-toggle="modal" data-target="#createCardModal"><span class="glyphicon glyphicon-plus"></span></button></h3>
				<ul id="cards" class="list-group"></ul>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<form class="modal fade" id="createProductModal" tabindex="-1" role="dialog" aria-labelledby="createProductModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 id="createProductModalLabel" class="modal-title">create a new product</h4>
				</div>
				<div class="modal-body">
					<div class="form-horizontal">
						<div class="form-group">
							<label for="productNameId" class="col-sm-3 control-label">name</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="productNameId" placeholder="Enter product name" required>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" id="productForm" class="btn btn-info">create</button>
				</div>
			</div>
		</div>
	</form>
	
	<form class="modal fade" id="createCardModal" tabindex="-1" role="dialog" aria-labelledby="createCardModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 id="createCardModalLabel" class="modal-title">create a new card</h4>
				</div>
				<div class="modal-body">
					<div class="form-horizontal">
						<div class="form-group">
							<label for="cardTitleId" class="col-sm-3 control-label">title</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="cardTitleId" placeholder="Enter card title" required>
							</div>
						</div>
						<div class="form-group">
							<label for="cardDescId" class="col-sm-3 control-label">description</label>
							<div class="col-sm-9">
								<textarea class="form-control" id="cardDescId" name="description" rows="3"></textarea>
							</div>
						</div>
						<div class="form-group">
							<label for="productName" class="col-sm-3 control-label">product</label>
							<div class="col-sm-9">
								<select class="form-control" id="productName"></select>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" id="cardForm" class="btn btn-info">create</button>
				</div>
			</div>
		</div>
	</form>

	<!-- Placed at the end of the document so the pages load faster -->
	<script src="${pageContext.request.contextPath}/resources/js/libs/jquery-1.11.0.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/libs/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/libs/jquery.validate.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/libs/underscore-min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/libs/backbone.js"></script>

	<script src="${pageContext.request.contextPath}/resources/js/models/product.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {

			$.validator.setDefaults({
			    highlight: function(element) {
			        $(element).closest('.form-group').addClass('has-error');
			    },
			    unhighlight: function(element) {
			        $(element).closest('.form-group').removeClass('has-error');
			    },
			    errorElement: 'span',
			    errorClass: 'help-block',
			    errorPlacement: function(error, element) {
			        if(element.parent('.input-group').length) {
			            error.insertAfter(element.parent());
			        } else {
			            error.insertAfter(element);
			        }
			    }
			});
			
			refresh();
	
			$("#productForm").click(function() {
				var form = $( "#createProductModal" );
				form.validate();
				if (form.valid()){
					var prd = new Product();
					prd.save( { name: $('#productNameId').val() }, {
						success: function (p) {
								$('#productNameId').val("");
								refreshProducts();
				        	}
					});
					$('#createProductModal').modal('hide');
				}
			});
	
			$('#cardForm').click(function() {
				var form = $( "#createCardModal" );
				form.validate();
				if (form.valid()){
					var p = '';
					if ($('#productName').val() != "noid") {
						p = ', "product":{"id":"' + $('#productName').val() + '"}';
					}
					$.ajax({
						url : '${pageContext.request.contextPath}/rest/card/save',
						type : 'POST',
						data : '{"title": "' + $('#cardTitleId').val() + '", "description": "' + $('#cardDescId').val() + '"' + p + '}',
						dataType : 'json',
						contentType : "application/json; charset=utf-8",
						success : function(data, textStatus, jqXHR){
							$('#cardTitleId').val("");
							$('#cardDescId').val("");
							refreshCards();
						}
					});
					$('#createCardModal').modal('hide');
				}
			});

			function refresh() {
				refreshProducts();
				refreshCards();
			}
			
			function refreshProducts() {
				
				var products = new ProductsCollection();
				products.fetch();
				console.log('index.jsp - collection.size() : ' + products.models.length);
/**
				products.fetch({
				    success: function(collection, response, options) {
						var $model = $('select#productName');
						$model.empty();
						$model.append(function() {
				            var output = '';
			                output += '<option value="noid">-- select a product --</option>';
			                collection.each(function(item) {
				                output += '<option value="' + item.get("id") +'">' + item.get("name") + '</option>';
			                });
				            return output;
				        });
				    }
				});
				// ProductsCollectionView
				var pcollectionview = new ProductsCollectionView({collection: products.fetch()});
                pcollectionview.render();
                $('#products').append(pcollectionview.el);
				*/


			}

			function refreshCards() {
				$.getJSON('${pageContext.request.contextPath}/rest/cards',
					function(response) {
						var c = [];
						$.each(response.cards, function(i, item) {
							c.push("<tr>");
							c.push("<td>" + item.title + "</td>");
							c.push("<td>" + item.description + "</td>");
							if (item.product == null){
								c.push("<td></td>");
							}else{
								c.push("<td>" + item.product.name + "</td>");
							}
							c.push("<tr>");
						});
						$.each(response.cards, function(i, item) {
							if (item.product == null){
								$('#cards').append('<li class="list-group-item">'+item.title+' / '+item.description+'</li>');
							}else{
								$('#cards').append('<li class="list-group-item">'+item.title+' / '+item.description+' / '+item.product.name+'</li>');
							}
						});
						$('#cardsTable').html(c.join(""));
					}
				);
			}
		});
	</script>
</body>
</html>
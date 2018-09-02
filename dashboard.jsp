<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="pt-br">
    <head>
	    <jsp:include page="../headAdmin.jsp" />
	    <script>
		    $(window).keydown(function(e) {
	  			switch (e.keyCode) {
	  				case 27:
	  					$("#modal-cadastroincidente").modal("hide");
	  					e.preventDefault(); 
	  					break;
	  			}
  			});
	    </script>
	</head>
	<body>
	    <main>
	        <jsp:include page="../menuAdmin.jsp" />
	        <div class="wrap-sa wrap-sa--dashboard">
	            <div class="bgcolor-branco">
	                <nav class="container container-sa container-tabscenter">
	                    <ul class="nav nav-tabs nav-tabssa" role="tablist">
                       		<li role="presentation" class="active">
	                            <a href="#" class="tabs" data-value="SOLICITACOES">KIT CORRETOR&nbsp;
	                            	<span class="badge navtabsa-badge">${usuarioSessao.incidenteSessao.totalKitCorretor}</span>
	                            </a>
                       		</li>
	                    </ul>
	                </nav>
	            </div>
	            <div class="container container-sa">
	                <section class="dashboard">
	                    <div id="tab" class="tab-content tab-contentsa">
							<form id="filtros-formularios" method="post" onsubmit="return false;">
								<input id="inputFiltroFormularioTabs" type="hidden" name="tabs" value="SOLICITACOES" readonly="readonly" />
						        <fieldset class="tab-contentsa-filtro">
						            <div class="row">
						                <div class="col-md-8">
						                    <div class="form-group">
						                    	<label for="tabFltStatus" class="control-label">&nbsp;</label>
						                        <div class="input-group input-group-lg input-group-sa--trsnp">
						                            <input id="buscarIncidente" type="text" name="dto.buscar" class="form-control filtro" placeholder="Buscar por nome do corretor ou código bp e outra coisa" aria-describedby="basic-addon1">
						                            <span class="input-group-addon buscarIncidente" style="cursor:pointer"><i class="fa fa-search"></i></span>
						                        </div>
						                    </div>
						                </div>
						                <div class="col-md-4">
						                    <div class="form-group form-group-lg">
						                        <label for="tabFltStatus" class="control-label">Status:</label>
						                        <select id="tabFltStatus" name="dto.statusKitCorretor" class="form-control filtro">
						                            <option value="" selected="selected">Selecione</option>
						                            <c:forEach var="statusKitCorretor" items="${statusKitCorretor}">
						                            	<option value="${statusKitCorretor}">${statusKitCorretor.descricao}</option>
						                            </c:forEach>
						                        </select>
						                    </div>
						                </div>
						                
						            </div>
						        </fieldset>
						    </form>
						    <div id="tabela-incidentes">
						    	<jsp:include page="tabelaIncidente.jsp" />
						    </div>
	                    </div>
	                </section>
	            </div>
	        </div>
	    </main>
		<jsp:include page="../footAdmin.jsp" />
		<script type="text/javascript" src="<c:url value="/vendors/js/velocity.min.js" />"></script>
		<script type="text/javascript">			
		$(document).ready(function() {
			$(".tabs").on("click", function(event) {
				event.preventDefault();
				$(".tabs").parent("li").removeClass('active');
				$(this).parent("li").addClass('active');
				resetarCamposFiltro();
				
				var tipo = $(this).attr("data-value");
				$("input[name='tabs']").val(tipo);
				setTabelaKits({"tabs": tipo});
				
			});
			
			$(".sa-tooltip").tooltip({
				placement:'bottom'
			});
			
			$(".filtro").on("change", function(event) {
				event.preventDefault();
				var dadosSerializados = $("#filtros-formularios").serialize();
				setTabelaKits(dadosSerializados);
			});
			
			$(".buscarIncidente").click(function(){
				$("#buscarIncidente").keyup();
			})
			
			$("#buscarIncidente").on("keyup", function(event) {
				event.preventDefault();
				if(event.which == 13) {
					var dadosSerializados = $("#filtros-formularios").serialize();
					setTabelaKits(dadosSerializados);
				}
			});
		});
		
		function setTabelaKits(data) {
			$.get("${linkTo[KitCorretorAdminController].tabelaIncidente}", data, function(response) {
				$("#tabela-incidentes").html(response);
			});
		}
		
		function resetarCamposFiltro() {
			document.getElementById('filtros-formularios').reset();
		}
		</script>
	</body>
</html>
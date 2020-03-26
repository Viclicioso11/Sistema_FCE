<div class="card">
	<div class="card-body">
		<h3>Cierre de la Culminación de Estudio</h3>
		
		<p>
			En este espacio usted podrá subir su documento final
			de la culminación de estudio que realiza,
			<br>
			tenga en cuenta que una vez que el archivo se ha subido 
			usted no podrá modificar este espacio 
			<br>por lo tanto se le recomienda
			que suba la versión final de su documento.
		</p>
		
		<br><p>Archivos que soporta el sistema:</p><br>
		<ul class="b-list b-list_type_tree ">
		 <li class="b-list__item">
		   <label class="b-label">
		     <i class="far fa-file-archive" style="color: #fbff00"></i>
		     Zip
		   </label>
		 </li>
		 <li class="b-list__item">
		   <label class="b-label">
		     <i class="far fa-file-word" style="color: #339af0"></i>
		      Documentos word
		    </label>
		  </li>
		</ul>

		<form action="../../SL_cierre" id="form_cierre" style="width: 80%;margin: 20px 10%;" method="post" enctype="multipart/form-data">
			<div class="file-container" id="file-drop">
			  <input type="file" id="file-drop-input" name="docFinal"required>
			  <p>Arrastra tus archivos aqui o Click aqui para buscar</p>
			</div>
			
			<input type="hidden" name="idtema" id="idtema">
			<br>
			<button class="btn btn-info" type="submit">Enviar Archivo</button>
			<a href="#" class="btn btn-danger" id="reset" type="color: white">Eliminar Archivo</a>
		</form>
	</div>
</div>
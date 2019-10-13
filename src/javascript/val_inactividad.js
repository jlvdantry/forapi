                var numeroClicks = 0;
                var pasada = 0;
                window.inicia = function() {
                              var funcion = setTimeout('despliegaMensaje()',60*60*1000);
                }

                window.despliegaMensaje = function() {
	                	pasada++;
                        if (numeroClicks == 0) {
                                alert("Estimado Usuario:\n\nPor su seguridad y debido a que se ha excedido el periodo de inactividad permitido, el servicio del Sistema ha terminado su sesión, si desea continuar utilizándolo por favor ingrese nuevamente su Usuario y Password .");
								window.close();
                                parent.location.replace('index.php');
								
                        } else {
                                numeroClicks = 0;
                              	var funcion = setTimeout('despliegaMensaje()',60*60*1000);                                
                        }
                }
		window.sumaclicks = function() {
					numeroClicks++;
				}

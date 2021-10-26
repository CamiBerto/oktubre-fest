import Marcas.*
import Carpas.*

class Jarra{
	var property litro
	var property marca
	var property seSirvio
	var property precioVendido
	method contenidoAlcohol(){
		return litro * marca.graduacion() * 0.01
	}
	
}
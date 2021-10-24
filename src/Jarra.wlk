import Marcas.*
import Carpas.*

class Jarra{
	var property litro
	var property marca
	method contenidoAlcohol(){
		return self.litro() * self.marca().graduacion() * 0.01
	}
}
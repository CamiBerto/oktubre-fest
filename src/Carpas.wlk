import Marcas.*
import Jarra.*

class Carpa{
	var property limiteGente
	var property tieneMusica
	var property marca
	var property personasDentro = []
	var property recargoHabilitado
	method dejaIngresarA(unaPersona){
		return self.hayLugar() && not unaPersona.estaEbria()
	}
	method hayLugar(){
		return personasDentro.size() < limiteGente
	}
	method estaLaPersona(unaPersona){
		return personasDentro.contains(unaPersona)
	}
	method venderJarraDe_A_(litros, unaPersona){
		if (self.estaLaPersona(unaPersona)){
			unaPersona.comprarJarra(new Jarra(litro = litros, marca = self.marca(), seSirvio = self, precioVendido = self.precioDeVentaPara(litros)) )
		} else{
			self.error("la persona no esta dentro")
		}
	}
	method precioDeVentaPara(litros){
		return marca.precioXLitro() * litros * (1 + recargoHabilitado.recargo(personasDentro, limiteGente))
	}	
	method cantEbriosEmpedernidos(){
		return personasDentro.count({persona=> persona.sonTodasDeAlMenos(1) && persona.estaEbria()})
	}
	method esHomogenea() {
		return self.nacionalidadesDePersonasEnLaCarpa().size() == 1
	}
	method nacionalidadesDePersonasEnLaCarpa() {
		return personasDentro.map{ p => p.nacionalidad() }.asSet()
	}
	method personasSinCervezaDeAca() {
		return personasDentro.filter{ per => not per.carpasDondeCompro().contains(self)}
	}
	
}
object regargoFijo{
	method recargo(pers, lim){
		return 0.30
	}
}

object recargoXCantidad{
	method recargo(pers, lim){
		return if(pers.size() >= lim/2) {0.40}else {0.25}
	}
}

object recargoXEbriedad{
	method recargo(pers, lim){
		return if ((100 /pers.size()) * pers.count({c => c.estaEbria()}) >= 75) {0.50} else {0.20}
	}
}
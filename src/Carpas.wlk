import Marcas.*
import Jarra.*

class Carpa{
	var property limiteGente
	var property tieneMusica
	var property marca
	var property personasDentro = []
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
			unaPersona.comprarJarra(new Jarra(litro = litros, marca = self.marca(), seSirvio = self) )
		} else{
			self.error("la persona no esta dentro")
		}
	}
	method cantEbriosEmpedernidos(){
		return personasDentro.count({persona=> persona.sonTodasDeAlMenos(1)})
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
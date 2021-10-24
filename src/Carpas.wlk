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
		return self.personasDentro().size() < self.limiteGente()
	}
	method estaLaPersona(unaPersona){
		return self.personasDentro().contains(unaPersona)
	}
	method verderJarraDe_A_(litros, unaPersona){
		if (self.estaLaPersona(unaPersona)){
			unaPersona.comprarJarra(new Jarra(litro = litros, marca = self.marca()) )
		} else{
			self.error("la persona no esta dentro")
		}
	}
	method cantEbriosEmpedernidos(){
		return self.personasDentro().count({persona=> persona.sonTodasDeAlMenos(1)})
	}
}
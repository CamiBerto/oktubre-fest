import paises.*

class Persona{
	var property peso
	const property jarras = []
	var property leGustaMusicaTradicional
	var property nivelDeAguante
	method estaEbria(){
		return self.totalAlcoholIngerido() * self.peso() > self.nivelDeAguante()
	}
	method totalAlcoholIngerido(){
		return jarras.sum{jarra=>jarra.contenidoAlcohol()}
	}
	method leGusta(marca) = true
	method quiereEntrarA(unaCarpa){
		return self.leGusta(unaCarpa.marca()) && (unaCarpa.tieneMusica() == self.leGustaMusicaTradicional())
	}
	method puedeEntrar(unaCarpa){
		return self.quiereEntrarA(unaCarpa) && unaCarpa.dejaIngresarA(self)
	}
	method ingresarACarpa(unaCarpa){
		if (self.puedeEntrar(unaCarpa) && not unaCarpa.estaLaPersona(self)) {
			self.entrarA(unaCarpa)
		} else {
			self.error("no puede entrar")
		}
	}
	method entrarA(unaCarpa){
		unaCarpa.personasDentro().add(self)
	}
	method comprarJarra(unaJarra){
		jarras.add(unaJarra)
	}
	method sonTodasDeAlMenos(litro){
		return jarras.all{jarra => jarra.litro() >= litro}
	} 
	method esPatriota(){
		return jarras.all{jarra => jarra.marca().paisDeOrigen() == self.nacionalidad()}
	}
	method nacionalidad()
}

class PersonaBelga inherits Persona{
	override method nacionalidad() = belga
	override method leGusta(marca){
		return marca.lupulos() > 4
	}
}

class PersonaAleman inherits Persona{
	override method nacionalidad() = alemania
	override method quiereEntrarA(unaCarpa){
		return super(unaCarpa) && unaCarpa.personasDentro().size().even()
	}
}

class PersonaCheco inherits Persona{
	override method nacionalidad() = repCheca
	override method leGusta(marca){
		return marca.graduacion() > 8
	}
}
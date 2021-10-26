import paises.*

class Persona{
	var property peso
	const property jarras = []
	var property leGustaMusicaTradicional
	var property nivelDeAguante
	method estaEbria(){
		return self.totalAlcoholIngerido() * peso > nivelDeAguante
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
			unaCarpa.personasDentro().add(self)
		} else {
			self.error("no puede entrar")
		}
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
	method marcasCompradas(){
		return jarras.map({jarra => jarra.marca()}).asSet()
	}
	method comprasEnComunCon(unaPersona){
		return self.marcasCompradas().intersection(unaPersona.marcasCompradas())
	}
	method comprasDiferentesCon(unaPersona){
		return self.marcasCompradas().difference(unaPersona.marcasCompradas()) +
			   unaPersona.marcasCompradas().difference(self.marcasCompradas())
	}
	method carpasDondeCompro(){
		return jarras.map({jarra => jarra.seSirvio()}).asSet()
	}
	method esCompatibleCon(unaPersona) {
		return self.comprasEnComunCon(unaPersona).size() > self.comprasDiferentesCon(unaPersona).size()
	}
	method indiceDeJarras(){
		return (1..jarras.size()-1).asList()
	}
	method estaEntrandoEnVicio() {
		return self.indiceDeJarras().all{ i => jarras.get(i - 1).litro() <= jarras.get(i).litro() }
	}
	method gastoTotalEnCerveza(){
		return jarras.sum{jarra => jarra.precioVendido()}
	}
	method jarraMasCara(){
		return jarras.max{jarra => jarra.precioVendido()}
	} 
}

class PersonaBelga inherits Persona{
	override method nacionalidad() = belga
	override method leGusta(marca){
		return marca.lupulos() > 4
	}
}

class PersonaAlemana inherits Persona{
	override method nacionalidad() = alemania
	override method quiereEntrarA(unaCarpa){
		return super(unaCarpa) && unaCarpa.personasDentro().size().even()
	}
}

class PersonaCheca inherits Persona{
	override method nacionalidad() = repCheca
	override method leGusta(marca){
		return marca.graduacion() > 8
	}
}
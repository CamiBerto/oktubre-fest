class Marca{
	var property lupulos
	var property paisDeOrigen
	
	method graduacion ()
	
}
class CervezaRubia inherits Marca{
	var property graduacionRubia
	override method graduacion(){
		return graduacionRubia
	}
}

class CervezaNegra inherits Marca {
	override method graduacion(){
		return graduacionReglamentaria.graduacionReglamentaria().min(lupulos*2)
	}
}

class CervezaRoja inherits CervezaNegra{
	override method graduacion(){
		return super()*1.25
	}
}


object graduacionReglamentaria{
	var property graduacionReglamentaria
}
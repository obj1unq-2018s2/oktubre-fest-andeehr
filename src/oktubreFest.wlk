class Jarra {

	var property capacidad
	var property marcaCerveza

	method contenidoDeAlcohol() = marcaCerveza.alcoholPorLitro() * capacidad

}

class Carpa {

	var property limite
	var property tieneBandaMusicaTradicional
	var property jarraQueVenden
	const property publico = []

	method marcaQueVende() = jarraQueVenden.marcaCerveza()

	method ingresar(persona) {
		publico.add(persona)
	}

	method cantidadPublico() = publico.size()

	method dejaIngresar(persona) = !self.estaLlena() && !persona.estaEbria()

	method estaLlena() = self.cantidadPublico() == limite

	method cuantosEbriosEmpedernidosHay() = self.ebriosEmpedernidos().size()

	method ebriosEmpedernidos() = publico.filter{ persona => persona.esEbriaEmpedernida() }

}

class Persona {

	var property peso
	var property jarrasQueCompro
	var property escuchaMusicaTradicional
	var property aguante

	method estaEbria() = self.alcoholQueIngirio() * peso > aguante

	method alcoholQueIngirio() = jarrasQueCompro.sum{ jarra => jarra.contenidoDeAlcohol() }

	method leGusta(marca)

	method quiereEntrarA(carpa) = self.leGusta(carpa.marcaQueVende()) && self.cumplePreferenciaSobreMusica(carpa)

	method cumplePreferenciaSobreMusica(carpa) = (escuchaMusicaTradicional && carpa.tieneBandaMusicaTradicional()) or (!escuchaMusicaTradicional && !carpa.tieneBandaMusicaTradicional())

	method puedeEntrar(carpa) = self.quiereEntrarA(carpa) && carpa.dejaIngresar(self)

	method ingresarA(carpa) {
		if (self.puedeEntrar(carpa)) {
			carpa.ingresar(self)
		} else {
			self.error("No cumple requisitos para ingresar")
		}
	}

	method esEbriaEmpedernida() = jarrasQueCompro.all{ jarra => jarra.capacidad() > 1 }

	method esPatriota() = jarrasQueCompro.all{ jarra => jarra.marcaCerveza().paisDondeSeFabrica() == self.nacionalidad() }

	method nacionalidad()

}

class Belga inherits Persona {

	override method leGusta(cerveza) = cerveza.cantLupulo() > 4

	override method nacionalidad() = "Belgica"

}

class Checo inherits Persona {

	override method leGusta(cerveza) = cerveza.graduacionAlcoholica() > 8

	override method nacionalidad() = "Republica Checa"

}

class Aleman inherits Persona {

	override method leGusta(cerveza) = true

	override method quiereEntrarA(carpa) = super(carpa) && !carpa.cantidadPublico().odd()

	override method nacionalidad() = "Alemania"

}

class Cerveza {

	var property cantLupulo
	var property paisDondeSeFabrica

	method alcoholPorLitro() = self.graduacionAlcoholica() / 100

	method graduacionAlcoholica()

}

class CervezaRubia inherits Cerveza {

	var graduacionAlcoholica

	override method graduacionAlcoholica() = graduacionAlcoholica

	method graduacionAlcoholica(cuanto) {
		graduacionAlcoholica = cuanto
	}

}

class CervezaNegra inherits Cerveza {

	override method graduacionAlcoholica() = graduacionMundial.graduacionReglamentaria().min(cantLupulo * 2)

}

class CervezaRoja inherits CervezaNegra {

	override method graduacionAlcoholica() = super() * 1.25

}

object graduacionMundial {

	var property graduacionReglamentaria = 8

}


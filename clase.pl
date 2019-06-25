sucedio(paris, atentado(fecha(13, 11, 2015), victimas(137, 350))).
sucedio(paris, mundial(meses(6, 7), 2019, 24)).
sucedio(buenosAires, mundial(meses(6, 7), 1986, 32)).
sucedio(paris, revolucion(1789, 1799)).
sucedio(algunLado, revolucion(1777, 1777)).
sucedio(buenosAires, fraseEstupida(politico(cristina, fpv), 2019)).
sucedio(buenosAires, fraseEstupida(politico(macri, cambiemos), 2019)).
sucedio(paris, fraseEstupida(politico(macron, em), 2018)).
esOficialismo(cambiemos, 2019).
esOficialismo(em, 2019).

ciudadesConMundial(Ciudad) :-
    sucedio(Ciudad, mundial(_, _, _)).
ciudadesConMundialNumeroso(Ciudad, Equipos) :-
    sucedio(Ciudad, mundial(_, _, Equipos)),
    Equipos > 30.
ciudadesConAtentadosFatales(Ciudad, Muertos) :-
    sucedio(Ciudad, atentado(_, victimas(_, Muertos))).
equiposEnMundialesNumerosos(Equipos) :-
    sucedio(_, mundial(_, _, Equipos)),
    Equipos > 30.
revolucionesCortas(Ciudad) :-
    sucedio(Ciudad, revolucion(Anio, Anio)).


esTerrible(Donde, Suceso):-
    sucedio(Donde, Suceso),
    cumpleCondiciones(Suceso).

cumpleCondiciones(atentado(_, _)).
cumpleCondiciones(mundial(_, _, Equipos)) :-
    Equipos < 16. 
cumpleCondiciones(revolucion(AnioInicio, AnioInicio)).


puedeAparecer(atentado(_, _)).
puedeAparecer(mundial(_, 2019, Equipos)) :-
    Equipos > 8.
puedeAparecer(revolucion(AnioInicio, AnioFin)) :-
    AnioInicio < 1969,
    AnioFin > 2069.
puedeAparecer(revolucion(anioInicio, 2019)).
puedeAparecer(fraseEstupida(politico(_,Partido), Anio)) :-
    not(esOficialismo(Partido, Anio)).


coeficiente(Donde, Suceso, Coeficiente):-
    sucedio(Donde, Suceso),
    coeficienteDeAmarillismo(Suceso, Coeficiente).
duracion(Algo, OtraCosa, Duracion) :- 
	Duracion is OtraCosa - Algo.

coeficienteDeAmarillismo(atentado(_, victimas(Muertos, Heridos)), Coeficiente) :-
    Coeficiente is Muertos*10 + Heridos.
coeficienteDeAmarillismo(mundial(meses(MesInicio, MesFinal), 2019, _), Coeficiente) :-
    duracion(MesInicio, MesFinal, Coeficiente).
coeficienteDeAmarillismo(revolucion(AnioInicio, AnioFin), Coeficiente) :-
    duracion(AnioInicio, AnioFin, Coeficiente).
coeficienteDeAmarillismo(fraseEstupida(politico(_, Partido), Anio), 100):-
    esOficialismo(Partido, Anio).
coeficienteDeAmarillismo(fraseEstupida(politico(_, Partido), Anio), 50):-
    not(esOficialismo(Partido, Anio)).



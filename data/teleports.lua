return {
    insideCasino = {
        text = "[E] - Exit casino",
        location = vec4(1089.67, 206.30, -50.0, 4.42),
        range = 1.2,
        destination = "outsideCasino"
    },
    outsideCasino = {
        text = "[E] - Enter casino",
        location = vec4(935.80, 46.95, 80.09, 147.40),
        range = 1.2,
        destination = "insideCasino"
    },
    insideCarpark = {
        location = vec4(1340.614, 190.891, -48.596, 90.161),
        distance = 2.0,
        destination = vec4(974.39, 5.89, 80.39, 146.67),
        allowVehicle = true,
        hide = true,
        onEnter = true
    },
    outsideCarpark = {
        location = vec4(934.75, -1.07, 77.76, 150.41),
        distance = 2.5,
        destination = vec4(1340.096, 183.671, -48.581, 271.705),
        allowVehicle = true,
        hide = true,
        onEnter = true
    },
    outsideCarparkElevatorExit = {
        text = "[E] - Exit carpark",
        location = vec4(1380.06, 178.267, -49.994, 2.199),
        range = 1.2,
        destination = "insideCarparkElevatorEntrance"
    },
    insideCarparkElevatorEntrance = {
        text = "[E] - Enter carpark",
        location = vec4(974.913, 12.54, 80.04, 241.713),
        range = 1.2,
        destination = "outsideCarparkElevatorExit"
    },
    insideCarparkElevatorExit = {
        text = "[E] - Enter casino",
        location = vec4(1379.962, 259.689, -49.994, 182.342),
        range = 1.2,
        destination = "insideCasinoCarparkEntrace"
    },
    insideCasinoCarparkEntrace = {
        text = "[E] - Enter carpark",
        location = vec4(1085.502, 214.491, -50.201, 319.772),
        range = 1.2,
        destination = "insideCarparkElevatorExit"
    },
    insideCasinoBossRoom = {
        text = "[E] - Enter carpark",
        location = vec4(1107.409, 243.111, -46.841, 271.721),
        range = 1.2,
        destination = "insideCarparkElevatorExit"
    },
}

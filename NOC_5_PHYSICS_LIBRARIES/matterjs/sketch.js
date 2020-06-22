// module aliases
const Engine = Matter.Engine,
    // Render = Matter.Render,
    World = Matter.World,
    Bodies = Matter.Bodies

// create engine
let engine
let world
let box1

function setup() {
    // create canvas
    createCanvas(400,400)
    // create engine
    engine = Engine.create()
    // aliasing world
    world = engine.world
    // run engine
    Engine.run(engine)

    box1 = new Box(200,100,50,50)
}

function draw() {
    background(52)
    box1.show()
}
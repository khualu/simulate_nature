// module aliases
const Engine = Matter.Engine,
// Render = Matter.Render || WE USE P5 TO RENDER
World = Matter.World,
Bodies = Matter.Bodies

// create engine
let engine
let world
let circles = []
let ground
let boundaries = []

function setup() {
    // create canvas
    createCanvas(400,400)
    // necessary code for matter.js
    engine = Engine.create()
    world = engine.world
    // Engine.run(engine)

    // create ground bodies for Circlees to bounce on
    boundaries.push(new Boundary(150, 200, width-50, 10, 0.3, { isStatic: true }))
    boundaries.push(new Boundary(300, 350, width-50, 10, -0.3, { isStatic: true }))
}

function draw() {
    background(52)
    Engine.update(engine)
    circles.push(new Circle(25, 25, random(2,10)))
    
    for (i = 0; i < circles.length; i ++) {
        circles[i].show()
        if (circles[i].isDead()) {
            circles[i].removeFromWorld()
            circles.splice(i,1)
            i--
        }
    }
    for (i = 0; i < boundaries.length; i++) {
        boundaries[i].show()
    }

    // Check for amount of objects in circles[] and world.bodies[]
    console.log(circles.length, world.bodies.length)
}


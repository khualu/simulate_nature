// module aliases
const Engine = Matter.Engine,
    // Render = Matter.Render || WE USE P5 TO RENDER
World = Matter.World,
Bodies = Matter.Bodies
Constraint = Matter.Constraint

// create engine
let engine
let world
let boundaries = []
let particles = []

function setup() {
    // create canvas
    createCanvas(400, 400)
    // necessary code for matter.js
    engine = Engine.create()
    world = engine.world

    boundaries.push(new Boundary(width / 2, height, width, 100, 0))
    
    let prev = null
    for (x = width/2; x < width; x += 20) {
        let fixed = false
        if (!prev) {
            fixed = true
        }
        let p = new Particle(x, 100, 5, fixed)
        particles.push(p)

        if (prev) {
            let options = {
                bodyA: p.body,
                bodyB: prev.body,
                length: 20,
                stiffness: 0.2
            }

            let constraint = Constraint.create(options)
            World.add(world, constraint)
        }
        prev = p
    }
}

function draw() {
    background(52)
    Engine.update(engine)
    // particles.push(new Particle(200,50,random(1,10)))
    for (i = 0; i < boundaries.length; i++) {
        boundaries[i].show()
    }
    for (i = 0; i < particles.length; i++) {
        particles[i].show()
    }

}
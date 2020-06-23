function Circle(x, y, r) {
    let options = {
        friction: 0,
        restitution: 0.6
    }
    this.body = Bodies.circle(x, y, r, options)
    this.r = r
    World.add(world, this.body)

    this.isDead = function() {
        let pos = this.body.position
        return (pos.y > height + 100)
    }

    this.removeFromWorld = function() {
        World.remove(world, this.body)
    }

    this.show = function() {
        let pos = this.body.position
        let angle = this.body.angle
        push()
        translate(pos.x, pos.y)
        rotate(angle)
        ellipseMode(CENTER)
        strokeWeight(1)
        stroke(255)
        fill(127)
        ellipse(0,0, this.r*2)
        pop()
    }
}
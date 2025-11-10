include <boardgame_toolkit.scad>
include <BOSL2/std.scad>
include <Anachrony.scad>



// Water lid
translate([-width,0,0])
union() {
    difference() {
        SlidingLid(
            width = width, length = length, lid_thickness = lid_thickness) {                
        };
        translate([width/2.5, length/2, lid_thickness-wall_thickness])
                    drop(r=width/4, h=wall_thickness+delta);
        translate([width/2, length-wall_thickness-border, 0])
                    FingernailSurroundingSpace(radius = surround_fingernail_cylinder_radius, lid_thickness = lid_thickness);
        }
    translate([width/2, length-wall_thickness-border, 0])
        FingernailRecess(radius = fingernail_radius, lid_thickness = lid_thickness);
};

translate([-width,0,0])
    translate([width/2.5, length/2, lid_thickness-wall_thickness])
        drop(r=width/4, h=wall_thickness);

//Water box
MakeBoxWithSlidingLid(width = width, length = length, height = height, 
                        lid_thickness = lid_thickness, wall_thickness = wall_thickness)
            {
                translate([ 0, wall_thickness-wall_thickness, wall_thickness ]) cuboid([
                    width - wall_thickness * 2, length - wall_thickness * 2,
                    height -
                    lid_thickness - wall_thickness
                ], rounding = 10, except = TOP, anchor=FRONT+LEFT+BOTTOM);
            }


module drop(r=10, h=5) {
    m=[1,2,3,5];
    color("blue") linear_extrude(height = h) supershape(m1=1, n1=0.55, r=r);
}

module FingernailRecess(radius, lid_thickness, cylinder_radius=surround_fingernail_cylinder_radius) {
    intersection() {
        FingernailSurroundingSpace(radius = cylinder_radius, lid_thickness = lid_thickness);
        translate([0,0, 0]) SlidingLidFingernail(radius = radius, lid_thickness = lid_thickness);
    }
}

module FingernailSurroundingSpace(radius, lid_thickness) {
        linear_extrude(height = lid_thickness*2) front_half(planar=true) circle(r=radius);
}

translate([w_width+delta,0,0])
MakeBoxWithSlidingLid(width=w_width, length=w_length, height=w_height, 
                        lid_thickness = lid_thickness, wall_thickness = wall_thickness)
            {
                // translate([ 0, wall_thickness-wall_thickness, wall_thickness ]) cuboid([
                //     w_width - wall_thickness * 2, w_length - wall_thickness * 2,
                //     w_height -
                //     lid_thickness - wall_thickness
                // ], rounding = 10, except = TOP, anchor=FRONT+LEFT+BOTTOM);

                translate([ 0, wall_thickness, 0]) worker();
                translate ([0, 15, -wall_thickness-delta]) cylinder(h=w_height+delta, r=10, center=false);
            }
            

module worker() {
    linear_extrude(height = w_height) {
                    translate([10, 10, 0]) rect(20, 20, rounding=2);    
                    translate([10, 20, 0])  circle(r=10);
                }
}



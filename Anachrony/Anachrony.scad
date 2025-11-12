include <boardgame_toolkit.scad>
include <BOSL2/std.scad>
include <../bginserts.scad>
include <dimensions.scad>

$fn=50;

if (vALL) {
    %OldBox(position=[0, 0, 0], size=[coll_width, coll_length, coll_height], rot = 0, text="Tessere Collasso");
    %OldBox(position=[coll_width+delta, b_width, 0], size=[b_width, b_length, b_height], rot = -90, text="Edifici");
    %OldBox(position=[0, coll_length+delta, 0], size=[card_width, card_length, card_height], rot = 0, text="Carte");
    %OldBox(position=[coll_width+delta, b_width+delta, 0], size=[vpt_width, vpt_length, vpt_height], rot = 0, text="Victory Points");
    %OldBox(position=[coll_width+delta+vpt_width+delta, b_width+timeline_width+delta, 0], size=[timeline_width, timeline_length, timeline_height], rot = -90, text="Timeline");
    //OldBox(position=[coll_width+delta+vpt_width+delta, b_width+timeline_width+delta, 0], size=[timeline_width, timeline_length, timeline_height], rot = -90, text="Timeline");
    %OldBox(position=[250-sbt_length, b_width+delta+timeline_width+/*delta+res_width+*/delta+sbt_width, 0], size=[sbt_width, sbt_length, sbt_height], rot = -90, text="Breakthrough");
    %OldBox(position=[250-sbt_length, b_width+delta+timeline_width+/*delta+res_width+*/delta+sbt_width, sbt_height], size=[sbt_width, sbt_length, sbt_height], rot = -90, text="Breakthrough");
}

if (vALL || vNucleiBox) 
    translate([coll_width+delta, b_width+delta, vpt_height+delta]) box_nuclei();

if (vALL || vResourcesBox) 
    translate([250-res_length, b_width+delta+timeline_width+delta+res_width+delta+sbt_width, 0]) rot(-90) resources_box();


if (vALL || vWorkersBox) 
    translate([coll_width+delta, b_width+delta+ec_length+delta,0]) WorkersBox();    

if (vALL || vPlayerBox) {
    translate([coll_width+delta,b_width+timeline_width+res_width+sbt_width+delta*4,0]) player_box();
    translate([coll_width+delta+pb_width+delta,b_width+timeline_width+res_width+sbt_width+delta*4,0]) player_box();
    translate([coll_width+delta,b_width+timeline_width+res_width+sbt_width+delta*4,pb_height]) player_box();
    translate([coll_width+delta+pb_width+delta,b_width+timeline_width+res_width+sbt_width+delta*4,pb_height]) player_box();
}

module OldBox(position=[0,0,0], size=[10,10,10], rot=0, text="") {
    translate(position)
    rotate([0, 0, rot])
        //color("lightgrey", 0.5)
            diff() {
            cube(size, center=false)
                attach(TOP)
                    color("blue")
                    force_tag("remove")
                    translate([0,0,-1])
                        linear_extrude(height = 1+delta)
                            rotate (90)
                                text(text, size=12, halign="center", valign="center");
            }

}

module box_nuclei() {
    //Box nuclei energetici (energy cores)
    MakeBoxWithSlidingLid(width=ec_width, length=ec_length, height=ec_height, 
                        lid_thickness = lid_thickness, wall_thickness = wall_thickness)
            {
                for(x=[0:4])
                translate([ (ec_width-2*wall_thickness)/2, x*(ec_length-wall_thickness*2)/5+wall_thickness, 0 ]) 
                rounded_prism(hexagon(d=25), height=ec_height, joint_top=0, joint_bot=internal_fillet, joint_sides=internal_fillet, anchor=FRONT+BOTTOM);
            }
}

module resources_box() {
    //Risorse box
    MakeBoxWithSlidingLid(width=res_width, length=res_length, height=res_height, 
                        lid_thickness = lid_thickness, wall_thickness = wall_thickness)
            {
                translate([ 0, wall_thickness-wall_thickness, wall_thickness ]) cuboid([
                    res_width - wall_thickness * 2, res_length - wall_thickness * 2,
                    res_height -
                    lid_thickness - wall_thickness
                ], rounding = internal_rounding, except = TOP, anchor=FRONT+LEFT+BOTTOM);
            }
}


module player_box() {
    //Player box
    MakeBoxWithSlidingLid(width=pb_width, length=pb_length, height=pb_height, 
                lid_thickness = lid_thickness, wall_thickness = wall_thickness)
    {
        translate([ 0, wall_thickness-wall_thickness, wall_thickness ]) cuboid([
            pb_width - wall_thickness * 2, pb_length - wall_thickness * 2,
            pb_height -
            lid_thickness - wall_thickness
        ], rounding = internal_rounding, except = TOP, anchor=FRONT+LEFT+BOTTOM);
    }
}       

module WorkersBox() {
    //Box per lavoratori (6 spazi, 2 per ingegneri e scienziati, 1 per amministratori e geni)
    MakeBoxWithSlidingLid(width=w_width, length=w_length, height=w_height, 
                        lid_thickness = lid_thickness, wall_thickness = wall_thickness)
            {
                for(x=[0:2]) for(y=[0:1]) {
                    if (y == 0) {
                        translate([ (w_width-wall_thickness)/3*x + wall_thickness +ws_width/2, wall_thickness+ws_length, wall_thickness ]) 
                            workers_space() ;
                        translate([ (w_width-wall_thickness)/3*x + wall_thickness +ws_width/2, 0, wall_thickness ]) 
                            #fingerspace(height=w_height*2, cyl_rad=ws_top_width/3, wall_space_distance_v=internal_fillet) ;
                    } else {
                        translate([ (w_width-wall_thickness)/3*x + wall_thickness +ws_width/2,  w_length-(wall_thickness*2+ws_length), wall_thickness ]) 
                            yflip() workers_space() ;
                        translate([ (w_width-wall_thickness)/3*x + wall_thickness +ws_width/2,  w_length-wall_thickness/2*3, wall_thickness ]) 
                            yflip() fingerspace(height=w_height*2, cyl_rad=ws_top_width/3, wall_space_distance_v=internal_fillet) ;
                    }
                }

            }
}

module workers_space() {
    zmove(ws_length-ws_top_length)
    ymove(-(ws_length-ws_top_length))
    xrot(90)
    diff() {
        prismoid(size1=[ws_width, w_height], size2=[ws_top_width,w_height], height=ws_top_length,  rounding = [0, 0, internal_fillet, internal_fillet], rounding2=[0, 0, 2, 2])
        {
            //Arrotondiamo la parte superiore
            edge_profile([TOP], except=TOP+BACK, excess=internal_rounding, convexity=2)
            {
                mask2d_roundover(h=2,mask_angle=$edge_angle);
            }
            //Attacchiamo 
            position(BOTTOM) orient(BOT) {
                cuboid([ws_width, w_height, ws_length-ws_top_length],rounding = internal_fillet, except = [BACK, BOT], anchor=BOT); {
                    //cylinder(h=w_height*2, r=ws_top_width, center=false);
                }
            }
            
            //anchor_arrow(40);
        }
    }
}

translate([-50,0,0])
    yflip()
    workers_space() ;
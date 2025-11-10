include <boardgame_toolkit.scad>
include <BOSL2/std.scad>

$fn=50;
wall_thickness = 1.2;
width = 41; //3 mm in meno del box dei lavoratori
length = 41; // 3 mm in meno del box dei lavoratori
lid_thickness = 3;
height = 36.5; // Come box per timeline
fingernail_radius = 10; // radius of the fingernail recess
surround_fingernail_cylinder_radius = 8; // radius of the cylinder that surrounds the fingernail recess

delta = 0.5;

vALL = true;
vNucleiBox = false;
vResourcesBox = false;
vPlayerBox = false;
vWorkersBox = false;

//Box dimensions
box_width = 250;
box_length = 168 + delta + 169.05; //card_length + delta + coll_length;
box_height = 55; //circa

//Box Edifici (Buildings)
b_length = 217;
b_width = 33; 
b_height = 48;

//Box tessere collasso (collapse tiles)
coll_length = 169.5;
coll_width = 24;
coll_height = b_height;

//Box carte
card_length = 168;
card_width = coll_width;
card_height = b_height; //attualmente 49.5 ma lo faccio uguale a quello degli edifici

//Box linea del tempo (timeline)
timeline_length = 190;  
timeline_width = 75;
timeline_height = 36.5; 

//Victory Points tokens box 
vpt_length = 122;
vpt_width = 31; 
vpt_height = 28;

//Tessere ricerca scientifica (science breakthrough tiles) box
sbt_length = 141;
sbt_width = 72; 
sbt_height = 11;



//Box nuclei energetici (energy cores)
ec_length = vpt_length;
ec_width = vpt_width;
ec_height = coll_height - vpt_height - 5;  // Lasciamo lo spazio per i manuali, che debordano dal box della timeline

//Risorse box
res_length = 150; // Was 168; 
res_width = 30+wall_thickness; //Per lasciare il giusto spazio per i lavoratori
res_height = sbt_height*2; //Was 25.2;


//Player box
pb_length = box_length - sbt_width - timeline_width - b_width - res_width - 5*delta; //115;   
pb_width = 110+2;     
pb_height = timeline_height/2;

//Workers box
w_length = box_length - b_width - vpt_length - pb_length - 4*delta; //217;
w_width = box_width - card_width - res_length - 3*delta; //41; //3 mm in meno del box attuale
w_height = timeline_height; // Come box per timeline
ws_length = 26; //was 30;
ws_width = 20;
ws_top_length = 8;
ws_top_width = 10;


if (vALL) {
    OldBox(position=[0, 0, 0], size=[coll_width, coll_length, coll_height], rot = 0, text="Tessere Collasso");
    OldBox(position=[coll_width+delta, b_width, 0], size=[b_width, b_length, b_height], rot = -90, text="Edifici");
    OldBox(position=[0, coll_length+delta, 0], size=[card_width, card_length, card_height], rot = 0, text="Carte");
    OldBox(position=[coll_width+delta, b_width+delta, 0], size=[vpt_width, vpt_length, vpt_height], rot = 0, text="Victory Points");
    OldBox(position=[coll_width+delta+vpt_width+delta, b_width+timeline_width+delta, 0], size=[timeline_width, timeline_length, timeline_height], rot = -90, text="Timeline");
    //OldBox(position=[coll_width+delta+vpt_width+delta, b_width+timeline_width+delta, 0], size=[timeline_width, timeline_length, timeline_height], rot = -90, text="Timeline");
    OldBox(position=[250-sbt_length, b_width+delta+timeline_width+/*delta+res_width+*/delta+sbt_width, 0], size=[sbt_width, sbt_length, sbt_height], rot = -90, text="Breakthrough");
    OldBox(position=[250-sbt_length, b_width+delta+timeline_width+/*delta+res_width+*/delta+sbt_width, sbt_height], size=[sbt_width, sbt_length, sbt_height], rot = -90, text="Breakthrough");
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
        color("lightgrey", 0.5)
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
                rounded_prism(hexagon(d=25), height=ec_height, joint_top=0, joint_bot=2, joint_sides=2, anchor=FRONT+BOTTOM);
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
                ], rounding = 10, except = TOP, anchor=FRONT+LEFT+BOTTOM);
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
        ], rounding = 10, except = TOP, anchor=FRONT+LEFT+BOTTOM);
    }
}       

module WorkersBox() {
    //Box nuclei energetici (energy cores)
    MakeBoxWithSlidingLid(width=w_width, length=w_length, height=w_height, 
                        lid_thickness = lid_thickness, wall_thickness = wall_thickness)
            {
                for(x=[0:2]) for(y=[0:1]) {
                    if (y == 0)
                        translate([ (w_width-wall_thickness)/3*x + wall_thickness +ws_width/2, wall_thickness+ws_length, wall_thickness ]) 
                            workers_space() ;
                    else
                        translate([ (w_width-wall_thickness)/3*x + wall_thickness +ws_width/2,  w_length-(wall_thickness*2+ws_length), wall_thickness ]) 
                            yflip() workers_space() ;
                }

            }
}

module workers_space() {
    /*
    ymove(ws_length) xmove(ws_width)
    zrot(180)  
    
    union() {
        cuboid([ws_width, ws_length-ws_top_length, w_height*2],rounding = 2, except = [BACK, TOP], anchor=FRONT+LEFT+BOTTOM)
        //translate([ ws_width, ws_length-ws_top_length, 0]) 
            translate([ 0, ws_width/2, 0])
                //yrot(-90) xrot(-90) zrot(-90)
                xrot(-90) 
                zrot(-180)
                diff() {
                    prismoid(size1=[ws_width, w_height*2], size2=[ws_top_width, w_height*2], height=ws_top_length, rounding = [0, 0, 2, 2], rounding2=[0, 0, 2, 2])
                    {
                       edge_profile([TOP], excess=10, convexity=2) {
                            mask2d_roundover(h=2,mask_angle=$edge_angle);
                       }
                    }
            }
        }
        */
    zmove(ws_length-ws_top_length)
    ymove(-(ws_length-ws_top_length))
    xrot(90)
    diff() {
        prismoid(size1=[ws_width, w_height], size2=[ws_top_width,w_height], height=ws_top_length,  rounding = [0, 0, 2, 2], rounding2=[0, 0, 2, 2])
        {
            //Arrotondiamo la parte superiore
            edge_profile([TOP], except=TOP+BACK, excess=10, convexity=2)
            {
                mask2d_roundover(h=2,mask_angle=$edge_angle);
            }
            //Attacchiamo 
            position(BOTTOM) orient(BOT) {
                cuboid([ws_width, w_height, ws_length-ws_top_length],rounding = 2, except = [BACK, BOT], anchor=BOT); {
                    cylinder(h=w_height*2, r=ws_top_width, center=false);
                }
            }
            
            //anchor_arrow(40);
        }
    }
}

translate([-50,0,0])
    yflip()
    workers_space() ;
include <BOSL2/std.scad>

module fingerspace(height, cyl_rad, wall_space_distance_o, wall_space_distance_v=0, wall_thickness=1.2) {
    translate([0, cyl_rad + wall_space_distance_v + wall_thickness, wall_thickness]) {
        cyl(h=height, r=cyl_rad, anchor=BACK) {
            back_half()rounding_hole_mask(r=cyl_rad, rounding=wall_thickness);
        }
        back(-cyl_rad) cube(size=[cyl_rad*2,cyl_rad*2,height], anchor=BACK) {
            back(cyl_rad-wall_thickness-wall_space_distance_v)
            {
                right(cyl_rad) back(-wall_thickness/2) fillet(l=height, r=wall_thickness/2, ang=90);
                //Internal
                left(cyl_rad) back(wall_thickness/2) zrot(180) up(height/4)  fillet(l=height/2, r=wall_thickness/2, ang=90);
            }
            back(cyl_rad-wall_thickness-wall_space_distance_v)
            {
                left(cyl_rad) back(-wall_thickness/2) zrot(90) fillet(l=height, r=wall_thickness/2, ang=90);
                //Internal
                right(cyl_rad) back(wall_thickness/2) up(height/4) zrot(-90) fillet(l=height/2, r=wall_thickness/2, ang=90);
            }
        }
    }
}
$fn=50;
%cube([30,1.2,16], center=true);
%left(15) cube([30, 30, 1.2]);
fingerspace(height=16, cyl_rad=5, wall_space_distance_v=2);
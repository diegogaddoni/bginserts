include <BOSL2/std.scad>

bitspace = 0.01; //To avoid Z-fighting

module fingerspace(height, cyl_rad, cube_width, wall_space_distance_o=0, wall_thickness=1.2, fillet_ang=90) {
    cw = (cube_width == undef ? cyl_rad * 2 : cube_width);

    translate([0, cyl_rad + wall_space_distance_o + wall_thickness, wall_thickness]) {
        cyl(h=height, r=cyl_rad, anchor=BACK) {
            if (cyl_rad - cw > wall_space_distance_o)
                rounding_hole_mask(r=cyl_rad, rounding=wall_thickness);
            else 
                back_half()rounding_hole_mask(r=cyl_rad, rounding=wall_thickness);
        }
        back(-cyl_rad+bitspace) cube(size=[cw, cw, height], anchor=BACK) {
            back(cyl_rad-wall_thickness-wall_space_distance_o)
            {
                right(cyl_rad) back(-wall_thickness/2) fillet(l=height, r=wall_thickness/2, ang=fillet_ang);
                //Internal
                left(cyl_rad) back(wall_thickness/2) zrot(180) up(height/4)  fillet(l=height/2, r=wall_thickness/2, ang=fillet_ang);
            }
            back(cyl_rad-wall_thickness-wall_space_distance_o)
            {
                left(cyl_rad) back(-wall_thickness/2) zrot(90) fillet(l=height, r=wall_thickness/2, ang=fillet_ang);
                //Internal
                right(cyl_rad) back(wall_thickness/2) up(height/4) zrot(-90) fillet(l=height/2, r=wall_thickness/2, ang=fillet_ang);
            }
        }
    }
}
/*
$fn=50;
%cube([30,1.2,16], center=true);
%left(15) cube([30, 30, 1.2]);
fingerspace(height=16, cyl_rad=5, wall_space_distance_o=2);


right(50) fingerspace(height=16, cyl_rad=7.5, cube_width=10, wall_space_distance_o=2+5);
*/
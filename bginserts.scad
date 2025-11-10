include <BOSL2/std.scad>

module fingerspace(height, cyl_rad, inside_height, wall_space_distance_o, wall_space_distance_v=0) {
    cyl(h=height, r=cyl_rad, anchor=BACK) {
        back_half()rounding_hole_mask(r=cyl_rad, rounding=wall_thickness);
    }
    back(-ws_top_width/2) cube(size=[cyl_rad*2,cyl_rad*2,inside_height*2], anchor=BACK) {
        back(cyl_rad-wall_thickness-wall_space_distance_v)
        {
            right(cyl_rad) back(-wall_thickness) fillet(l=inside_height*2, r=wall_thickness, ang=90);
            //Internal
            left(cyl_rad) back(wall_thickness) zrot(180) up(inside_height/2)  fillet(l=inside_height, r=wall_thickness, ang=90);
        }
        back(cyl_rad-wall_thickness-wall_space_distance_v)
        {
            left(cyl_rad) back(-wall_thickness) zrot(90) fillet(l=inside_height*2, r=wall_thickness, ang=90);
            //Internal
            right(cyl_rad) back(wall_thickness) up(inside_height/2) zrot(-90) fillet(l=inside_height, r=wall_thickness, ang=90);
        }
    }
}

fingerspace(height=10, cyl_rad=5, inside_height=8, wall_space_distance_v=2);
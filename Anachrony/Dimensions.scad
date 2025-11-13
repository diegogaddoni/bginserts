wall_thickness = 1.2;
width = 41; //3 mm in meno del box dei lavoratori
length = 41; // 3 mm in meno del box dei lavoratori
lid_thickness = 3;
height = 36.5; // Come box per timeline
fingernail_radius = 10; // radius of the fingernail recess
surround_fingernail_cylinder_radius = 8; // radius of the cylinder that surrounds the fingernail recess

delta = 0.5;

vALL = false;
vNucleiBox = false;
vResourcesBox = false;
vPlayerBox = false;
vWorkersBox = true;

vLids = true;
vBoxes = false;

internal_fillet = 2;
internal_rounding = 10;

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
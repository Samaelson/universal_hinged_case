include <BOSL2/std.scad>

// Filament shrinkage tolerance value
t=0.259;

module screw_M2x30_cutout(){
    // M2x30 cylinder head screw
    cylinder(30.1,r=(1.46+t)/2,$fn=100); 
    cylinder(10.1,r=(2.8+t)/2,$fn=100);    
    translate([0,0,-0.1])
    cylinder(3.1,r=(4.2+t)/2,$fn=100); 
}

module screw_cuts(x_h=50,y_h=100){
    translate([-(x_h+7)/2,(y_h)/2,(10+t)/2+2.4])
    rotate([0,90,0])
    screw_M2x30_cutout();

    translate([-(x_h+7)/2,(y_h)/2,(10+t)/2+2.5])
    rotate([0,90,0])
    screw_M2x30_cutout();

    translate([-(x_h+7)/2,(y_h)/2,(10+t)/2+2.6])
    rotate([0,90,0])
    screw_M2x30_cutout();

    translate([(x_h+7)/2,(y_h)/2,(10+t)/2+2.4])
    rotate([0,-90,0])
    screw_M2x30_cutout();

    translate([(x_h+7)/2,(y_h)/2,(10+t)/2+2.5])
    rotate([0,-90,0])
    screw_M2x30_cutout();

    translate([(x_h+7)/2,(y_h)/2,(10+t)/2+2.6])
    rotate([0,-90,0])
    screw_M2x30_cutout();
}


module chamfers(x_h=50,y_h=100){
    difference(){
        union(){ 
            // chamfer top left/right
            translate([0,y_h/2-4.7,-0.1])
            rotate([0,0,-2])
            translate([-1,0,0])
            cube([x_h,20,4+t]);

            // chamfer top left/right
            translate([0,y_h/2-4.7,0])
            rotate([0,0,2])
            translate([-x_h+1,0,-0.1])
            cube([x_h,20,4+t]);
        }

        translate([-(x_h)/2-0.1,(y_h)/2,(10+t)/2+3])
        rotate([0,90,0])
        cylinder(h=x_h+0.2,r=(10+t)/2,$fn=100);
     }
}

module wall_body(x_h=50,y_h=100,z_h=50,z_l=0.2){

    // y chamfer marker needs to be calculated
    y_cf = tan(2)*(x_h/2)+t/2; 
    
    // make sure minimum hight requirement is fullfilled 
    z_h = z_h < 20 ? 20 : z_h;

    z_cut = tan((90-atan2(y_h,(z_h*z_l))))*y_h > z_h-10 ? z_h-10 : tan(90-atan2(y_h,(z_h*z_l)))*y_h;     

    a_cut = (90-atan2(y_h,z_cut));

    difference(){
        union(){
            difference(){
                translate([-(x_h)/2,-(y_h)/2,0])
                cube([x_h, y_h,z_h]);

                translate([-(x_h-5)/2,-(y_h-5)/2,2.5])
                cube([x_h-5, y_h-5-(10+t)/2-3-(tan(2)*(x_h/2)),z_h+10]);
            }
            
            translate([-(x_h)/2,(y_h)/2,(10+t)/2+3])            
            rotate([0,90,0])
            cylinder(h=x_h,r=(10+t)/2,$fn=100);

            difference(){
                translate([0,(4+0.1285)/2-4.5,z_h/2])
                cuboid([x_h+7, y_h+t/2+2,z_h],rounding=3,$fn=100, edges=[LEFT+FRONT,RIGHT+FRONT]);

                translate([-(x_h+17)/2,y_h/2-y_cf-4.7,4+t-0.1])
                rotate([-a_cut,0,0])
                translate([0,-2*y_h+20,0])
                cube([x_h+17, 2*y_h,2*z_h]);        
              
                // inner cutout
                translate([-(x_h-5)/2,-(y_h-5)/2,2.5])
                cube([x_h-5, y_h-7-(10+t)/2-(tan(2)*(x_h/2)),z_h+10]);    
            }    
        }

        translate([0,0,2*t])
        screw_cuts(x_h,y_h);

        chamfers(x_h, y_h);

        translate([-(x_h+50)/2, -(y_h+10)/2,z_cut+10])
        cube([x_h+50, y_h+10,z_h]);
 
        // Magnet cutout
        translate([-(20+t)/2,y_h/2+1-5,13])
        cube([20+t,2+t,10+t+z_h]);
 
    }
}


module lid_body(x_h=50,y_h=100,z_h=50,z_l=0.2){

    // y chamfer marker needs to be calculated
    y_cf = tan(2)*(x_h/2)+t/2; 
    
    // make sure minimum hight requirement is fullfilled 
    z_h = z_h < 20 ? 20 : z_h;

    z_cut = tan((90-atan2(y_h,(z_h*z_l))))*y_h > z_h-10 ? z_h-10 : tan(90-atan2(y_h,(z_h*z_l)))*y_h;     

    a_cut = (90-atan2(y_h,z_cut));


    difference(){    
        union(){
            // hinge section
            translate([0,0,-(11-t)])
            difference(){

                translate([-(x_h+5)/2-1,(y_h)/2,(10+t)/2+2.5])
                rotate([0,90,0])
                cylinder(h=x_h+7,r=(15+t)/2,$fn=100);

                translate([-(x_h+0.5)/2,(y_h)/2,(10+t)/2+2.5])
                rotate([0,90,0])
                cylinder(h=x_h+0.5,r=(10+2*t)/2,$fn=100);

                translate([-(x_h+0.5)/2, -(y_h+7)/2,0])
                cube([x_h+0.5, y_h+11+t/2-(15+t)/2+4,(10+t)/2]);  

                translate([-(x_h+0.5)/2, -(y_h+7)/2,0])
                cube([x_h+0.5, y_h+11+t/2-(15+t)/2+t/2,(10+t)+5]);  

                screw_cuts(x_h,y_h);

                translate([-(x_h+0.5)/2, -(y_h+2)/2,0])
                cube([x_h+0.5, y_h+11+t/2-(15+t)/2+13.3,3]);  
            
            }

            difference(){
                union(){
                    translate([0,(4+t/2)/2,(z_h+2.5-(10+t))/2-3])
                    cuboid([x_h+7, y_h+11+t/2,z_h+2.5-(10+t)],rounding=3,$fn=100, edges=[TOP,LEFT+FRONT,RIGHT+FRONT]);
                    
                    translate([-(x_h+7)/2,(y_h)/2,(10+t)/2+2.5-(14-t-3)])
                    rotate([0,90,0])
                    cylinder(h=2.5,r=(15+t)/2,$fn=100);

                    translate([(x_h+7)/2-2.5,(y_h)/2,(10+t)/2+2.5-(14-t-3)])
                    rotate([0,90,0])
                    cylinder(h=2.5,r=(15+t)/2,$fn=100);
                  
                    difference(){
                        translate([0,-4/2,(21+t-((10+t)/2+2.5))/2-9])
                        cuboid([x_h+7, y_h+3,21+t-((10+t)/2+2.5)],rounding=3,$fn=100, edges=[LEFT+FRONT,RIGHT+FRONT]);             
                        
                        translate([-(x_h+17)/2,y_h/2-y_cf-4.7,-7])
                        rotate([-a_cut,0,0])
                        translate([0,-2*y_h+20,-2*z_h])
                        cube([x_h+17, 2*y_h,2*z_h]);  
                                
                        }
                }
                    
                translate([-(x_h+2)/2+1-t, -(y_h+2)/2+1-t,-12.5])
                cube([x_h+2*t, y_h-(10+t)/2+5.5,z_h]);
                
                
                translate([-(x_h+5)/2,(y_h)/2,(10+t)/2+2.5-(11-t)])
                rotate([0,90,0])
                cylinder(h=x_h+5,r=(10+t)/2,$fn=100);    
                
                translate([0,0,-(11-t)])
                screw_cuts(x_h,y_h);

                translate([-(x_h+17)/2,y_h/2-y_cf-4.7,-7])
                rotate([-a_cut,0,0])
                translate([0,-2*y_h+20,-2*z_h])
                cube([x_h+17, 2*y_h,2*z_h]);  

                
            }

        }
         
        // Magnet cutout
        translate([-(20+t)/2,(y_h)/2+1,9-20])
        cube([20+t,2+t,10+t+9]);
        
        translate([-(x_h-10)/2,-(y_h)/2-7.5,(z_h)-19])
        rotate([0,90,0])
        union(){
            cylinder(h=x_h-10,r=(10+t)/2,$fn=100);

            sphere((10+t)/2,$fn=100);
            translate([0,0,x_h-10])
            sphere((10+t)/2,$fn=100);
        }
    }

}

// Module: case_body()
// Synopsis: Creates lid for a 3D hinged case arround object to be 
//           used for outdoor wall mount.
// SynTags: 
// Topics: 
// See Also: 
// Usage:
//   case_body(x_o, y_0, z_o, [x_d=], [y_d=], [z_d=]);
// Description:
//   Creates a 3D hinged case body arround an object - specified by [x_o,y_o,z_o] - to be used in combination with case_lid() for outdoor wall mount
// Arguments:
//   x_o = x dimensions of object to be placed in the case.
//   x_o = x dimensions of object to be placed in the case.
//   x_o = x dimensions of object to be placed in the case.
//   ---
//   x_d = x distance between object and case.
//   y_d = y distance between object and case.
//   z_d = d distance between object and lid.
module case_body(x_o=50,y_o=100,z_o=50,x_d=20,y_d=20,z_d=5,z_li=0.2){

    x_h = x_o+2*x_d+t;
    y_h = y_o+2*y_d+t+tan(2)*(x_h/2);
    z_h = z_o+z_d+t;
   
    echo("Case size body: x=",x_h,"y=",y_h,"z=",z_h);
    
    wall_body(x_h,y_h,z_h,z_li);

}



// Module: case_lid()
// Synopsis: Creates lid for a 3D hinged case arround object to be 
//           used for outdoor wall mount.
// SynTags: 
// Topics: 
// See Also: 
// Usage:
//   case_lid(x_o, y_0, z_o, [x_d=], [y_d=], [z_d=], [a=]);
// Description:
//   Creates a 3D hinged lid arround an object - specified by [x_o,y_o,z_o] - to be used in combination with case_body() for outdoor wall mount
// Arguments:
//   x_o = x dimensions of object to be placed in the case.
//   x_o = x dimensions of object to be placed in the case.
//   x_o = x dimensions of object to be placed in the case.
//   ---
//   x_d  = x distance between object and case.
//   y_d  = y distance between object and case.
//   z_d  = d distance between object and lid.
//   z_li = lid to body reference.
//   a    = lid opening angle.
module case_lid(x_o=50,y_o=100,z_o=50,x_d=20,y_d=20,z_d=5,z_li=0.2,a=0){

    x_h = x_o+2*x_d+t;
    y_h = y_o+2*y_d+t+tan(2)*(x_h/2);
    z_h = z_o+z_d+t;
 
    translate([0,(y_h)/2,2*((10+t)/2)-2-t/2])
    rotate([-a,0,0])
    translate([0,-(y_h)/2,((10+t)/2-2)])
    lid_body(x_h,y_h,z_h,z_li);
  
}


/***********************************************************************
    main section
***********************************************************************/
//Additional parts:
// 2x magnets 20x10x2-mm-n45-nickel
// 2x M2x30 cylinder head screw

/*
x_object = 100;
y_object = 200;
z_object = 50;
lid_opening_angle = 45;
lid_body_ratio = 0.4;


case_lid(x_object,y_object,z_object,z_li=lid_body_ratio,a=lid_opening_angle);
case_body(x_object,y_object,z_object,z_li=lid_body_ratio);
*/

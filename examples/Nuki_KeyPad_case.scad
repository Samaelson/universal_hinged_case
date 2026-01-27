include <BOSL2/std.scad>
include <universal_hinged_case.scad>

// Filament shrinkage tolerance value
t=0.259;

module Nuki_keypad(){
    
        translate([-(4.3+t)/2,-(118.40+t)/2+30+(4.3+t)/2,-10])
        cylinder(h=20,r=(4.3+t)/2,$fn=100);

        translate([0,-(118.40+t)/2+30+(4.3+t)/2,-10])
        cylinder(h=20,r=(4.3+t)/2,$fn=100);

        translate([(4.3+t)/2,-(118.40+t)/2+30+(4.3+t)/2,-10])
        cylinder(h=20,r=(4.3+t)/2,$fn=100);
        
        translate([-(4.3+t)/2,-(118.40+t)/2+30,-10])
        cube([(4.3+t),(4.3+t),20]);
        
        translate([0,-(118.40+t)/2+89.5+(4.3+t)/2,-10])
        cylinder(h=20,r=(4.3+t)/2,$fn=100);

        translate([0,-(118.40+t)/2+89.5+2*(4.3+t)/2,-10])
        cylinder(h=20,r=(4.3+t)/2,$fn=100);

        translate([0,-(118.40+t)/2+89.5+3*(4.3+t)/2,-10])
        cylinder(h=20,r=(4.3+t)/2,$fn=100);

        translate([-(4.3+t)/2,-(118.40+t)/2+89.5+(4.3+t)/2,-10])
        cube([(4.3+t),(4.3+t),20]);        
        
        translate([-(29.30+t)/2, -(118.40+t)/2,0])
        cube([29.30+t, 118.40+t,21+t]);
    
}



/***********************************************************************
    main section
***********************************************************************/

// lid opening angle
angle = 45;

// Nuki keypad
x_object = 29.30;
y_object = 118.40;
z_object = 21;

color([150/255, 60/255, 200/255],0.8)
Nuki_keypad();

 
case_lid(x_object,y_object,z_object,a=angle);


difference(){
case_body(x_object,y_object,z_object);
    translate([0,0,2.5])
    Nuki_keypad();
}




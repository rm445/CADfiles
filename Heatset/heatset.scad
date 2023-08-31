
$fn=50;

module iron() {
    // My soldering iron, with part of the grip removed (annoying taper part)
    color("silver") union() {
        hull() {
            sphere(r=0.75);
            translate([0,0,8]) cylinder(d=3.9, h=18.5);
        }
        translate([0,0,26.5]) cylinder(d=10, h=84);
        translate([0,0,31])
          rotate([0,90,0])
            cylinder(d=5.5, h=15, center=true);
    }
    color("red") translate([0,0,110.5]) union() {
        cylinder(d=17.4, h=39);
        translate([0,0,39]) cylinder(d=17.8, h=1.6);
        translate([0,0,40.6]) cylinder(d1=20, d2=17, h=79.4);
    }
    color("black") translate([0,0,231.5]) cylinder(d=7, h=18);
}

module carriage() {
    color("silver") difference() {
        translate([6, 0, 6])
              cube([23, 1.2, 40]);
        translate([17.5, 0, 15.5])
          rotate([-90, 0, 0])
            cylinder(d=4.3, h=100, center=true);
        translate([17.5, 0, 15.5+19])
          rotate([-90, 0, 0])
            cylinder(d=4.3, h=100, center=true);
    }
    color("#FFCF80") difference() {
        translate([0, 1.2, 0])
              cube([35, 5.7, 52]);
        translate([17.5, 1.2, 15.5])
          rotate([-90, 0, 0]) 
            cylinder(d=8.3, h=100);
        translate([17.5, 1.2, 15.5+19])
          rotate([-90, 0, 0]) 
            cylinder(d=8.3, h=100);
        translate([11.25, 3.8, -10]) cube([12.5, 100, 100]);
        translate([0, 0, -10]) cube([5.6, 2.5, 100]);
        translate([35-5.6, 0, -10]) cube([5.6, 2.5, 100]);
    }
}

module rail() {
    color("silver") difference() {
        cube([40, 8.5, 100]);
        translate([2, 1.3, -1]) cube([11.6, 4.4, 200]);
        translate([40-2-11.6, 1.3, -1]) cube([11.6, 4.4, 200]);
        translate([7.5, -1, -1]) cube([25, 8.5-5.4+1, 200]);
        translate([20, -1, 20]) //bottom hole
          rotate([-90, 0, 0])
            cylinder(d=4.3, h=200);
        translate([20, -1, 20]) // bottom hole c/bore
          rotate([-90, 0, 0])
            cylinder(d=8.3, h=3.1+4); //top hole
        translate([20, -1, 20+60])
          rotate([-90, 0, 0])
            cylinder(d=4.3, h=200);
        translate([20, -1, 20+60]) // top hole c/bore
          rotate([-90, 0, 0])
            cylinder(d=8.3, h=3.1+4);
        
    }
}

module slide_lower() {
    in_x = 4;
    in_z = 5;
    ins_d = 5;
    ins_h = 6;
    w = 35;
    h=38;
    color("blue") difference() {
        union() {
            cube([w, 20, h]);
        }
        translate([w/2,-0.5,-10]) cylinder(d=17.6, h=100);
        translate([in_x, -1, in_z])
          rotate([-90, 0, -1]) cylinder(d=ins_d, h=ins_h+1);
        translate([in_x, -1, h-in_z])
          rotate([-90, 0, -1]) cylinder(d=ins_d, h=ins_h+1);
        translate([w-in_x, -1, in_z])
          rotate([-90, 0, -1]) cylinder(d=ins_d, h=ins_h+1);
        translate([w-in_x,-1, h-in_z])
          rotate([-90, 0, -1]) cylinder(d=ins_d, h=ins_h+1);
        translate([w/2, 20-ins_h, 19/2]) // was 15.5
          rotate([-90, 0, 0]) 
            cylinder(d=ins_d, h=100);
        translate([w/2, 20-ins_h, 19/2+19])
          rotate([-90, 0, 0]) 
            cylinder(d=ins_d, h=100);
         
    }
}

module slide_upper() {
    in_x = 4;
    in_z = 5;
    w = 35;
    h=38;
    screw_clr = 3.6;
    cbore = 6;
    color("blue") difference() {
        cylinder(d=35, h=38);
        translate([0, 0, -1]) cylinder(d=17.6, h=40);
        translate([-100, -0.5, -100]) cube([200, 200, 200]);
        translate([-w/2+in_x, -100, in_z])
          rotate([-90, 0, 0])
            cylinder(d=screw_clr, h=200);
        translate([w/2-in_x, -100, in_z])
          rotate([-90, 0, 0])
            cylinder(d=screw_clr, h=200);
        translate([-w/2+in_x, -100, h-in_z])
          rotate([-90, 0, 0])
            cylinder(d=screw_clr, h=200);
        translate([w/2-in_x, -100, h-in_z])
          rotate([-90, 0, 0])
            cylinder(d=screw_clr, h=200);
        
        translate([-w/2+in_x, -4, in_z])
          rotate([90, 0, 0])
            cylinder(d=cbore, h=200);
        translate([+w/2-in_x, -4, in_z])
          rotate([90, 0, 0])
            cylinder(d=cbore, h=200);
        translate([-w/2+in_x, -4, h-in_z])
          rotate([90, 0, 0])
            cylinder(d=cbore, h=200);
        translate([+w/2-in_x, -4, h-in_z])
          rotate([90, 0, 0])
            cylinder(d=cbore, h=200);
        
    }    
}

module base() {
    cr = 10;
    t = 10;
    color("blue") difference() {
        hull() {
            translate([-40, -40, 0])
              cylinder(r=cr, h=t);
            translate([+40, -40, 0])
              cylinder(r=cr, h=t);
            translate([-20, +75-cr, 0])
              cylinder(r=cr, h=t);
            translate([+20, +75-cr, 0])
              cylinder(r=cr, h=t);
        }
        // holes
    }
}

module back() {
    color("blue") difference() {
        union() {
            cube([40, 12, 112]);
            translate([0, -8.5, -5])
              cube([40, 8.5+12, 5]);
            translate([2.5, -20, 112]) hull() {
                cube([35, 32, 5]);
                translate([35/2, 10,10])
                  rotate([0, 90, 0])
                    cylinder(r=10, h=35, center=true);
                translate([35/2, 22,10])
                  cube([35, 20, 20], center=true);
                /* translate([35/2, 22,15])
                  rotate([0, 90, 0])
                    cylinder(r=10, h=35, center=true); */
            }
        }
        //subtract
        translate([-1000, -2000-20.5, -1000])
          cube([2000, 2000, 2000]);
        translate([-50, -100, 0])
          cube([100, 100, 30]);
        translate([40, 0, 112])
          rotate([90, 0, 0])
            cylinder(d=5, h=100, center=true);
        translate([0, 0, 112])
          rotate([90, 0, 0])
            cylinder(d=5, h=100, center=true);
        
       
    }
}

module support() {
    sx = 40;
    sy = 28.5;
    st = 8;
    c = "blue";
    color(c) union() {
        translate([-sx/2, 21.5, 98.5-st])
          cube([sx, sy, st]);
        translate([-sx/2, 42, 98.5])
          cube([sx, st, 28]);
    }
    ypos = 75-28.5;
    ofs = 160;
    color(c) difference() {
        union() {
            translate([0,-ofs,0])
              rotate([0, 90, 0])
                cylinder(r=ypos+ofs+sy, h=sx, center=true);
        }
        //subtract
        translate([0,-ofs,0]) //ring ctr
          rotate([0, 90, 0])
            cylinder(r=ypos+ofs, h=2*sx, center=true);
        translate([-sx, -1000, -2000]) // chop bottom
          cube([2*sx, 2000, 2000]);
        translate([-sx, -2000+21.5, 0]) // chop back
          cube([2*sx, 2000, 2000]);
        translate([-sx, -1000, 98.5+st])
          cube([2*sx, 2000, 2000]);
    }
}

module assembly() {
    translate([0,0,0]) iron();
    translate([-35/2,20,110.5-7]) carriage();
    translate([-40/2,21.2, 110.5-1]) rail();
    translate([-35/2, 0, 110.5]) slide_lower();
    translate([0, 0, 110.5]) slide_upper();
    translate([0, 0, -10]) base();
    translate([-20,30,103.5]) back();
    //#cube([20, 42, 98.5]);
    //#cube([30, 21.5, 98.5]);
    //#cube([20, 75, 2]);
    translate([0, 0, 0]) support();
    
    
    
    
}
//103.5

//iron();    
//carriage();

//slide_lower();

assembly();
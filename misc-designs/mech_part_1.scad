//$fa=1;
$fs=0.5;

module roundedRect(size, radius)
{
    x = size[0];
    y = size[1];
    z = size[2];

    linear_extrude(height=z)
    hull() {
        // place 4 circles in the corners, with the given radius
        translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
        circle(r=radius);

        translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
        circle(r=radius);

        translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
        circle(r=radius);

        translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
        circle(r=radius);
    }
}



module pcd(n, d) 
{
    angle = 360/n;
    for (i=[0:n-1]) {
        rotate([0,0,i*angle]) translate([d/2,0,0]) children();
    }
    
}

module grid(size, xn, yn, center=false)
{
    xmin = center == true ?  -0.5 * size[0] : 0;
    ymin = center == true ?  -0.5 * size[1] : 0;
    x_spacing = size[0] / (xn - 1);
    y_spacing = size[1] / (yn - 1);
    for (y = [0: yn - 1]) {
        for (x = [0: xn-1]) {
            translate([xmin+x*x_spacing, ymin + y*y_spacing, 0]) children();
        }
    }
}


module bearing_housing() {
    boss_size = [60, 60, 10];
    boss_rad = 5;
    boss_holes = [50, 50];
    cyl_dia = 50;
    cyl_h = 35;
    thru_dia = 20;
    cap_pcd = 37.5;
    cap_n = 8;
    M6_clearance = 6.5;
    M4_insert_h = 5.9;
    M4_insert_d = 8;
    flange_thk = 2;
    flange_dia = 25;
    
    h_tot = boss_size.z + cyl_h;
    difference() {
        union() {
            roundedRect(boss_size, boss_rad);
            translate([0,0,boss_size.z]) cylinder(h=cyl_h, d=cyl_dia);
        }
        cylinder(h=h_tot,d=thru_dia);
        translate([0,0,h_tot-flange_thk]) cylinder(h=flange_thk, d=flange_dia);
        pcd(cap_n, cap_pcd) translate([0,0,h_tot-M4_insert_h]) cylinder(d=M4_insert_d, h=M4_insert_h);
        grid(boss_holes, 2, 2, center=true) cylinder(d=M6_clearance, h=boss_size.z);
    }
}

render(convexity=5) color("blue") bearing_housing();

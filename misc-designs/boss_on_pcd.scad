module pcd(n, d) {
    angle = 360/n;
    for (i=[0:n-1]) {
        rotate([0,0,i*angle]) translate([d/2,0,0]) children();
    }
}

module boss_on_pcd(n, pcd, r) {
    hull() {
        for (i=[0: n-1]) {
            pcd(n, pcd) circle(r=r);
        }
    }
}

module stepped_boss() {
    difference() {
        union() {
            linear_extrude(10) boss_on_pcd(6, 100, 10);
            linear_extrude(20) boss_on_pcd(6, 80, 10);
            linear_extrude(30) boss_on_pcd(6, 60, 10);
        }
        pcd(6, 60) cylinder(d=10, h=30.1);
        cylinder(d=30, h=30.1);
    }
}

module lin_ext_test() {
    linear_extrude(10) {
        difference() {
            boss_on_pcd(12, 100, 10);
            pcd(12, 100) circle(d=10);
        }
    }
}
  
module circ_test() {
    difference() {
        circle(d=100);
        translate([50, 0, 0]) square(100, center=true);
    }
}

stepped_boss();
//lin_ext_test();
//circ_test();
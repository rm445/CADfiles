module cbore(hdia, hh, cbdia, cbh) {
    cylinder(d=hdia, h=hh);
    translate([0,0, hh-cbh]) cylinder(d=cbdia, h=cbh);
}

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

module cb_boss() {
    thk = 30;
    difference() {
        union() {
            linear_extrude(thk) boss_on_pcd(4, 80, 10);
        }
        pcd(4, 80) cbore(4.5, thk, 8, thk-6);
    }
}

cb_boss();
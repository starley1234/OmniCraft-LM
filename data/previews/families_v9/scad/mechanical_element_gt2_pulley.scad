$fn = 32;
// GT2 pulley, 24 teeth, 9 mm belt.

teeth = 24;
belt_w = 9;
bore_d = 5;
pitch_d = teeth * 2 / PI;
flange_d = pitch_d + 3;
flange_t = 1.2;
hub_h = 7;
hub_d = bore_d + 7;
eps = 0.01;
// Stack heights cumulatively from one running z. Deriving the hub start as
// 2 * flange_t + belt_w while the flange ended at flange_t + belt_w + flange_t
// left a 1e-15 mm gap for some belt widths, which Manifold exported as a
// degenerate ring of non-manifold edges.
z_belt = flange_t;
z_top_flange = z_belt + belt_w;
z_hub = z_top_flange + flange_t;
total_h = z_hub + hub_h;

difference() {
    union() {
        cylinder(h = flange_t + eps, d = flange_d);
        translate([0, 0, z_belt])
            cylinder(h = belt_w + eps, d = pitch_d);
        translate([0, 0, z_top_flange])
            cylinder(h = flange_t + eps, d = flange_d);
        translate([0, 0, z_hub])
            cylinder(h = hub_h, d = hub_d);
    }
    translate([0, 0, -1]) cylinder(h = total_h + 2, d = bore_d);
    for (i = [0 : teeth - 1])
        rotate([0, 0, i * 360 / teeth])
            translate([pitch_d / 2, 0, z_belt - 0.1])
                cylinder(h = belt_w + 0.2, d = 1.3);
    translate([0, 0, z_hub + hub_h / 2])
        rotate([0, -90, 0]) cylinder(h = hub_d, d = 3.2);
}

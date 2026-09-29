$fn = 32;

// ----------------------------------------------------------------------
// Timing pulley: HTD5 20T, pitch 5 mm, 31.23 mm x 17 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
pitch = 5;                // belt pitch
teeth = 20;               // number of grooves
belt_w = 11;              // belt width between the flanges
tip_d = 31.23;            // tip circle diameter
root_d = 29.03;           // groove bottom diameter
groove_h = 1.1;           // groove depth
tooth_w = 3.2;            // groove width at the tip circle
bore_d = 6.35;            // shaft bore
hub_d = 15.62;            // hub diameter
hub_h = 6;                // hub above the flange
bottom_z = 0;             // lowest point of the pulley
top_z = 17;               // highest point of the pulley
set_d = 3.4;              // set screw tap hole
ring_d = 2.8;             // clamp screw hole
ring_r = 10.2;            // clamp screw radius

module rim() {
  cylinder(h = belt_w, d = tip_d);
}

module groove_cutter() {
  /* belt tooth groove: deeper than wide, cut through the belt width */
  translate([root_d / 2, 0, 0])
    linear_extrude(height = belt_w)
      polygon(points = [[-0.6, -tooth_w * 0.42], [groove_h + 0.6, -tooth_w * 0.6],
                        [groove_h + 0.6, tooth_w * 0.6], [-0.6, tooth_w * 0.42]]);
}

module hub() {
  translate([0, 0, bottom_z]) cylinder(h = top_z - bottom_z, d = hub_d);
}

difference() {
  union() {
    rim();
    hub();
  }
  for (i = [0 : teeth - 1]) rotate([0, 0, i * 360 / teeth]) groove_cutter();
  translate([0, 0, bottom_z - 1]) cylinder(h = top_z - bottom_z + 2, d = bore_d);
  translate([-1, 0, top_z - hub_h * 0.5]) rotate([0, 90, 0]) cylinder(h = hub_d / 2 + 3, d = set_d);
  for (i = [0 : 5]) rotate([0, 0, i * 60]) translate([ring_r, 0, top_z - hub_h - 1])
    cylinder(h = hub_h + 2, d = ring_d);
}
